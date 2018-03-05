########################################################
# Copyright IBM Corp. 2016, 2017
########################################################
#
# Cookbook Name:: wasliberty
###############################################################################
actions :start, :stop
default_action :start

attribute :name, :kind_of => String, :name_attribute => true
attribute :install_dir, :kind_of => String
attribute :timeout, :kind_of => String, :default => '30'
attribute :force_restart, :kind_of => [TrueClass, FalseClass], :default => false
attribute :jvm_options, :kind_of => String
attribute :user, :kind_of => String
