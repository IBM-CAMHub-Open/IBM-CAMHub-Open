# Cookbook Name:: ihs
# Recipe:: config_httpd_conf
#
# Copyright IBM Corp. 2016, 2017
#

# <> Main server configuration recipe (config_httpd_conf.rb)
# <> Configure main server and service file

version = node['ihs']['version'].split('.').first.to_s

# Create configuration file from template
template "#{node['ihs']['install_dir']}/conf/httpd.conf" do
  source "httpd.conf.v#{version}.erb"
  mode node['ihs']['os_perms']
  variables(
    :USER => node['ihs']['os_users']['ihs']['name'],
    :GROUP => node['ihs']['os_users']['ihs']['gid'],
    :DOCUMENTROOT => node['ihs']['document_root'],
    :SERVERNAME => node['ihs']['server_name'],
    :PORT => node['ihs']['port'],
    :SERVERADMIN => node['ihs']['server_admin'],
    :SERVERROOT => node['ihs']['install_dir']
  )
  notifies :write, 'log[Restarting httpd]', :immediately
  not_if { node['ihs']['plugin']['enabled'].to_s == 'true' && !ihs_first_run? }
end

# Notify service, except in the first run.
log 'Restarting httpd' do
  action :nothing
  only_if { !ihs_first_run? && (node['ihs']['config_os_service'] == 'true') }
  notifies :restart, "service[#{node['ihs']['service_name']}]"
end

# Create document root if it doesn't exist
directory node['ihs']['document_root'] do
  recursive true
  owner node['ihs']['os_users']['ihs']['name']
  group node['ihs']['os_users']['ihs']['gid']
  mode node['ihs']['os_perms']
  action :create
end

# Copy contents of installed htdocs to docroot, if not default
execute 'populate_docroot' do
  cwd node['ihs']['document_root']
  command "cp -fR #{node['ihs']['install_dir']}/htdocs/* . && chown -R  #{node['ihs']['os_users']['ihs']['name']}:#{node['ihs']['os_users']['ihs']['gid']} ."
  only_if { (Dir.entries(node['ihs']['document_root']) - %w(. ..)).empty? }
end

# Create directory for auxiliary config files
directory "#{node['ihs']['install_dir']}/conf.d" do
  action :create
  recursive true
  mode node['ihs']['os_perms']
  owner node['ihs']['os_users']['ihs']['name']
  group node['ihs']['os_users']['ihs']['gid']
end

# Workaround for 9.0 failing when conf.d is empty
file "#{node['ihs']['install_dir']}/conf.d/dummy.conf" do
  action :create
  mode node['ihs']['os_perms']
  group node['ihs']['os_users']['ihs']['gid']
  only_if { (Dir.entries("#{node['ihs']['install_dir']}/conf.d") - %w(. ..)).empty? }
end
