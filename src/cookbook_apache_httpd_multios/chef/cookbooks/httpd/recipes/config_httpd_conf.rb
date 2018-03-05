# Cookbook Name:: httpd
# Recipe:: config_httpd_conf
#
# Copyright IBM Corp. 2016, 2017
#
# <> Configure httpd server recipe (config_httpd_conf.rb)
# <> Setup the main server configuration file

template_src = if node['httpd']['version'] == '2.4' && node['platform_version'].start_with?("7.")
                 'httpd24.conf.erb'
               elsif node['platform_family'] == 'debian'
                 'apache2.conf.erb'
               else
                 'httpd.conf.erb'
               end

template_dst = if node['platform_family'] == 'debian'
                   node['httpd']['server_root'] + '/apache2.conf'
               else
                   node['httpd']['server_root'] + '/conf/httpd.conf'
               end

template template_dst do
  source template_src
  cookbook 'httpd' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode node['httpd']['conf_file_mode']
  variables(
    :server_root => node['httpd']['server_root'],
    :listen => node['httpd']['listen'],
    :http_user => node['httpd']['os_users']['daemon']['name'],
    :http_group => node['httpd']['os_users']['daemon']['gid'],
    :server_admin => node['httpd']['server_admin'],
    :server_name => node['httpd']['server_name'],
    :document_root => node['httpd']['document_root'],
    :directory_index => node['httpd']['directory_index'],
    :log_dir => node['httpd']['log_dir'],
    :log_level => node['httpd']['log_level'],
    :error_log => node['httpd']['error_log'],
    :custom_log => node['httpd']['custom_log'],
    :custom_log_format => node['httpd']['custom_log_format'],
    :timeout => node['httpd']['timeout'],
    :keep_alive => node['httpd']['keep_alive'],
    :max_keep_alive_requests => node['httpd']['max_keep_alive_requests'],
    :keep_alive_timeout => node['httpd']['keep_alive_timeout'],
    :prefork_start_servers => node['httpd']['prefork_start_servers'],
    :prefork_min_spare_servers => node['httpd']['prefork_min_spare_servers'],
    :prefork_max_spare_servers => node['httpd']['prefork_max_spare_servers'],
    :prefork_server_limit => node['httpd']['prefork_server_limit'],
    :prefork_max_clients => node['httpd']['prefork_max_clients'],
    :prefork_max_requests_per_child => node['httpd']['prefork_max_requests_per_child'],
    :worker_start_servers => node['httpd']['worker_start_servers'],
    :worker_min_spare_servers => node['httpd']['worker_min_spare_servers'],
    :worker_max_spare_servers => node['httpd']['worker_max_spare_servers'],
    :worker_server_limit => node['httpd']['worker_server_limit'],
    :worker_max_clients => node['httpd']['worker_max_clients'],
    :worker_max_requests_per_child => node['httpd']['worker_max_requests_per_child'],
    :use_canonical_name => node['httpd']['use_canonical_name'],
    :hostname_lookups => node['httpd']['hostname_lookups'],
    :enable_MMAP => node['httpd']['enable_MMAP'],
    :enable_send_file => node['httpd']['enable_send_file'],
    :vhosts_enabled => node['httpd']['vhosts_enabled']
  )
  notifies :restart, "service[#{node['httpd']['service_name']}]", :immediate
end

template "/etc/apache2/ports.conf" do
  source "ports.conf.erb"
  cookbook 'httpd' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode node['httpd']['conf_file_mode']
  variables(
    :listen => node['httpd']['listen'],
    :listen_ssl => node['httpd']['ssl']['https_port']
  )
  only_if { node['platform_family'] == 'debian' }
  notifies :restart, "service[#{node['httpd']['service_name']}]", :immediate
end
