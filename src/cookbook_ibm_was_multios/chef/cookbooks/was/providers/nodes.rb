#
# Cookbook Name:: was
# Provider:: was_nodes
#
# Copyright IBM Corp. 2017, 2017
#
include WASWsadmin
include WASSearch

use_inline_resources

action :create_unmanaged do
  if @current_resource.unmanaged_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("create_unmanaged #{@new_resource}") do
      unless new_resource.admin_user.nil?
        raise 'Option admin_pwd must be specified in conjunction with option admin_user' if new_resource.admin_pwd.nil?
      end
      #specific input validation
      raise 'The path specified for option profile_path does not exist' unless ::File.exist?(new_resource.profile_path)
      raise 'Option cluster_name must be specified for action :create' if new_resource.node_name.nil?

      cmd_create_unmanaged = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.node_name}_unmanaged_node.jython")
      log cmd_create_unmanaged
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::WasNodes.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  #Get current state
  @current_resource.node_name(@new_resource.node_name)
  @current_resource.unmanaged_created = check_unmanaged_nodes?(@new_resource.node_name)
end

def check_unmanaged_nodes?(node_name)
  case node['os']
  when 'linux'
    cmd = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{node_name}_unmanaged_node_check.jython")
    /#{node_name}/.match(cmd)
  end
end
