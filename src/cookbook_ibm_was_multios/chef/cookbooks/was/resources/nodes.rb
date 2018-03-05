#
# Cookbook Name:: was
# Provider:: was_nodes
#
# Copyright IBM Corp. 2017, 2017
#
actions :create_unmanaged
default_action :create_unmanaged

attribute :profile_type, :kind_of => String, :default => nil
attribute :profile_path, :kind_of => String, :default => nil
attribute :admin_user, :kind_of => String, :default => nil
attribute :admin_pwd, :kind_of => String, :default => nil # ~password_checker
attribute :os_user, :kind_of => String, :default => nil
attribute :node_name, :kind_of => String, :default => nil


attr_accessor :unmanaged_created
