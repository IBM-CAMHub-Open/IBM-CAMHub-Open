# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
actions :copy, :exec
default_action :copy

attribute :server, :kind_of => String
attribute :user,   :kind_of => String
attribute :password, :kind_of => String
attribute :source, :kind_of => String, :default => nil
attribute :target, :kind_of => String, :default => nil
attribute :command, :kind_of => String, :default => nil
attribute :only_if_check, :kind_of => String, :default => nil
attribute :not_if_check, :kind_of => String, :default => nil
attribute :remove_local, :kind_of => [TrueClass, FalseClass], :default => false

attr_accessor :exists
