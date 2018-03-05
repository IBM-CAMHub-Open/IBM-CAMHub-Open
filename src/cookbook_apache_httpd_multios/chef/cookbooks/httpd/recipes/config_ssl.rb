# Cookbook Name:: httpd
# Recipe:: config_ssl
#
# Copyright IBM Corp. 2016, 2017
#
# <> SSL configuration recipe (config_proxy.rb)
# <> Install mod_ssl, create SSL configuration file, create certificates

# SSL configuration


virtual_hosts = node['httpd']['virtualhosts']
http_uniqueports = []
https_uniqueports = []

virtual_hosts.each do |_key, vhost|
  next if node['httpd']['vhosts_enabled'] == 'false'
  port = vhost['vhost_listen']
  if vhost['ssl_enabled'] == 'false' && (!http_uniqueports.include? port)
    http_uniqueports.push(port)
  elsif vhost['ssl_enabled'] == 'true' && (!https_uniqueports.include? port)
    https_uniqueports.push(port)
  end
end

template_dst = if node['platform_family'] == 'debian'
                   node['httpd']['server_root'] + '/mods-enabled'
               else
                   node['httpd']['server_root'] + '/conf.d'
               end

template "#{template_dst}/ssl.conf" do
  source 'ssl.conf.erb'
  cookbook 'httpd' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode node['httpd']['conf_file_mode']
  variables(
    :https_uniqueports => https_uniqueports,
    :http_uniqueports => http_uniqueports
  )
  notifies :restart, "service[#{node['httpd']['service_name']}]"
end
