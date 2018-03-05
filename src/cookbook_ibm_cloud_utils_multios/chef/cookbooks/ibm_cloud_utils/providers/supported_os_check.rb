# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2016, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
include IBM::IBMHelper

use_inline_resources

def whyrun_supported?
  true
end

action :check do
  Chef::Log.debug('Check if pattern is supported on operating system of the vm')
  IBM::IBMHelper.verify_supported_os(node, new_resource.supported_os_list, new_resource.error_message)
  new_resource.updated_by_last_action(true)
end
