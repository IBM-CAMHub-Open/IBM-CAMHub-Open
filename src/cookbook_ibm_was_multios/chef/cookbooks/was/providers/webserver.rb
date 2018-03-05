#
# Cookbook Name:: was
# Provider:: was_webserver
#
# Copyright IBM Corp. 2017, 2017
#
include WASWsadmin
include WASSearch

use_inline_resources

action :create do
  if @current_resource.webserver_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("create_webserver #{@new_resource}") do
      unless new_resource.admin_user.nil?
        raise 'Option admin_pwd must be specified in conjunction with option admin_user' if new_resource.admin_pwd.nil?
      end
      #specific input validation
      raise 'Option server_name must be specified for action :create' if new_resource.webserver_name.nil?

      cmd_create_cluster = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.webserver_name}_webserver.jython")
      log cmd_create_cluster
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::WasWebserver.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  #Get current state
  @current_resource.webserver_name(@new_resource.webserver_name)
  @current_resource.webserver_created = check_webserver?(@new_resource.webserver_name)
end

def check_webserver?(webserver_name)
  case node['os']
  when 'linux'
    cmd = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{webserver_name}_webserver_check.jython")
    /#{webserver_name}/.match(cmd)
  end
end
