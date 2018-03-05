# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
actions :check
default_action :check

attribute :path, :kind_of => String
attribute :required_space, :kind_of => [String, Integer]
attribute :error_message, :kind_of => String
attribute :continue, :kind_of => [TrueClass, FalseClass], :default => false

attr_accessor :exists
