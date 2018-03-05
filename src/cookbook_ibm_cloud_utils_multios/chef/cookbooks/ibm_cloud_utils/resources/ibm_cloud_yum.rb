# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
actions :install, :upgrade, :purge
default_action :install

attribute :package_name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String
attribute :source, :kind_of => String
attribute :options, :kind_of => String

attr_accessor :exists
