#
# Cookbook Name:: db2
# Provider:: db2_service
#
# Copyright IBM Corp. 2017, 2017
#
include DB2::Helper
use_inline_resources

action :stop_das do
  if @current_resource.db2_das_stopped
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Stopping DAS #{@new_resource}") do
      Chef::Log.debug "stop_das params: das_user: #{new_resource.das_user}"
      cmd = shell_out!("su - #{new_resource.das_user} -c 'db2admin stop /FORCE'")
      cmd.stderr.empty?
    end
  end
end

action :start_das do
  if @current_resource.db2_das_started
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Starting DAS #{@new_resource}") do
      Chef::Log.debug "start_das params: das_user: #{new_resource.das_user}"
      cmd = shell_out!("su - #{new_resource.das_user} -c 'db2admin start'")
      cmd.stderr.empty?
    end
  end
end

action :stop_instance do
  if @current_resource.db2_instance_stopped || @current_resource.db2_list_instances.empty?
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Stopping instance #{@new_resource}") do
      Chef::Log.debug "db2_stop_instance params: instance: #{new_resource.instance_username}"
      cmd = shell_out!("su - #{new_resource.instance_username} -c 'db2 force applications all; db2 terminate; db2stop'")
      cmd.stderr.empty?
    end
  end
end

action :start_instance do
  if @current_resource.db2_instance_started || @current_resource.db2_list_instances.empty?
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Starting instance #{@new_resource}") do
      Chef::Log.debug "db2_start_instance params: instance: #{new_resource.instance_username}"
      cmd = shell_out!("su - #{new_resource.instance_username} -c 'db2start'")
      cmd.stderr.empty?
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::Db2Service.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.instance_username(@new_resource.instance_username)

  #Get current state
  @current_resource.db2_list_instances = db2_list_instances(@new_resource.db2_install_dir)
  @current_resource.db2_das_started = db2_das_started?
  @current_resource.db2_das_stopped = db2_das_stopped?
  @current_resource.db2_instance_started = db2_instance_started?(@new_resource.instance_username)
  @current_resource.db2_instance_stopped = db2_instance_stopped?(@new_resource.instance_username)
end
