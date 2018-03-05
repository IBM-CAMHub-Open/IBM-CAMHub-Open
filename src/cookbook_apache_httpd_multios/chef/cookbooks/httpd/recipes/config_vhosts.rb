# Cookbook Name:: httpd
# Recipe:: config_vhosts
#
# Copyright IBM Corp. 2016, 2017
#
# <> vhost configuration recipe (config_vhost.rb)
# <> Create vhost configuration file


dir_owner = node['httpd']['os_users']['web_content_owner']['name']
dir_owner.empty? && dir_owner = 'root'

# Disable default sites on ubuntu
['000-default', 'default-ssl'].each do |site|
  execute "disabling #{site}" do
    command "a2dissite #{site}"
    only_if { node['platform_family'] == 'debian' }
  end
end

# Create Vhost directories
virtual_hosts = node['httpd']['virtualhosts']


virtual_hosts.each do |vhost_name, vhost|

  next if node['httpd']['vhosts_enabled'] == 'false'

  directory "Creating document root for #{vhost_name}" do
    path vhost['document_root']
    action :create
    recursive true
    mode node['httpd']['data_dir_mode']
    owner dir_owner
    group node['httpd']['os_users']['daemon']['gid']
  end

  directory "Creating log directory for #{vhost_name}" do
    path vhost['log_dir']
    action :create
    recursive true
    mode '0750'
    owner 'root'
    group 'root'
  end

  template "Creating index.html for #{vhost_name}" do
    path "#{vhost['document_root']}/index.html"
    source 'index.html.erb'
    cookbook 'httpd' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
    owner 'root'
    group 'root'
    mode '0644'
  end

  # Configure SSL CErtificates

  if vhost['ssl_enabled'] == 'true'
    ssl = vhost['global_ssl_config'] == 'true' ? node['httpd']['ssl'] : vhost['ssl']
    cert_path = ssl['certificate_path']
    key_file  = ssl['certificate_name'] + ".key"
    cert_file = ssl['certificate_name'] + ".crt"
    cn = node['fqdn']

    # Create SSL directories

    directory "Creating certificate directory for #{vhost_name}" do
      path cert_path
      action :create
      recursive true
      owner 'root'
      group 'root'
    end

    case node['platform_family']
    when 'rhel', 'debian'
      # Generate certificate
      unless File.exist?("#{cert_path}/#{cert_file}")
        bash "Generate self-signed certificate for #{vhost_name}" do
          code <<-EOH
              openssl genrsa -out #{cert_path}/#{key_file} 2048
              openssl req -new -x509 -days 3650 -key #{cert_path}/#{key_file} -out #{cert_path}/#{cert_file} -subj '/CN=#{cn}'
              EOH
          only_if { vhost['ssl_enabled'] == 'true' }
          notifies :restart, "service[#{node['httpd']['service_name']}]"
        end
      end

    when 'windows'
      # TODO windows implementation
    end
  end

  template_dst = if node['platform_family'] == 'debian'
                   node['httpd']['server_root'] + '/sites-enabled/'
                 else
                   node['httpd']['server_root'] + '/conf.d/'
                 end
  
  #Enable proxy on debian
  ['proxy', 'proxy_http', 'proxy_balancer'].each do |mod|
    execute "enable #{mod}" do
      command "a2enmod #{mod}"
      only_if { node['httpd']['proxy'] || vhost['proxy'] }
      only_if { node['platform_family'] == 'debian' }
    end
  end

  # Create Vhost configuration file
  template "#{template_dst}#{vhost['server_name']}.conf" do
    source "vhost.conf.erb"
    cookbook 'httpd'
    owner 'root'
    group 'root'
    mode node['httpd']['conf_file_mode']
    variables(
      :log_dir => vhost['log_dir'],
      :vhost_port => vhost['vhost_listen'],
      :vhost_server_name => vhost['server_name'],
      :vhost_server_admin => vhost['server_admin'],
      :vhost_type => vhost['vhost_type'],
      :vhost_document_root => vhost['document_root'],
      :vhost_directory_index => node['httpd']['directory_index'],
      :vhost_error_log => vhost['error_log'],
      :vhost_custom_log => vhost['custom_log'],
      :vhost_custom_log_format => vhost['custom_log_format'],
      :vhost_ssl_enabled => vhost['ssl_enabled'],
      :ssl => vhost['global_ssl_config'] == 'true' ? node['httpd']['ssl'] : vhost['ssl'],
      :proxy_enabled => vhost['proxy_enabled'],
      :proxy => vhost['global_proxy_config'] == 'true' ? node['httpd']['proxy'] : vhost['proxy']
    )
    notifies :restart, "service[#{node['httpd']['service_name']}]", :immediate
  end

end
