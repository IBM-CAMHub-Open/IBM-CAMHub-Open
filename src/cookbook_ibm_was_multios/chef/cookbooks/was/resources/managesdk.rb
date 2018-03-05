#
# Cookbook Name:: was
# Provider:: was_managesdk
#
# Copyright IBM Corp. 2017, 2017
#
actions :setCommandDefault, :setNewProfileDefault
default_action :setCommandDefault

attribute :java_version, :kind_of => String, :default => node['was']['java_version']
attribute :install_dir, :kind_of => String, :default => node['was']['install_dir']
attribute :admin_user, :kind_of => String, :default => node['was']['os_users']['was']['name']

attr_accessor :sdkCommandDefault
attr_accessor :sdkNewProfileDefault
