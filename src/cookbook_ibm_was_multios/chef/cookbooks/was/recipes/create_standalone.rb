# Cookbook Name::was
# Recipe::create_standalone
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Create Websphere standalone server profile and starts the server.
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

node['was']['profiles']['standalone_profiles'].each_pair do |p, v|
  Chef::Log.info("profile-instance: #{p}")
  Chef::Log.info("profile-instance-port: #{v['ports']['WC_adminhost']}")
  # Prepare the standalone.ports file
  template "#{node['was']['expand_area']}/#{p}.ports" do
    source "standalone.ports.erb"
    mode '0750'
    owner node['was']['os_users']['was']['name']
    group node['was']['os_users']['was']['gid']
    variables(
    :WC_adminhost => (v['ports']['WC_adminhost']),
    :WC_adminhost_secure => (v['ports']['WC_adminhost_secure']),
    :WC_defaulthost => (v['ports']['WC_defaulthost']),
    :WC_defaulthost_secure => (v['ports']['WC_defaulthost_secure']),
    :BOOTSTRAP_ADDRESS => (v['ports']['BOOTSTRAP_ADDRESS']),
    :SOAP_CONNECTOR_ADDRESS => (v['ports']['SOAP_CONNECTOR_ADDRESS']),
    :IPC_CONNECTOR_ADDRESS => (v['ports']['IPC_CONNECTOR_ADDRESS']),
    :SAS_SSL_SERVERAUTH_LISTENER_ADDRESS => (v['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']),
    :CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS => (v['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']),
    :CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS => (v['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']),
    :DCS_UNICAST_ADDRESS => (v['ports']['DCS_UNICAST_ADDRESS']),
    :OVERLAY_UDP_LISTENER_ADDRESS => (v['ports']['OVERLAY_UDP_LISTENER_ADDRESS']),
    :OVERLAY_TCP_LISTENER_ADDRESS => (v['ports']['OVERLAY_TCP_LISTENER_ADDRESS']),
    :ORB_LISTENER_ADDRESS => (v['ports']['ORB_LISTENER_ADDRESS']),
    :SIP_DEFAULTHOST => (v['ports']['SIP_DEFAULTHOST']),
    :SIP_DEFAULTHOST_SECURE => (v['ports']['SIP_DEFAULTHOST_SECURE']),
    :SIB_ENDPOINT_ADDRESS => (v['ports']['SIB_ENDPOINT_ADDRESS']),
    :SIB_ENDPOINT_SECURE_ADDRESS => (v['ports']['SIB_ENDPOINT_SECURE_ADDRESS']),
    :SIB_MQ_ENDPOINT_ADDRESS => (v['ports']['SIB_MQ_ENDPOINT_ADDRESS']),
    :SIB_MQ_ENDPOINT_SECURE_ADDRESS => (v['ports']['SIB_MQ_ENDPOINT_SECURE_ADDRESS'])
    )
  end

  admin_user_pwd = node['was']['security']['admin_user_pwd']
  chef_vault = node['was']['vault']['name']
  unless chef_vault.empty?
    encrypted_id = node['was']['vault']['encrypted_id']
    require 'chef-vault'
    admin_user_pwd = chef_vault_item(chef_vault, encrypted_id)['was']['security']['admin_user_pwd']
  end
  #
  keystorepassword = v['keystorepassword']
  chef_vault = node['was']['vault']['name']
  unless chef_vault.empty?
    encrypted_id = node['was']['vault']['encrypted_id']
    require 'chef-vault'
    keystorepassword = chef_vault_item(chef_vault, encrypted_id)['was']['profiles']['standalone_profiles']['keystorepassword']
  end
  # #
  template "#{node['was']['expand_area']}/#{p}.rsp" do
    source "standalone.rsp.erb"
    sensitive true
    mode '0750'
    owner node['was']['os_users']['was']['name']
    group node['was']['os_users']['was']['gid']
    variables(
      :INSTALL_LOCATION => (node['was']['install_dir']).to_s,
      :CELLNAME => (v['cell']).to_s,
      :SERVERNAME => (v['server']).to_s,
      :PROFILENAME => (v['profile']).to_s,
      :PROFILEPATH => "#{node['was']['profile_dir']}/#{v['profile']}",
      :NODENAME => was_tags((v['node']).to_s),
      :HOSTNAME => was_tags((v['host']).to_s),
      :ADMINUSERNAME => (node['was']['security']['admin_user']).to_s,
      :ADMINPASSWORD => admin_user_pwd.to_s,
      :PORTSFILE => "#{node['was']['expand_area']}/#{p}.ports",
      :PERSONALCERTDN => was_tags(v['personalcertdn']),
      :PERSONALCERTVALIDITYPERIOD => (v['personalcertvalidityperiod']).to_s,
      :SIGNINGCERTDN => (v['signingcertdn']).to_s,
      :SIGNINGCERTVALIDITYPERIOD => was_tags(v['signingcertvalidityperiod']),
      :KEYSTOREPASSWORD => keystorepassword
    )
  end

  #
  # #Create the Standalone profile
  execute_manage_profile("#{node['was']['expand_area']}/#{p}.rsp", v['profile'])

  # # create the service init script
  create_server_init((v['profile']).to_s, was_tags((v['node']).to_s), (v['server']).to_s)

  if node['was']['config']['enable_admin_security'] == "true"
    encrypt_soap_client_props((v['profile']).to_s, admin_user_pwd.to_s)
  end

  fix_user_ownership(["#{node['was']['profile_dir']}/#{v['profile']}", node['was']['install_dir']])

  start_server(v['node'])
end
