#
# Cookbook Name:: wmq
# Recipe:: prereq_check
#
# Copyright IBM Corp. 2016, 2017
#
# <> Prerequisite Check Recipe (preq_check.rb)
# <> This recipe wil check the target platform to ensure installation is possible


# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
# chef_gem 'chef-vault' do
#   action :install
#   compile_time true
# end

# CHECK FREE SPACE ON THE DISKS
# ------------------------------------------------------------------------------
ibm_cloud_utils_freespace 'check-freespace-tmp-directory' do
  path node['ibm']['temp_dir']
  required_space 1024
  continue true
  action :check
  error_message "Please make sure you have at least 1GB free space under #{node['ibm']['temp_dir']}"
  not_if { wmq_installed? }
end

ibm_cloud_utils_freespace 'check-freespace-expand-area' do
  path node['wmq']['expand_area']
  required_space 1024
  continue true
  action :check
  error_message "Please make sure you have at least 1GB free space under #{node['wmq']['expand_area']}"
  not_if { wmq_installed? }
end

# Check Free Space on MQ File System
# ------------------------------------------------------------------------------
ibm_cloud_utils_freespace 'check-freespace-wmq-directory' do
  path node['wmq']['install_dir']
  required_space 1024
  continue true
  action :check
  error_message "Please make sure you have at least 1GB free space under #{node['wmq']['install_dir']}"
  not_if { wmq_installed? }
end

# Check suppored OS Versions
# ------------------------------------------------------------------------------
ibm_cloud_utils_supported_os_check 'check-supported-opeartingsystem-for-pattern' do
  supported_os_list node['wmq']['OS_supported']
  action :check
  error_message "Unsupported Operating System Version, the following OS is supported #{node['wmq']['OS_supported']}"
  not_if { wmq_installed? }
end

# Check Repository Files Exist
# ------------------------------------------------------------------------------
# require 'chef-vault'
node['wmq']['archive_names'].each_pair do |_p, v|
  filename = v['filename']
  Chef::Log.info("Checking if file #{filename} exists")

  ibm_cloud_utils_sw_repo "Checking if file #{filename} exists" do
    repository node['ibm']['sw_repo']
    sw_repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    sw_repo_user node['ibm']['sw_repo_user']
    secure_repo 'true'
    sw_repo_path node['wmq']['sw_repo_path'] + '/base/'
    package filename
    action :check_package
    not_if { wmq_installed? }
  end

end

upgrade_fixpack = if wmq_installed?
                    false
                  else
                     true
                  end

node['wmq']['fixpack_names'].each_pair do |_p, v|
  next if node['wmq']['fixpack'] == "0"
  fp_filename = v['filename']
  Chef::Log.info("Checking if file #{fp_filename} exists")

  ibm_cloud_utils_sw_repo "Checking if file #{fp_filename} exists" do
    repository node['ibm']['sw_repo']
    sw_repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    sw_repo_user node['ibm']['sw_repo_user']
    secure_repo 'true'
    sw_repo_path node['wmq']['sw_repo_path'] + '/maint/'
    package fp_filename
    action :check_package
    only_if { upgrade_fixpack }
  end

end
