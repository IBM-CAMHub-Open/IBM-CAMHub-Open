#
# Cookbook Name:: ibm_cloud_utils
# Provider:: hostsfile_update
#
# Copyright IBM Corp. 2017, 2017
#

include IBM::IBMHelper

use_inline_resources

def whyrun_supported?
  true
end

action :updateshosts do
  #stack_id = new_resource.stack_id
  stack_id = node['ibm_internal']['stack_id']
  query = "stack_id:#{stack_id}"
  unless stack_id == '' || stack_id.empty? || stack_id.nil?
    Chef::Log.info("Search for all the nodes in stack")
    Chef::Config[:solo] == true ? (nodes = []) : (nodes = search(:node, query))
    nodes.each do |n|
      n['hostname'] == n['fqdn'] ? (line = "#{n['ipaddress']} #{n['fqdn']}") : (line = "#{n['ipaddress']} #{n['fqdn']} #{n['hostname']}")
      Chef::Log.info("Adding #{line} to hosts file if not present")
      hostsfile = Chef::Util::FileEdit.new(node['ibm']['hostsfile_location'])
      hostsfile.insert_line_if_no_match(/#{n['ipaddress']}/, line)
      hostsfile.search_file_delete_line(/127.0.1.1/) if node['platform_family'] == "debian"
      hostsfile.write_file
      Chef::Log.info("Updated the hosts file")
    end
  end
  new_resource.updated_by_last_action(true)
end
