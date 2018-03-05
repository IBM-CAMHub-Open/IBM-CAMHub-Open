# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
actions :zip
default_action :zip

attribute :source, :kind_of => String
attribute :target_zip, :kind_of => String

attr_accessor :exists
