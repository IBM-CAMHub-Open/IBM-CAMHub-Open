#
# Cookbook Name:: was
# Provider:: was_cluster
#
# Copyright IBM Corp. 2017, 2017
#
include WASWsadmin
include WASSearch

use_inline_resources

action :create do
  if @current_resource.cluster_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("create_cluster #{@new_resource}") do
      unless new_resource.admin_user.nil?
        raise 'Option admin_pwd must be specified in conjunction with option admin_user' if new_resource.admin_pwd.nil?
      end
      #specific input validation
      raise 'Option cluster_name must be specified for action :create' if new_resource.cluster_name.nil?

      cmd_create_cluster = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.cluster_name}_cluster_create.jython")
      log cmd_create_cluster
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::WasCluster.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  #Get current state
  @current_resource.cluster_name(@new_resource.cluster_name)
  @current_resource.cluster_created = check_cluster?(@new_resource.cluster_name)
end

def check_cluster?(cluster_name)
  case node['os']
  when 'linux'
    cmd = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{cluster_name}_cluster_check.jython")
    /#{cluster_name}/.match(cmd)
  end
end
