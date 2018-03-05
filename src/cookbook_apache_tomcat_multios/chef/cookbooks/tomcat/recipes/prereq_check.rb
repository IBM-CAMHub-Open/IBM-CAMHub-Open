# Cookbook Name:: tomcat
# Recipe:: prereq_check
#
# Copyright IBM Corp. 2017, 2017
#

# <> Prerequisites recipe (prereq_check.rb)
# <> Verify required prerequisites, validate input

::Chef::Recipe.send(:include, TomcatHelper)
::Chef::Resource.send(:include, TomcatHelper)

# Validate requested Tomcat version
inst_vers = tomcat_installed_version(node['tomcat']['install_dir'])
raise "Requested version #{node['tomcat']['version']} format is invalid, expected <Release>.<Version>.<Level>" if node['tomcat']['version'].split('.').length != 3

if tomcat_installed?(node['tomcat']['install_dir'])
  # Validate fixpack installation requests
  raise "Downgrade is not supported \(#{node['tomcat']['version']} is lower than the installed version #{inst_vers}\)" if (node['tomcat']['version'].split('.') <=> inst_vers.split('.')) < 0

  # Only allow fixpack installations
  raise "Upgrade is only supported at fixpack level" unless (node['tomcat']['version'].split('.').slice(0, 2) <=> inst_vers.split('.').slice(0, 2)) == 0
end

# Fail if install_dir exists but product is not installed
log 'Tomcat is already installed' do
  only_if { tomcat_installed?(node['tomcat']['install_dir']) }
end

unless tomcat_installed?(node['tomcat']['install_dir'])
  if File.exist?(node['tomcat']['install_dir'])
    raise 'Provided installation directory already exists on the macihne, please choose another'
  end
end

# Validate repositories at first run
case node['platform_family']
when 'rhel'
  cmd1 = 'yum clean all'
  cmd2 = 'yum repolist'
when 'suse'
  cmd1 = 'zypper refresh'
  cmd2 = 'zypper repos'
when 'debian'
  cmd1 = 'apt-get update'
  cmd2 = 'apt-get check'
end

execute 'Updating repositories' do
  cwd '/tmp'
  command cmd1
  not_if { tomcat_installed?(node['tomcat']['install_dir']) }
end

execute 'Listing repositories' do
  cwd '/tmp'
  command cmd2
  not_if { tomcat_installed?(node['tomcat']['install_dir']) }
end

# TODO: Validate platform

# Check Free Space on install_dir
ibm_cloud_utils_freespace 'check-freespace-install-dir-directory' do
  path node['tomcat']['install_dir']
  required_space 500
  continue true
  action :check
  error_message "Please make sure you have at least 500MB free space under #{node['tomcat']['install_dir']}"
  not_if { tomcat_installed?(node['tomcat']['install_dir']) }
end

# Check Free Space on temp_dir
ibm_cloud_utils_freespace 'check-freespace-temp-dir-directory' do
  path node['ibm']['expand_area']
  required_space 500
  continue true
  action :check
  error_message "Please make sure you have at least 500MB free space under #{node['ibm']['temp_dir']}"
  not_if { tomcat_installed?(node['tomcat']['install_dir']) }
end
