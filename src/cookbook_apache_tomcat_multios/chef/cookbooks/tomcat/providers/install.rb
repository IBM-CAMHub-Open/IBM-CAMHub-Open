#
# Cookbook Name:: tomcat
# Provider:: install.rb
#
# Copyright IBM Corp. 2017, 2017
#

include ::TomcatHelper

use_inline_resources

action :install do
  ################################################################################
  # Setup variables
  ################################################################################

  expand_area = new_resource.expand_area
  catalina_home = new_resource.catalina_home
  # catalina_base = new_resource.catalina_base
  tomcat_user = new_resource.owner
  tomcat_group = new_resource.group
  tomcat_service = new_resource.tomcat_service
  package_path = new_resource.package_path
  vault_name = new_resource.vault_name
  vault_item = new_resource.vault_item
  repo_self_signed_cert = new_resource.repo_self_signed_cert
  tomcat_version = new_resource.version
  # tomcat_mode = '0750' # new_resource.tomcat_mode

  extracted_dir = "#{expand_area}/apache-tomcat-#{tomcat_version}"

  version = if new_resource.version.nil?
              /-(\d+\.\d+\.\d+)\./.match(File.basename(new_resource.package_path))[1]
            else
              new_resource.version
            end
  raise "\'#{version}\' is not a valid version string for Tomcat" if /^\d+\.\d+\.\d+$/.match(version).nil?

  ################################################################################
  # Unpack Tomcat tarball
  ################################################################################

  ibm_cloud_utils_unpack "unpack-#{::File.basename(package_path)}" do
    source package_path
    target_dir expand_area
    vault_name vault_name
    vault_item vault_item
    repo_self_signed_cert repo_self_signed_cert
    owner tomcat_user
    group tomcat_group
    # mode tomcat_mode
    remove_local true
    only_if { !tomcat_installed?(catalina_home) || tomcat_upgrade?(catalina_home, tomcat_version) }
  end

  # Set ownership/permissions
  execute 'Set permissions on unpacked files' do
    cwd expand_area
    user tomcat_user
    command "chmod -R o-rwx,g+r,u+rw #{extracted_dir}"
    only_if { ::File.directory?(extracted_dir) }
  end

  if tomcat_upgrade?(catalina_home, tomcat_version)
    # In upgrade mode, get rid of user dirs
    # we want to overwrite only bin/lib and text files
    %w{conf logs temp work webapps}.each do |dir|
      execute "Will not update directory \'#{catalina_home}/#{::File.basename(dir)}\' in upgrade mode" do
        cwd expand_area
        command "rm -rf #{extracted_dir}/#{dir}"
      end
    end

    # In upgrade mode - stop service
    service "Stoping service \'#{tomcat_service}\' for upgrade" do
      service_name tomcat_service
      action :stop
    end
  end

  # Populate catalina_home
  execute "Populating #{catalina_home}" do
    cwd expand_area
    user tomcat_user
    group tomcat_group
    command "cp -fR apache-tomcat-#{tomcat_version}/* #{catalina_home}"
    only_if { !tomcat_installed?(catalina_home) || tomcat_upgrade?(catalina_home, tomcat_version) }
  end
end
