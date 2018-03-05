#
# Cookbook Name:: was
# Provider:: was_cluster
#
# Copyright IBM Corp. 2017, 2017
#
actions :create, :start
default_action :create

attribute :profile_type, :kind_of => String, :default => nil
attribute :profile_path, :kind_of => String, :default => nil
attribute :admin_user, :kind_of => String, :default => nil
attribute :admin_pwd, :kind_of => String, :default => nil # ~password_checker
attribute :os_user, :kind_of => String, :default => nil
attribute :cluster_name, :kind_of => String, :default => nil


attr_accessor :cluster_created
attr_accessor :cluster_started
