# Cookbook Name::was
# Recipe::create_clustermember
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Create Websphere cluster members/servers
#

# Create directories incase cleanup recipe as been executed before
[node['was']['expand_area'], node['ibm']['temp_dir'], node['ibm']['log_dir']].each do |dir|
    directory dir do
      recursive true
      action :create
      mode '0755'
    end
end

#create wsadmin libraries
create_wsadmin_library(node['ibm']['temp_dir'])

adminuserpwd = node['was']['security']['admin_user_pwd']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  adminuserpwd = chef_vault_item(chef_vault, encrypted_id)['was']['security']['admin_user_pwd']
end

profilepath = "#{node['was']['profile_dir']}/#{node['was']['profiles']['node_profile']['profile']}"

node['was']['wsadmin']['clusters'].each_pair do |_k, u|
  clustername = u['cluster_name']
  sessionrep =  u['session_rep']
  nodename = was_tags(node['was']['profiles']['node_profile']['node'].to_s)
  u['cluster_servers'].each_pair do |_j, i|
    template "#{node['ibm']['temp_dir']}/#{i['server_name']}_appserver_in_cluster_create.jython" do
      source "appserver_in_cluster_create.jython.erb"
      mode "755"
      variables(:TMP => node['ibm']['temp_dir'],
                :NODE_NAME => nodename,
                :SERVER_NAME => i['server_name'],
                :CLUSTER_NAME => clustername,
                :SESSION_REP => sessionrep)
      action :create
    end
    template "#{node['ibm']['temp_dir']}/#{i['server_name']}_appserver_in_cluster_check.jython" do
      source "appserver_in_cluster_check.jython.erb"
      mode "755"
      variables(:TMP => node['ibm']['temp_dir'],
                :CLUSTER_NAME => clustername)
      action :create
    end

    was_serverincluster "Create_server_in_cluster" do
      profile_path profilepath
      admin_user node['was']['security']['admin_user']
      admin_pwd adminuserpwd
      os_user node['was']['os_users']['was']['name']
      server_name i['server_name']
      node_name nodename
      action :create
    end
  end
end
