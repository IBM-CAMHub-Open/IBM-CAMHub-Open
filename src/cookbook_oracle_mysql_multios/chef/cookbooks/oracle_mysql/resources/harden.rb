
#
# Cookbook Name:: oracle_mysql
# Resource:: harden
#
# Copyright IBM Corp. 2017, 2017
#

actions :set, :change
default_action :set

attribute :password, :kind_of => String, :default => node['mysql']['root_password']
attribute :service_name, :kind_of => String, :default => node['mysql']['service_name']
attribute :log_file, :kind_of => String, :default => node['mysql']['config']['log_file']
attribute :version, :kind_of => String, :default => node['mysql']['version']
attribute :data_dir, :kind_of => String, :default => node['mysql']['config']['data_dir']
attribute :new_password, :kind_of => String, :default => node['mysql']['root_password']

attr_accessor :mysql_installed
