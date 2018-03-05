# Cookbook Name::was
# Recipe::create_job_manager
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Create WebSphere Job Manager profile and starts the job manager.
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

# Prepare the job_manager.ports file
template "#{node['was']['expand_area']}/job_manager.ports" do
  source "job_manager.ports.erb"
  mode '0750'
  owner node['was']['os_users']['was']['name']
  group node['was']['os_users']['was']['gid']
  variables(
    :WC_adminhost => (node['was']['profiles']['job_manager']['ports']['WC_adminhost']),
    :WC_adminhost_secure => (node['was']['profiles']['job_manager']['ports']['WC_adminhost_secure']),
    :BOOTSTRAP_ADDRESS => (node['was']['profiles']['job_manager']['ports']['BOOTSTRAP_ADDRESS']),
    :SOAP_CONNECTOR_ADDRESS => (node['was']['profiles']['job_manager']['ports']['SOAP_CONNECTOR_ADDRESS']),
    :IPC_CONNECTOR_ADDRESS => (node['was']['profiles']['job_manager']['ports']['IPC_CONNECTOR_ADDRESS']),
    :SAS_SSL_SERVERAUTH_LISTENER_ADDRESS => (node['was']['profiles']['job_manager']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']),
    :CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS => (node['was']['profiles']['job_manager']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']),
    :CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS => (node['was']['profiles']['job_manager']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']),
    :ORB_LISTENER_ADDRESS => (node['was']['profiles']['job_manager']['ports']['ORB_LISTENER_ADDRESS']),
    :STATUS_LISTENER_ADDRESS => (node['was']['profiles']['job_manager']['ports']['STATUS_LISTENER_ADDRESS'])
  )
end
#
admin_user_pwd = node['was']['security']['admin_user_pwd']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  admin_user_pwd = ChefVault::Item.load(chef_vault, encrypted_id)['was']['security']['admin_user_pwd']
  log "was admin password:#{admin_user_pwd}"
end
#
template "#{node['was']['expand_area']}/job_manager.rsp" do
  source "job_manager.rsp.erb"
  mode '0750'
  owner node['was']['os_users']['was']['name']
  group node['was']['os_users']['was']['gid']
  variables(
    :INSTALL_LOCATION => (node['was']['install_dir']).to_s,
    :PROFILENAME => (node['was']['profiles']['job_manager']['profile']).to_s,
    :PROFILEPATH => "#{node['was']['profile_dir']}/#{node['was']['profiles']['job_manager']['profile']}",
    :CELLNAME => (node['was']['profiles']['job_manager']['cell']).to_s,
    :NODENAME => was_tags((node['was']['profiles']['job_manager']['node']).to_s),
    :HOSTNAME => was_tags((node['was']['profiles']['job_manager']['host']).to_s),
    :ADMINUSERNAME => (node['was']['security']['admin_user']).to_s,
    :ADMINPASSWORD => admin_user_pwd.to_s,
    :PORTSFILE => "#{node['was']['expand_area']}/job_manager.ports",
    :PERSONALCERTDN => was_tags(node['was']['profiles']['job_manager']['personalcertdn']),
    :PERSONALCERTVALIDITYPERIOD => (node['was']['profiles']['job_manager']['personalcertvalidityperiod']).to_s,
    :SIGNINGCERTDN => (node['was']['profiles']['job_manager']['signingcertdn']).to_s,
    :SIGNINGCERTVALIDITYPERIOD => was_tags(node['was']['profiles']['job_manager']['signingcertvalidityperiod']),
    :KEYSTOREPASSWORD => (node['was']['profiles']['job_manager']['keystorepassword']).to_s
  )
end

#Create the job_manager profile
execute_manage_profile("#{node['was']['expand_area']}/job_manager.rsp", node['was']['profiles']['job_manager']['profile'])
create_server_init((node['was']['profiles']['job_manager']['profile']).to_s, was_tags((node['was']['profiles']['job_manager']['node']).to_s), 'job_manager')

if node['was']['config']['enable_admin_security'] == "true"
  encrypt_soap_client_props((node['was']['profiles']['job_manager']['profile']).to_s, admin_user_pwd.to_s)
end

fix_user_ownership(["#{node['was']['profile_dir']}/#{node['was']['profiles']['job_manager']['profile']}", node['was']['install_dir']])

start_server(was_tags(node['was']['profiles']['job_manager']['node']).to_s)
