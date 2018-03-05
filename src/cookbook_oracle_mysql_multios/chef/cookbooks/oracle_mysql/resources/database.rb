
#
# Cookbook Name:: oracle_mysql
# Resource:: database
#
# Copyright IBM Corp. 2017, 2017
#

actions :create, :update, :remove
default_action :create

attribute :conn_password, :kind_of => String, :default => node['mysql']['root_password']
attribute :version, :kind_of => String, :default => node['mysql']['version']
attribute :data_dir, :kind_of => String, :default => node['mysql']['config']['data_dir']
attribute :name, :kind_of => String, :default => node['mysql']['config']['databases']['database_1']['database_name']

attr_accessor :mysql_installed
attr_accessor :database_exists
