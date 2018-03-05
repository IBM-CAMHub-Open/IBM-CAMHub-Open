# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2016, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
actions :check
default_action :check


attribute :supported_os_list, :kind_of => Hash
attribute :error_message, :kind_of => String

attr_accessor :exists
