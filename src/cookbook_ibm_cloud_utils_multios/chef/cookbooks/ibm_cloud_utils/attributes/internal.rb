# encoding: UTF-8
########################################################
#	  Copyright IBM Corp. 2017, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
#

case node['platform_family']
when 'rhel', 'debian'
  force_default['ibm']['hostsfile_location'] = '/etc/hosts'
when 'windows'
  force_default['ibm']['hostsfile_location'] = 'c:\Windows\System32\Drivers\etc\hosts'
end
