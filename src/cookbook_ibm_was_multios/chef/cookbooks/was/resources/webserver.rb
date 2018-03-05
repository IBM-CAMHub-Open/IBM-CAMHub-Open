#
# Cookbook Name:: was
# Provider:: was_webserver
#
# Copyright IBM Corp. 2017, 2017
#
actions :create
default_action :create

attribute :profile_type, :kind_of => String, :default => nil
attribute :profile_path, :kind_of => String, :default => nil
attribute :admin_user, :kind_of => String, :default => nil
attribute :admin_pwd, :kind_of => String, :default => nil # ~password_checker
attribute :os_user, :kind_of => String, :default => nil
attribute :webserver_name, :kind_of => String, :default => nil


attr_accessor :webserver_created
