#
# Cookbook Name:: db2
# Provider:: db2_database
#
# Copyright IBM Corp. 2017, 2017
#
actions :create, :remove
default_action :create

attribute :db_name, :kind_of => String, :default => nil
attribute :db2_install_dir, :kind_of => String, :default => node['db2']['install_dir']
attribute :instance_username, :kind_of => String, :default => nil
attribute :instance_groupname, :kind_of => String, :default => nil
attribute :db_data_path, :kind_of => String, :default => nil
attribute :db_path, :kind_of => String, :default => ''
attribute :log_dir, :kind_of => String, :default => node['ibm']['log_dir']
attribute :pagesize, :kind_of => String, :default => ''
attribute :territory, :kind_of => String, :default => ''
attribute :codeset, :kind_of => String, :default => ''
attribute :db_collate, :kind_of => String, :default => ''
attribute :database_update, :kind_of => Hash, :default => {}
attribute :database_users, :kind_of => Hash, :default => {}
attribute :instance_key, :kind_of => String, :default => ''
attribute :database_key, :kind_of => String, :default => ''

attr_accessor :db2_database_created
attr_accessor :db2_instance_created
