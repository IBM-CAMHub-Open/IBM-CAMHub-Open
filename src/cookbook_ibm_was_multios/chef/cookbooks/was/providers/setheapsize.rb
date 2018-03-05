#
# Cookbook Name:: was
# Provider:: was_setheapsize
#
# Copyright IBM Corp. 2017, 2017
#
include WASHelper
include WASWsadmin
include WASSearch
use_inline_resources

action :set_initial_heap_size do
  if @current_resource.initial_heap_size
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("set_initial_heap_size #{@new_resource}") do
      unless new_resource.admin_user.nil?
        raise 'Option admin_pwd must be specified in conjunction with option admin_user' if new_resource.admin_pwd.nil?
      end
      case new_resource.profile_type
      when "standalone"
        #run jython to set initial heap size
        cmd_initial_heap_size = run_jython_block_standalone(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.property_name_initial}_jvmproperty_set.jython")
        log cmd_initial_heap_size
      when "dmgr", "nodeagent"
        #run jython to set initial heap size
        cmd_initial_heap_size = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.property_name_initial}_jvmproperty_set.jython")
        log cmd_initial_heap_size
      end
    end
  end
end

action :set_maximum_heap_size do
  if @current_resource.maximum_heap_size
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("set_maximum_heap_size #{@new_resource}") do
      unless new_resource.admin_user.nil?
        raise 'Option admin_pwd must be specified in conjunction with option admin_user' if new_resource.admin_pwd.nil?
      end
      case new_resource.profile_type
      when "standalone"
        #run jython to set maximum heap size
        cmd_maximum_heap_size = run_jython_block_standalone(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.property_name_maximum}_jvmproperty_set.jython")
        log cmd_maximum_heap_size
      when "dmgr", "nodeagent"
        cmd_maximum_heap_size = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{new_resource.property_name_maximum}_jvmproperty_set.jython")
        log cmd_maximum_heap_size
      end
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::WasSetheapsize.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  #Get current state
  @current_resource.property_name_initial(@new_resource.property_name_initial)
  @current_resource.property_value_initial(@new_resource.property_value_initial)
  @current_resource.property_name_initial(@new_resource.property_name_maximum)
  @current_resource.property_name_initial(@new_resource.property_value_maximum)
  @current_resource.property_name_initial(@new_resource.profile_type)
  @current_resource.initial_heap_size = check_heap_size?(@new_resource.property_name_initial, @new_resource.property_value_initial, @new_resource.profile_type)
  @current_resource.maximum_heap_size = check_heap_size?(@new_resource.property_name_maximum, @new_resource.property_value_maximum, @new_resource.profile_type)
end

def check_heap_size?(property_name, property_value, profile_type)
  case node['os']
  when 'linux'
    case profile_type
    when "standalone"
      cmd = run_jython_block_standalone(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{property_name}_jvmproperty_get.jython")
    when "dmgr", "nodeagent"
      cmd = run_jython_block(new_resource.os_user, new_resource.profile_path, new_resource.admin_user, new_resource.admin_pwd, "#{property_name}_jvmproperty_get.jython")
    end
    /#{property_value}/.match(cmd)
  end
end
