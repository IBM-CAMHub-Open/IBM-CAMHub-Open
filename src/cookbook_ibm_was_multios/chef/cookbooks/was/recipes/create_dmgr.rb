# Cookbook Name::was
# Recipe::create_dmgr
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Creates WebSphere Deployment Manager profile and starts the deployment manager.
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

# Prepare the dmgr.ports file
template "#{node['was']['expand_area']}/dmgr.ports" do
  source "dmgr.ports.erb"
  mode '0750'
  owner node['was']['os_users']['was']['name']
  group node['was']['os_users']['was']['gid']
  variables(
    :WC_adminhost => (node['was']['profiles']['dmgr']['ports']['WC_adminhost']),
    :WC_adminhost_secure => (node['was']['profiles']['dmgr']['ports']['WC_adminhost_secure']),
    :BOOTSTRAP_ADDRESS => (node['was']['profiles']['dmgr']['ports']['BOOTSTRAP_ADDRESS']),
    :SOAP_CONNECTOR_ADDRESS => (node['was']['profiles']['dmgr']['ports']['SOAP_CONNECTOR_ADDRESS']),
    :IPC_CONNECTOR_ADDRESS => (node['was']['profiles']['dmgr']['ports']['IPC_CONNECTOR_ADDRESS']),
    :SAS_SSL_SERVERAUTH_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']),
    :CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']),
    :CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']),
    :ORB_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['ORB_LISTENER_ADDRESS']),
    :CELL_DISCOVERY_ADDRESS => (node['was']['profiles']['dmgr']['ports']['CELL_DISCOVERY_ADDRESS']),
    :DCS_UNICAST_ADDRESS => (node['was']['profiles']['dmgr']['ports']['DCS_UNICAST_ADDRESS']),
    :DataPowerMgr_inbound_secure => (node['was']['profiles']['dmgr']['ports']['DataPowerMgr_inbound_secure']),
    :XDAGENT_PORT => (node['was']['profiles']['dmgr']['ports']['XDAGENT_PORT']),
    :OVERLAY_UDP_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['OVERLAY_UDP_LISTENER_ADDRESS']),
    :OVERLAY_TCP_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['OVERLAY_TCP_LISTENER_ADDRESS']),
    :STATUS_LISTENER_ADDRESS => (node['was']['profiles']['dmgr']['ports']['STATUS_LISTENER_ADDRESS'])
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

keystorepassword = node['was']['profiles']['dmgr']['keystorepassword']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  keystorepassword = chef_vault_item(chef_vault, encrypted_id)['was']['profiles']['dmgr']['keystorepassword']
end


template "#{node['was']['expand_area']}/dmgr.rsp" do
  source "dmgr.rsp.erb"
  sensitive true
  mode '0750'
  owner node['was']['os_users']['was']['name']
  group node['was']['os_users']['was']['gid']
  variables(
    :INSTALL_LOCATION => (node['was']['install_dir']).to_s,
    :PROFILENAME => (node['was']['profiles']['dmgr']['profile']).to_s,
    :PROFILEPATH => "#{node['was']['profile_dir']}/#{node['was']['profiles']['dmgr']['profile']}",
    :CELLNAME => (node['was']['profiles']['dmgr']['cell']).to_s,
    :NODENAME => was_tags(node['was']['profiles']['dmgr']['node'].to_s),
    :HOSTNAME => node['fqdn'],
    :ADMINUSERNAME => (node['was']['security']['admin_user']).to_s,
    :ADMINPASSWORD => admin_user_pwd.to_s,
    :PORTSFILE => "#{node['was']['expand_area']}/dmgr.ports",
    :PERSONALCERTDN => node['was']['profiles']['dmgr']['personalcertdn'],
    :PERSONALCERTVALIDITYPERIOD => (node['was']['profiles']['dmgr']['personalcertvalidityperiod']).to_s,
    :SIGNINGCERTDN => (node['was']['profiles']['dmgr']['signingcertdn']).to_s,
    :SIGNINGCERTVALIDITYPERIOD => node['was']['profiles']['dmgr']['signingcertvalidityperiod'],
    :KEYSTOREPASSWORD => keystorepassword.to_s
  )
end

#Create the DMGR profile
execute_manage_profile("#{node['was']['expand_area']}/dmgr.rsp", node['was']['profiles']['dmgr']['profile'])
create_server_init((node['was']['profiles']['dmgr']['profile']).to_s, was_tags(node['was']['profiles']['dmgr']['node'].to_s), 'dmgr')

if node['was']['config']['enable_admin_security'] == "true"
  encrypt_soap_client_props((node['was']['profiles']['dmgr']['profile']).to_s, admin_user_pwd.to_s)
end

fix_user_ownership(["#{node['was']['profile_dir']}/#{node['was']['profiles']['dmgr']['profile']}", node['was']['install_dir']])

#fix_init_script("#{node['was']['profiles']['dmgr']['node'].to_s}_was.init")

start_dmgr
