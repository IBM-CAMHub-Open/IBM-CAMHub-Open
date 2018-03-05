################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Prerequisites recipe (prereq.rb)
# <> Perform prerequisite tasks.

ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do 
  action :updateshosts 
end
# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
# chef_gem 'chef-vault' do
#   action :install
#   compile_time true
# end

################################################################################
# Create directory for tomcat and set permissions accordingly
################################################################################
directory node['tomcat']['install_dir'] do
  action :create
end

################################################################################
# create OS users and groups at compile time
################################################################################
node['tomcat']['os_users'].each_pair do |_k, u|
  next if u['name'].nil?
  next if u['ldap_user'] == 'true'

  group u['gid'] do
    action :create
  end # .run_action(:create)

  user u['name'] do
    action :create
    comment u['comment']
    home u['home']
    gid u['gid']
    shell u['shell']
    manage_home true
  end
end

################################################################################
# Create expand area (ensure mode allows non-root users through)
################################################################################
directory node['ibm']['expand_area'] do
  action :create
  mode '0755'
  recursive true
  not_if { File.exist?("#{node['tomcat']['install_dir']}/bin/catalina.sh") }
end

################################################################################
# Create temp directory for tomcat binaries
################################################################################
directory node['tomcat']['expand_area'] do
  action :create
  mode '0755'
  recursive true
  user node['tomcat']['os_users']['daemon']['name']
  group node['tomcat']['os_users']['daemon']['gid']
  not_if { File.exist?("#{node['tomcat']['install_dir']}/bin/catalina.sh") }
end

################################################################################
# Create log directory
################################################################################
directory node['ibm']['log_dir'] do
  action :create
  mode '0755'
  recursive true
  not_if { File.exist?("#{node['tomcat']['install_dir']}/bin/catalina.sh") }
end

################################################################################
# Create evidence directory
################################################################################
directory node['ibm']['evidence_path']['unix'] do
  mode '0755'
  action :create
  recursive true
end

################################################################################
# Install Java
################################################################################
tomcat_java 'install java' do
  vendor node['tomcat']['java']['vendor']
  version node['tomcat']['java']['version']
  sdk node['tomcat']['java']['java_sdk']
end

################################################################################
# Prepare validation script (only at first run)
################################################################################
template node['tomcat']['validation_script'] do
  source 'tomcat_validation.sh.erb'
  mode '0750'
  variables(
    :evidence_dir => node['ibm']['evidence_path']['unix'],
    :evidence_log => node['tomcat']['validation_log'],
    :tomcat_user => node['tomcat']['os_users']['daemon']['name'],
    :catalina_home => node['tomcat']['install_dir'],
    :tomcat_log_dir => node['tomcat']['instance_dirs']['log_dir'],
    :tomcat_pidfile => node['tomcat']['instance_dirs']['log_dir'] + '/tomcat8.pid',
    :server_port => node['tomcat']['server']['port'],
    :http_port => node['tomcat']['http']['port'],
    :ssl_enabled => node['tomcat']['ssl']['enabled'].downcase,
    :ssl_port => node['tomcat']['ssl']['port'],
    :ajp_port => node['tomcat']['ajp']['port']
  )
  not_if { File.exist?("#{node['tomcat']['install_dir']}/bin/catalina.sh") }
end
