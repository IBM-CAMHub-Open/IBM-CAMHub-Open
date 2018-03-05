# Cookbook Name:: ihs
# Recipe:: config_admin_conf
#
# Copyright IBM Corp. 2016, 2017
#

# <> Configure admin server recipe (config_admin_conf.rb)
# <> Create admin.conf and service script for the admin server

require 'chef-vault'

install_dir = node['ihs']['install_dir']
version = node['ihs']['version'].split('.').first.to_s
chef_vault = node['ihs']['vault']['name']
encrypted_id = node['ihs']['vault']['encrypted_id']
admin_user = node['ihs']['admin_server']['username']

# Admin server needs write access to conf dir
execute 'set ownership on conf dir' do
  command "chown -R #{node['ihs']['os_users']['ihs']['name']}:#{node['ihs']['os_users']['ihs']['gid']} #{install_dir}/conf"
  only_if { ihs_first_run? }
  only_if { node['ihs']['admin_server']['enabled'].to_s == 'true' }
end

if node['ihs']['admin_server']['enabled'].to_s == 'true'
  # Retrieve password from vault
  admin_pwd = chef_vault_item(chef_vault, encrypted_id)['ihs']['admin_server']['password'].to_s
  # ... and fail if none present
  raise "No password found for IHS admin in vault #{chef_vault}" if admin_pwd.empty?
  # Create password db
  ihs_htpasswd_db "update password database #{install_dir}/conf/admin.passwd with credentials for user #{admin_user}" do
    htpasswd_path "#{install_dir}/bin"
    htpasswd_db "#{install_dir}/conf/admin.passwd"
    owner node['ihs']['os_users']['ihs']['name']
    group node['ihs']['os_users']['ihs']['gid']
    user admin_user
    password admin_pwd
    only_if { node['ihs']['admin_server']['enabled'].to_s == 'true' }
  end
end

# Manage configuration file
template "#{install_dir}/conf/admin.conf" do
  source "admin.conf.v#{version}.erb"
  mode node['ihs']['os_perms']
  variables(
    :ADMINUSER => node['ihs']['os_users']['ihs']['name'],
    :ADMINGROUP => node['ihs']['os_users']['ihs']['gid'],
    :ADMINDOCROOT => node['ihs']['admin_server']['document_root'],
    :SERVERNAME => node['ihs']['admin_server']['server_name'],
    :ADMINPORT => node['ihs']['admin_server']['port'],
    :SERVERROOT => node['ihs']['install_dir']
  )
  only_if { node['ihs']['admin_server']['enabled'].to_s == 'true' }
  notifies :write, 'log[Restarting admin server]', :immediately
end

# Notify service, except in the first run.
log 'Restarting admin server' do
  action :nothing
  not_if { ihs_first_run? }
  only_if { node['ihs']['config_os_service'] == 'true' }
  notifies :restart, "service[#{node['ihs']['admin_server']['service_name']}]" if node['ihs']['admin_server']['enabled'].to_s == 'true'
end
