#
# Cookbook Name:: was
# Provider:: was_serverincluster
#
# Copyright IBM Corp. 2017, 2017
#
actions :create, :create_server_in_cluster
default_action :create

attribute :profile_type, :kind_of => String, :default => nil
attribute :profile_path, :kind_of => String, :default => nil
attribute :admin_user, :kind_of => String, :default => nil
attribute :admin_pwd, :kind_of => String, :default => nil # ~password_checker
attribute :os_user, :kind_of => String, :default => nil
attribute :server_name, :kind_of => String, :default => nil
attribute :node_name, :kind_of => String, :default => nil

attr_accessor :server_in_cluster_created
