#
# Cookbook Name:: oracle_mysql
# Recipe:: harden
#
# Copyright IBM Corp. 2016, 2017
#
# <> Product hardening recipe (harden.rb)
# <> This recipe performs security hardening tasks.

require 'chef-vault'
encrypted_id = node['mysql']['vault']['encrypted_id']
chef_vault = node['mysql']['vault']['name']
unless chef_vault.empty?
  require 'chef-vault'
  root_password = chef_vault_item(chef_vault, encrypted_id)['mysql']['root_password']
  raise "No password found for MySQL root user in chef vault \'#{chef_vault}\'" if root_password.empty?
  Chef::Log.info "Found a password for MySQL root user in chef vault \'#{chef_vault}\'"
end

# <> This custom resource changes the default MySQL root password
oracle_mysql_harden "Change the default root password" do
  action :set
  password root_password
  service_name node['mysql']['service_name']
  data_dir node['mysql']['config']['data_dir']
  log_file node['mysql']['config']['log_file']
  version node['mysql']['version']
  not_if { credential_check?(node['mysql']['config']['data_dir'], 'root', root_password) }
end
