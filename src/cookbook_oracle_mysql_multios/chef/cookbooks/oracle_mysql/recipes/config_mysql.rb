#
# Cookbook Name:: oracle_mysql
# Recipe:: config_mysql
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install.rb)
# <> This recipe performs the product installation.

# Initialize vault
require 'chef-vault'

user_data = {}
root_password = ''
node['mysql']['config']['databases'].each do |db_index, database|
  database['users'].each do |usr_index, user|
    user_password = node['mysql']['config']['databases'][db_index]['users'][usr_index]['password']
    encrypted_id = node['mysql']['vault']['encrypted_id']
    chef_vault = node['mysql']['vault']['name']
    unless chef_vault.empty?
      require 'chef-vault'
      root_password = chef_vault_item(chef_vault, encrypted_id)['mysql']['root_password']
      user_password = chef_vault_item(chef_vault, encrypted_id)['mysql']['config']['databases'][db_index]['users'][usr_index]['password']
      raise "No password found for MySQL root user in chef vault \'#{chef_vault}\'" if root_password.empty?
      raise "No password found for MySQL default user in chef vault \'#{chef_vault}\'" if user_password.empty?
      Chef::Log.info "Found a password for MySQL root/default user in chef vault \'#{chef_vault}\'"
    end
    user_data[user['name']] = user_password
  end
end

# Create the default database if it doesn't exist
node['mysql']['config']['databases'].each_pair do |_key, database|
  oracle_mysql_database database['database_name'] do
    action :create
    name database['database_name']
    conn_password root_password
    data_dir node['mysql']['config']['data_dir']
    version node['mysql']['version']
    not_if { database_exists?(name, data_dir, version, 'root', root_password) }
  end


  # Create the default users and assign passwords if they don't exist
  database['users'].each_pair do |_key, user|
    oracle_mysql_user user['name'] do
      action :create
      name user['name']
      password user_data[user['name']]
      conn_password root_password
      data_dir node['mysql']['config']['data_dir']
      version node['mysql']['version']
      not_if { user_exists?(name, data_dir, version, 'root', root_password) }
    end
  end
end
