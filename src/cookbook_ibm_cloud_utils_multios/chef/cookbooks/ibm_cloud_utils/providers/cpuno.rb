# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2016
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################

use_inline_resources

def whyrun_supported?
  true
end

action :check do
  Chef::Log.debug('Check Number of CPUs')
  Chef::Log.debug("Number of CPUs Found: #{node['cpu']['total']}")
  Chef::Log.debug("Number of CPUs we need: #{new_resource.required}")
  errormessage ||= "Number of CPU's do not meet the minimum requirement of #{new_resource.required} CPUs available!"
  Chef::Application.fatal!(errormessage, 7176) if node['cpu']['total'].to_i < new_resource.required.to_i && !new_resource.continue
  Chef::Log.warn(errormessage) if node['cpu']['total'].to_i < new_resource.required.to_i && new_resource.continue

  new_resource.updated_by_last_action(true)
end
