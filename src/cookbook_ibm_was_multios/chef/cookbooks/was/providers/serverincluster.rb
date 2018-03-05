#
# Cookbook Name:: was
# Provider:: was_serverincluster
#
# Copyright IBM Corp. 2017, 2017
#
include WASWsadmin
include WASSearch

use_inline_resources

action :create do
  if @current_resource.server_in_cluster_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("create_server_in_cluster #{@new_resource}") do
      unless new_resource.admin_user.nil?
        raise 'Option admin_pwd must be specified in conjunction with option admin_user' if new_resource.admin_pwd.nil?
      end
      #specific input validation
      raise 'Option server_name must be specified for action :create' if new_resource.server_name.nil?

      #run jython
      cmd_create_server_in_cluster = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.server_name}_appserver_in_cluster_create.jython")
      log cmd_create_server_in_cluster
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::WasServerincluster.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  #Get current state
  @current_resource.server_name(@new_resource.server_name)
  @current_resource.node_name(@new_resource.node_name)
  @current_resource.server_in_cluster_created = check_server_in_cluster?(@new_resource.server_name, @new_resource.node_name)
end

def check_server_in_cluster?(server_name, node_name)
  case node['os']
  when 'linux'
    cmd = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{server_name}_appserver_in_cluster_check.jython")
    /#{node_name}_#{server_name}/.match(cmd)
  end
end
