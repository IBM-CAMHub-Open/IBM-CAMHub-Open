# Cookbook Name:: was
# Library:: was_search
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: WAS search
# <> Library Functions for the WAS Cookbook
module WASSearch
  # Helper functions for WAS cookbook
  include Chef::Mixin::ShellOut

  # Library function to get the dmgr,ihs hostname in a stck based on role name
  def chef_searchhostname(role_name)
    query = "stack_id:#{node['ibm_internal']['stack_id']} AND role:#{role_name}"
    Chef::Log.info("Search for hostname with rolename")
    Chef::Config[:solo] == true ? (nodes = []) : (nodes = search(:node, query))
    nodes.each do |n|
      hostname = n['fqdn']
      Chef::Log.info("#{hostname} derived from chefsearch based on stakid and rolename")
      return hostname
    end
  end

  # Library function to get the dmgr port number based on role name and node attribute from dmgr host in a stack
  def chef_searchdmgrport(role_name)
    query = "stack_id:#{node['ibm_internal']['stack_id']} AND role:#{role_name}"
    Chef::Log.info("Search for dmgr port with rolename")
    Chef::Config[:solo] == true ? (nodes = []) : (nodes = search(:node, query))
    nodes.each do |n|
      port = n['was']['profiles']['dmgr']['ports']['SOAP_CONNECTOR_ADDRESS']
      Chef::Log.info("#{port} derived from chefsearch based on stakid and rolename")
      return port
    end
  end

  def chef_searchihshostname(role_names)
    role_names.each do |role|
      query = "stack_id:#{node['ibm_internal']['stack_id']} AND role:#{role}"
      Chef::Log.info("Search for hostname with rolename")
      Chef::Config[:solo] == true ? (nodes = []) : (nodes = search(:node, query))
      nodes.each do |n|
        hostname = n['fqdn']
        Chef::Log.info("#{hostname} ihs hostname derived from chefsearch based on stakid and rolename")
        return hostname
      end
    end
  end
end



Chef::Recipe.send(:include, WASSearch)
Chef::Resource.send(:include, WASSearch)
