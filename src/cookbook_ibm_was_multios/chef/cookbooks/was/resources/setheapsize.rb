#
# Cookbook Name:: was
# Provider:: was_setheapsize
#
# Copyright IBM Corp. 2017, 2017
#
actions :set_initial_heap_size, :set_maximum_heap_size
default_action :set_initial_heap_size

attribute :profile_type, :kind_of => String, :default => nil
attribute :profile_path, :kind_of => String, :default => nil
attribute :admin_user, :kind_of => String, :default => nil
attribute :admin_pwd, :kind_of => String, :default => nil # ~password_checker
attribute :os_user, :kind_of => String, :default => nil
attribute :property_name_initial, :kind_of => String, :default => 'initialHeapSize'
attribute :property_value_initial, :kind_of => String, :default => nil
attribute :property_name_maximum, :kind_of => String, :default => 'maximumHeapSize'
attribute :property_value_maximum, :kind_of => String, :default => nil
attribute :node_name, :kind_of => String, :default => nil
attribute :server_name, :kind_of => String, :default => nil

attr_accessor :initial_heap_size
attr_accessor :maximum_heap_size
