# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
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
  IBM::IBMHelper.check_free_space(node, new_resource.path, new_resource.required_space, new_resource.continue, new_resource.error_message)
  new_resource.updated_by_last_action(true)
end
