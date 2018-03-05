#
# Cookbook Name:: db2
# Provider:: db2_instance
#
# Copyright IBM Corp. 2017, 2017
#
actions :create, :remove
default_action :create

attribute :instance_prefix, :kind_of => String, :default => nil
attribute :db2_install_dir, :kind_of => String, :default => node['db2']['install_dir']
attribute :instance_type, :kind_of => String, :default => nil
attribute :instance_username, :kind_of => String, :default => nil
attribute :instance_groupname, :kind_of => String, :default => nil
attribute :instance_password, :kind_of => String, :default => nil
attribute :instance_dir, :kind_of => String, :default => ''
attribute :port, :kind_of => String, :default => nil
attribute :fenced_username, :kind_of => String, :default => nil
attribute :fenced_groupname, :kind_of => String, :default => nil
attribute :fenced_password, :kind_of => String, :default => nil
attribute :fcm_port, :kind_of => String, :default => nil
attribute :log_dir, :kind_of => String, :default => node['db2']['expand_area'] + '/log'
attribute :rsp_file_path, :kind_of => String, :default => node['db2']['expand_area'] + '/tmp'

attr_accessor :db2_instance_created
