# Cookbook Name::was
# Recipe::create_managed
#
#         Copyright IBM Corp. 2016, 2017
#
# <>Create node agent, manage node profile, start the node agent
#

# Create directories incase cleanup recipe as been executed before
[node['was']['expand_area'], node['ibm']['temp_dir'], node['ibm']['log_dir']].each do |dir|
    directory dir do
      recursive true
      action :create
      mode '0755'
    end
end

# Manage base directory
subdirs = subdirs_to_create(node['was']['profile_dir'], node['was']['os_users']['was']['name'])
subdirs.each do |dir|
  directory dir do
    action :create
    recursive true
    owner node['was']['os_users']['was']['name']
    group node['was']['os_users']['was']['gid']
  end
end

# Prepare the managed.ports file
template "#{node['was']['expand_area']}/managed.ports" do
  source "managed.ports.erb"
  mode '0750'
  owner node['was']['os_users']['was']['name']
  group node['was']['os_users']['was']['gid']
  variables(
  :BOOTSTRAP_ADDRESS => (node['was']['profiles']['node_profile']['ports']['BOOTSTRAP_ADDRESS']),
  :SOAP_CONNECTOR_ADDRESS => (node['was']['profiles']['node_profile']['ports']['SOAP_CONNECTOR_ADDRESS']),
  :IPC_CONNECTOR_ADDRESS => (node['was']['profiles']['node_profile']['ports']['IPC_CONNECTOR_ADDRESS']),
  :SAS_SSL_SERVERAUTH_LISTENER_ADDRESS => (node['was']['profiles']['node_profile']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']),
  :CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS => (node['was']['profiles']['node_profile']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']),
  :CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS => (node['was']['profiles']['node_profile']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']),
  :DCS_UNICAST_ADDRESS => (node['was']['profiles']['node_profile']['ports']['DCS_UNICAST_ADDRESS']),
  :OVERLAY_UDP_LISTENER_ADDRESS => (node['was']['profiles']['node_profile']['ports']['OVERLAY_UDP_LISTENER_ADDRESS']),
  :OVERLAY_TCP_LISTENER_ADDRESS => (node['was']['profiles']['node_profile']['ports']['OVERLAY_TCP_LISTENER_ADDRESS']),
  :NODE_MULTICAST_DISCOVERY_ADDRESS => (node['was']['profiles']['node_profile']['ports']['NODE_MULTICAST_DISCOVERY_ADDRESS']),
  :NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS => (node['was']['profiles']['node_profile']['ports']['NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS']),
  :NODE_DISCOVERY_ADDRESS => (node['was']['profiles']['node_profile']['ports']['NODE_DISCOVERY_ADDRESS']),
  :ORB_LISTENER_ADDRESS => (node['was']['profiles']['node_profile']['ports']['ORB_LISTENER_ADDRESS']),
  :XDAGENT_PORT => (node['was']['profiles']['node_profile']['ports']['XDAGENT_PORT'])
  )
end
#
admin_user_pwd = node['was']['security']['admin_user_pwd']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  admin_user_pwd = chef_vault_item(chef_vault, encrypted_id)['was']['security']['admin_user_pwd']
end
#
keystorepassword = node['was']['profiles']['node_profile']['keystorepassword']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  keystorepassword = chef_vault_item(chef_vault, encrypted_id)['was']['profiles']['node_profile']['keystorepassword']
end


dmgr_host= node['was']['dmgr_host_name'].to_s
Chef::Log.info("#{dmgr_host} dmgr derived node attributes")
if dmgr_host == '' || dmgr_host.empty? || dmgr_host.nil?
  dmgr_host = chef_searchhostname(node['was']['dmgr_role_name'])
  Chef::Log.info("#{dmgr_host} dmgr derived from chefsearch")
end

dmgr_port= node['was']['profiles']['node_profile']['dmgr_port'].to_s
Chef::Log.info("#{dmgr_port} dmgr port derived from node attributes")
if dmgr_port == '' || dmgr_port.empty? || dmgr_port.nil?
  dmgr_port = chef_searchdmgrport(node['was']['dmgr_role_name'])
  Chef::Log.info("#{dmgr_port} dmgr derived from chefsearch")
end

template "#{node['was']['expand_area']}/managed.rsp" do
  source "managed.rsp.erb"
  sensitive true
  mode '0750'
  owner node['was']['os_users']['was']['name']
  group node['was']['os_users']['was']['gid']
  variables(
    :INSTALL_LOCATION => (node['was']['install_dir']).to_s,
    :PROFILENAME => (node['was']['profiles']['node_profile']['profile']).to_s,
    :PROFILEPATH => "#{node['was']['profile_dir']}/#{node['was']['profiles']['node_profile']['profile']}",
    :NODENAME => was_tags(node['was']['profiles']['node_profile']['node'].to_s),
    :HOSTNAME => node['fqdn'],
    :ADMINUSERNAME => (node['was']['security']['admin_user']).to_s,
    :ADMINPASSWORD => admin_user_pwd.to_s,
    :DMGRHOST => dmgr_host.to_s,
    :DMGRPORT => dmgr_port.to_s,
    :PORTSFILE => "#{node['was']['expand_area']}/managed.ports",
    :PERSONALCERTDN => node['was']['profiles']['node_profile']['personalcertdn'],
    :PERSONALCERTVALIDITYPERIOD => (node['was']['profiles']['node_profile']['personalcertvalidityperiod']).to_s,
    :SIGNINGCERTDN => (node['was']['profiles']['node_profile']['signingcertdn']).to_s,
    :SIGNINGCERTVALIDITYPERIOD => node['was']['profiles']['node_profile']['signingcertvalidityperiod'],
    :KEYSTOREPASSWORD => keystorepassword.to_s
  )
end

#Create the Managed profile
execute_manage_profile("#{node['was']['expand_area']}/managed.rsp", node['was']['profiles']['node_profile']['profile'])
# create the service init script
create_server_init((node['was']['profiles']['node_profile']['profile']).to_s, was_tags(node['was']['profiles']['node_profile']['node'].to_s), 'nodeagent')

if node['was']['config']['enable_admin_security'] == "true"
  encrypt_soap_client_props((node['was']['profiles']['node_profile']['profile']).to_s, admin_user_pwd.to_s)
end

fix_user_ownership(["#{node['was']['profile_dir']}/#{node['was']['profiles']['node_profile']['profile']}", node['was']['install_dir']])

#fix_init_script("#{node['was']['profiles']['node_profile']['node'].to_s}_was.init")

start_nodeagent
