# Cookbook Name:: ihs
# Recipe:: config_ssl_selfsigned
#
# Copyright IBM Corp. 2016, 2017
#

# <> SSL configuration recipe (config_ssl_selfsigned.rb)
# <> Configure a SSL vhost and associated self-signed certificates

require 'chef-vault'

install_dir = node['ihs']['install_dir']
chef_vault = node['ihs']['vault']['name']
encrypted_id = node['ihs']['vault']['encrypted_id']
keystore = node['ihs']['ssl']['keystore']
keystore_password = ''
label = node['ihs']['ssl']['cert_label']

# Collect data from chef-vault
if node['ihs']['ssl']['enabled'].to_s == 'true' && node['ihs']['admin_server']['enabled'].to_s == 'false'
  # Retrieve password from vault
  keystore_password = chef_vault_item(chef_vault, encrypted_id)['ihs']['ssl']['keystore_password'].to_s
  # ... and fail if none present
  raise "No password found for GSKIT in vault #{chef_vault}" if keystore_password.empty?
end

# Manage GSKIT keystore
execute 'create-key-db' do
  command "./gsk8capicmd_64 -keydb -create -db #{keystore} -pw #{keystore_password} -type cms -expire 3650 -stash"
  creates keystore
  user node['ihs']['os_users']['ihs']['name'] if node['ihs']['install_mode'] != 'admin'
  group node['ihs']['os_users']['ihs']['gid'] if node['ihs']['install_mode'] != 'admin'
  cwd "#{install_dir}/gsk8/bin"
  environment 'LD_LIBRARY_PATH' => "#{ENV['LD_LIBRARY_PATH']}:#{install_dir}/gsk8/lib64"
  sensitive true
  only_if { node['ihs']['ssl']['enabled'].to_s == 'true' && node['ihs']['admin_server']['enabled'].to_s == 'false' }
end

# Create self-signed certificate
execute 'create-self-signed-cert' do
  command "./gsk8capicmd_64 -cert -create -db #{keystore} -pw #{keystore_password} -size 2048 -dn \"CN=#{node['hostname']}\" -label \"#{label}\" -expire 3650 -ca true -default_cert yes"
  cwd "#{install_dir}/gsk8/bin"
  user node['ihs']['os_users']['ihs']['name'] if node['ihs']['install_mode'] != 'admin'
  group node['ihs']['os_users']['ihs']['gid'] if node['ihs']['install_mode'] != 'admin'
  environment 'LD_LIBRARY_PATH' => "#{ENV['LD_LIBRARY_PATH']}:#{install_dir}/gsk8/lib64"
  sensitive true
  only_if { node['ihs']['ssl']['enabled'].to_s == 'true' && node['ihs']['admin_server']['enabled'].to_s == 'false' }
  not_if "#{install_dir}/gsk8/bin/gsk8capicmd_64 -cert -list -db #{keystore} -pw #{keystore_password} -label \"#{label}\"", :environment => { 'LD_LIBRARY_PATH' => "#{install_dir}/gsk8/lib64" } # ~password_checker
end

# Create SSL vhost configuration file
template "#{install_dir}/conf.d/ssl.conf" do
  source 'ssl.conf.erb'
  owner node['ihs']['os_users']['ihs']['name'] if node['ihs']['install_mode'] != 'admin'
  group node['ihs']['os_users']['ihs']['gid'] if node['ihs']['install_mode'] != 'admin'
  variables(
    :SSLPORT => node['ihs']['ssl']['port'],
    :KEYSTORE => node['ihs']['ssl']['keystore']
  )
  only_if { node['ihs']['ssl']['enabled'].to_s == 'true' && node['ihs']['admin_server']['enabled'].to_s == 'false' }
  notifies :write, 'log[Restarting httpd due to SSL config changes]', :immediately
end

# Notify service, except in the first run.
log 'Restarting httpd due to SSL config changes' do
  action :nothing
  only_if { !ihs_first_run? && (node['ihs']['config_os_service'] == 'true') }
  notifies :restart, "service[#{node['ihs']['service_name']}]"
end
