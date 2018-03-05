#
# Cookbook Name:: db2
# Provider:: db2_service
#
# Copyright IBM Corp. 2017, 2017
#
include DB2::Helper
use_inline_resources

action :install do
  if @current_resource.db2_fp_installed
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Install fixpack #{@new_resource}") do
      # Download DB2 fixpack package
      Chef::Log.info("DB2 FP #{new_resource.fixpack} will be installed")
      node['db2']['fixpack_names'].each do |v, package|
        next if v.to_s != new_resource.db2_base_version
        fp_filename = package['filename']
        sha256 = package['sha256']
        Chef::Log.info("Unpacking #{fp_filename}...")

        ibm_cloud_utils_unpack "unpack-#{fp_filename}" do
          source "#{node['ibm']['sw_repo']}#{node['db2']['fp_repo_path']}/#{fp_filename}"
          target_dir node['db2']['expand_area']
          checksum sha256
          remove_local true
          vault_name node['db2']['vault']['name']
          vault_item node['db2']['vault']['encrypted_id']
          repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
        end
      end

      instances = db2_list_instances(new_resource.db2_install_dir)

      instances.each do |inst|
        db2_service "Stopping instance #{inst}" do
          instance_username inst
          action :stop_instance
        end
      end

      db2_service "Stopping DAS" do
        action :stop_das
      end

      execute 'Install db2 fixpack' do
        cwd new_resource.fp_dir
        command "./installFixPack -b #{new_resource.db2_install_dir} -l #{new_resource.log_dir}/DB2_FP_install.log -n"
      end

      #As part of a fix pack installation, updating DB2 instances and binding of the database utilities (IMPORT, EXPORT, REORG, the Command Line Processor) and the CLI bind files are done automatically.
      #instances.each do |inst|
      #  execute "Update instance #{inst}" do
      #    cwd new_resource.db2_install_dir + '/instance'
      #    command "./db2iupdt #{inst}"
      #  end
      #end

      #db2_service "Stopping DAS" do
      #  action :stop_das
      #end

      #execute 'Update DAS' do
      #  cwd new_resource.db2_install_dir + '/instance'
      #  command "./dasupdt"
      #end

      db2_service "Starting DAS" do
        action :start_das
      end

      instances.each do |inst|
        db2_service "Starting instance #{inst}" do
          instance_username inst
          action :start_instance
        end
      end
    end
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::Db2Fixpack.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.db2_install_dir(@new_resource.db2_install_dir)
  @current_resource.fixpack(@new_resource.fixpack)

  #Get current state
  @current_resource.db2_fp_installed = db2_fp_installed?(@new_resource.db2_install_dir, @new_resource.fixpack)
end
