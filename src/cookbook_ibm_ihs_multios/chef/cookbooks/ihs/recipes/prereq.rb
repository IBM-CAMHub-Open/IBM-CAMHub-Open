# Cookbook Name:: ihs
# Recipe:: prereq
#
# Copyright IBM Corp. 2016, 2017
#

# <> Prerequisites recipe (prereq.rb)
# <> Perform prerequisite actions

# Create OS users and groups
node['ihs']['os_users'].each_pair do |_k, u|
  next if u['name'].nil? || u['name'].to_s == 'nobody' || u['ldap_user'] == 'true'

  group u['gid'] do
    action :create
    not_if { u['gid'].empty? }
  end

  user u['name'] do
    action :create
    comment u['comment']
    home u['home'] unless u['home'] == 'default' # '/home/' + u['name']
    gid u['gid']
    shell u['shell']
    manage_home true
  end
end

# Create installer directories
[node['ibm']['expand_area'], node['ihs']['expand_area']].each do |dir|
  directory dir do
    recursive true
    action :create
    owner node['ihs']['os_users']['ihs']['name']
    group node['ihs']['os_users']['ihs']['gid']
    not_if { ihs_installed? }
  end
end

# Manage log dir
[node['ihs']['log_dir'], node['ibm']['evidence_path']].each do |dir|
  directory dir do
    recursive true
    action :create
    not_if { ihs_installed? }
  end
end
# Refresh Apt before attempting to install packages.
case node['platform_family']
when "debian"
  apt_update 'update'
end

# Install prerequisites
package 'install_prerequisites' do
  action :upgrade
  package_name node['ihs']['prereqs']
end

# Prepare validation script, only in the first run
template "#{node['ihs']['expand_area']}/ihs_validation.sh" do
  source 'ihs_validation.sh.erb'
  mode '0755'
  variables(
    :EVIDENCE_DIR => node['ibm']['evidence_path'],
    :EVIDENCE_LOG => "#{cookbook_name}-#{node['hostname']}.log",
    :INSTALL_MODE => node['ihs']['install_mode'],
    :INSTALL_DIR => node['ihs']['install_dir'],
    :IHS_USER => node['ihs']['os_users']['ihs']['name'],
    :IHS_PORT => node['ihs']['port'],
    :SSL_ENABLED => node['ihs']['ssl']['enabled'],
    :SSL_PORT => node['ihs']['ssl']['port'],
    :ADMIN_ENABLED => node['ihs']['admin_server']['enabled'],
    :ADMIN_PORT => node['ihs']['admin_server']['port']
  )
  not_if { File.exist?("#{node['ihs']['install_dir']}/bin/apachectl") }
end
