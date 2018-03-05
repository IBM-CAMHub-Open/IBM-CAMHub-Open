# Cookbook Name:: ihs
# Recipe:: config_wasplugin
#
# Copyright IBM Corp. 2016, 2017
#

# <> WAS plugin configuration recipe (config_wasplugin.rb)
# <> Configure the WAS plugin

case node['ihs']['install_mode']
when 'admin'
  ihs_user = 'root'
  ihs_group = 'root'
else
  ihs_user = node['ihs']['os_users']['ihs']['name']
  ihs_group = node['ihs']['os_users']['ihs']['gid']
end

case node['os']
when 'linux'
  os_name = 'Linux'
when 'windows'
  os_name = 'Windows'
when 'aix'
  os_name = 'AIX'
end

# Bitness has been obsoleted in v9
install_arch = if node['ihs']['version'].split('.').first.to_i >= 9
                 '64'
               else
                 node['ihs']['features']['bitness']
               end

plugin_install_type = node['ihs']['plugin']['plugin_install_type']
plugin_home = node['ihs']['plugin']['install_dir']
ihs_conf = "#{node['ihs']['install_dir']}/conf/httpd.conf"
match_tag = node['ihs']['plugin']['dmgr_tag']
webserver_name = node['ihs']['plugin']['was_webserver_name']
was_plugin_cfg_xml = "#{plugin_home}/config/#{webserver_name}/plugin-cfg.xml"
ihs_admin_usergroup = ihs_group

plugin_string = "WebSpherePluginConfig #{plugin_home}/config/#{webserver_name}/plugin-cfg.xml"

# Attempt to search for DMGR hostname, fallback on input param if none found
was_hostname = node['ihs']['plugin']['was_hostname']
query = "stack_id:#{node['ibm_internal']['stack_id']} AND tags:#{match_tag}"

if node['ihs']['plugin']['enabled'].to_s == 'true' && !File.directory?(node['ihs']['install_dir']) # only run the search once
  Chef::Config[:solo] == true ? (nodes = []) : (nodes = search(:node, query))
  case nodes.length
  when 1
    # Found the DMGR hostname
    log "Found DMGR #{nodes['hostname']}"
    was_hostname = nodes['hostname']
  when 0
    # None found, fallback on user input
    log "Found no DMGR in stack, using provided hostname #{node['ihs']['plugin']['was_hostname']}"
  else
    # Stack is invalid, bail out
    raise "Query \'#{query}\' returned #{nodes.length} objects, expecting one"
  end
  # Fail if we couldn't get any hostname
  raise 'Could not determine DMGR hostname' if was_hostname.empty?
end

# Build plugin feature list
if node['ihs']['plugin']['enabled'].to_s == 'true'
  plgfeature_list = ''
  node['ihs']['plugin']['features'].each_pair do |feature, do_install|
    if do_install['version_support'].include? node['ihs']['version'].split('.').first.to_s
      plgfeature_list = plgfeature_list + feature + ',' if do_install['install'].to_s == 'true'
    end
  end
  plgfeature_list = plgfeature_list.chomp(',')
end

# Manage base directory
subdirs = subdirs_to_create(plugin_home, ihs_user)
subdirs.each do |dir|
  directory "Plugin: create #{dir}" do
    path dir
    action :create
    recursive true
    owner ihs_user
    group ihs_group
    only_if { node['ihs']['plugin']['enabled'].to_s == 'true' }
  end
end

# Install plugin from IM repo
im_install 'ibm_http_server_plugin' do
  repositories node['ibm']['im_repo']
  install_dir plugin_home
  response_file 'ihs.install.xml'
  offering_id node['ihs']['offering_id']['PLG']
  offering_version make_offering_version(node['ihs']['version'])
  profile_id node['ihs']['profile_id']['PLG']
  feature_list plgfeature_list
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
  action :install
  only_if { node['ihs']['plugin']['enabled'].to_s == 'true' }
  only_if { ihs_plg_do_install? }
end

# Create initial plugin configuration. Should only be performed once.
execute "Configuring IHS plugin for #{webserver_name} on #{was_hostname}" do
  command "#{plugin_home}/bin/setupCmdLine.sh && #{plugin_home}/bin/ws_ant.sh \
-f #{plugin_home}/config/actionRegistry/actions/99SBootStrapPluginsIHS.ant \
-DPLUGIN_HOME=#{plugin_home} \
-DOS_NAME=#{os_name} \
-DIHS_CONF=#{ihs_conf} \
-DWAS_PLUGIN_CFG_XML=#{was_plugin_cfg_xml} \
-DINSTALL_ARCH=#{install_arch} \
-DPLUGIN_INSTALL_TYPE=#{plugin_install_type} \
-DWEBSERVER_NAME=#{webserver_name} \
-DIHS_ADMIN_USERGROUP=#{ihs_admin_usergroup} \
-DWAS_HOSTNAME=#{was_hostname} \
-DWEBSERVER_TYPE=IHS"
  only_if { node['ihs']['plugin']['enabled'].to_s == 'true' }
  only_if { File.readlines(ihs_conf.to_s).grep(/^#{plugin_string}$/).empty? }
end

# Some config files / logs will be owned by root
execute 'restore ownership on plugin files' do
  command "chown -R #{node['ihs']['os_users']['ihs']['name']}:#{node['ihs']['os_users']['ihs']['gid']} #{plugin_home}/*"
  only_if { ihs_first_run? }
  only_if { node['ihs']['plugin']['enabled'].to_s == 'true' }
end

# Fix permissions on log files
execute 'Fix permissions on log files' do
  command "chmod g+w #{plugin_home}/logs/#{webserver_name}/*"
  only_if { File.stat("#{plugin_home}/logs/#{webserver_name}/http_plugin.log").mode & 16 == 16 }
end
