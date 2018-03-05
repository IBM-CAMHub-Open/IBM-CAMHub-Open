# Cookbook Name::was
# Recipe::unmanaged_webserver
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Creates a IBM HTTP webserver server defintion as an unmanaged node.

# Create directories incase cleanup recipe as been executed before
[node['was']['expand_area'], node['ibm']['temp_dir'], node['ibm']['log_dir']].each do |dir|
    directory dir do
      recursive true
      action :create
      mode '0755'
    end
end

adminuserpwd = node['was']['security']['admin_user_pwd']
ihsadminpassword = node['was']['webserver']['ihs_server']['ihs_admin_password']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  adminuserpwd = chef_vault_item(chef_vault, encrypted_id)['was']['security']['admin_user_pwd']
  ihsadminpassword = chef_vault_item(chef_vault, encrypted_id)['ihs']['admin_server']['password'].to_s
end

profilepath = "#{node['was']['profile_dir']}/#{node['was']['profiles']['dmgr']['profile']}"
nodename = was_tags(node['was']['unmanaged_node']['unmngNode01']['node_name'])

node['was']['unmanaged_node'].each_pair do |_k, u|
  unmanaged_hostname = u['host_name']
  Chef::Log.info("unmanaged hostname-IHS: #{unmanaged_hostname}")
  if unmanaged_hostname == '' || unmanaged_hostname.empty? || unmanaged_hostname.nil?
    unmanaged_hostname = chef_searchihshostname(node['was']['ihs_role_names'])
    Chef::Log.info("#{unmanaged_hostname} unmanaged hostname-IHS derived from chefsearch in stack")
  end
  template "#{node['ibm']['temp_dir']}/#{nodename}_unmanaged_node.jython" do
    source "unmanaged_node.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :NODE_NAME => nodename,
              :HOST_NAME => unmanaged_hostname,
              :OS => u['os'])
    action :create
  end
  template "#{node['ibm']['temp_dir']}/#{nodename}_unmanaged_node_check.jython" do
    source "unmanaged_node_check.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'])
    action :create
  end

  was_nodes "create_unmanaged_node" do
    profile_path profilepath
    admin_user node['was']['security']['admin_user']
    admin_pwd adminuserpwd
    os_user node['was']['os_users']['was']['name']
    node_name nodename
    action :create_unmanaged
  end
end


node['was']['webserver'].each_pair do |_k, u|
  nodename = was_tags(u['node_name'])
  template "#{node['ibm']['temp_dir']}/#{u['webserver_name']}_webserver.jython" do
    source "webserver.jython.erb"
    sensitive true
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :NODE_NAME => nodename,
              :WEBSERVER_NAME => u['webserver_name'],
              :WEBSERVER_PORT => u['webserver_port'],
              :WEBSERVER_INSTALLDIR => u['install_dir'],
              :PLUGIN_INSTALLDIR => u['plugin_dir'],
              :ADMINSERVER_PORT => u['admin_port'],
              :ADMINSERVER_USER => u['ihs_admin_user'],
              :ADMINSERVER_PASSWORD => ihsadminpassword,
              :WEBSERVER_TYPE => u['webserver_type'],
              :WEBAPP_MAPPING => u['webapp_mapping'])
    action :create
  end
  template "#{node['ibm']['temp_dir']}/#{u['webserver_name']}_webserver_check.jython" do
    source "webserver_check.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :NODE_NAME => nodename)
    action :create
  end

  was_webserver "create_webserver" do
    profile_path profilepath
    admin_user node['was']['security']['admin_user']
    admin_pwd adminuserpwd
    os_user node['was']['os_users']['was']['name']
    webserver_name u['webserver_name']
    action :create
  end
end
