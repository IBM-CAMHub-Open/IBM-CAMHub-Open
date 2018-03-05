# Cookbook Name:: ihs
# Recipe:: install
#
# Copyright IBM Corp. 2016, 2017
#

# <> Installation recipe (install.rb)
# <> Perform installation of the main asset

# Choose OS user for installation per installation mode
case node['ihs']['install_mode']
when 'admin'
  ihs_user = 'root'
  ihs_group = 'root'
else
  ihs_user = node['ihs']['os_users']['ihs']['name']
  ihs_group = node['ihs']['os_users']['ihs']['gid']
end

# Setup feature list
ihsfeature_list = ''
node['ihs']['ihs_features'].each_pair do |feature, do_install|
  if do_install['version_support'].include? node['ihs']['version'].split('.').first.to_s
    ihsfeature_list = ihsfeature_list + feature + ',' if do_install['install'].to_s == 'true'
  end
end
ihsfeature_list = ihsfeature_list.chomp(',')

# Manage base directory
subdirs = subdirs_to_create(node['ihs']['install_dir'], node['ihs']['os_users']['ihs']['name'])
subdirs.each do |dir|
  directory dir do
    action :create
    recursive true
    owner node['ihs']['os_users']['ihs']['name']
    group node['ihs']['os_users']['ihs']['gid']
  end
end

# Run IM LWRP
im_install 'ibm_http_server' do
  repositories node['ibm']['im_repo']
  install_dir node['ihs']['install_dir']
  response_file 'ihs.install.xml'
  offering_id node['ihs']['offering_id']['IHS']
  offering_version make_offering_version(node['ihs']['version'])
  profile_id node['ihs']['profile_id']['IHS']
  feature_list ihsfeature_list
  im_install_mode node['ihs']['install_mode']
  user ihs_user
  group ihs_group
  im_repo_user node['ibm']['im_repo_user']
  im_repo_nonsecureMode 'true'
  install_java node['ihs']['java']['install']
  java_offering_id node['ihs']['java']['offering_id']
  java_offering_version node['ihs']['java']['version'].split('.').slice(0..3).join('.') # only keep first three numbers
  # java_offering_version make_offering_version(node['ihs']['java']['version'])
  # java_feature_list 'com.ibm.sdk.8'
  repo_nonsecureMode 'true'
  action [:install_im, :upgrade_im, :install]
  only_if { ihs_do_install? }
  notifies :write, 'log[Restarting IHS after upgrade]', :immediately
  notifies :write, 'log[Restarting admin server after upgrade]', :immediately
end

# Notify service, except in the first run.
log 'Restarting IHS after upgrade' do
  action :nothing
  not_if { ihs_first_run? }
  notifies :restart, 'service[restart_ihs]'
end

log 'Restarting admin server after upgrade' do
  action :nothing
  not_if { ihs_first_run? }
  only_if { node['ihs']['admin_server']['enabled'] == 'true' }
  notifies :restart, 'service[restart_admin_server]'
end

# Resources to restart services in upgrade mode
service 'restart_ihs' do
  service_name node['ihs']['service_name']
  action :nothing
end

service 'restart_admin_server' do
  service_name node['ihs']['admin_server']['service_name']
  action :nothing
  only_if { node['ihs']['admin_server']['enabled'] == 'true' }
end
