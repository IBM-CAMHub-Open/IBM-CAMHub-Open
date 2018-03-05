# Cookbook Name::was
# Recipe::create_cluster
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Creates a WebSphere cluster for a given cell.  There is no retry logic if system management throws an exception.
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
  template "#{node['ibm']['temp_dir']}/#{u['cluster_name']}_cluster_create.jython" do
    source "cluster_create.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :CLUSTER_NAME => u['cluster_name'],
              :CELL_NAME => node['was']['profiles']['dmgr']['cell'],
              :REP_DOMAIN => u['session_rep'])
    action :create
  end
  template "#{node['ibm']['temp_dir']}/#{u['cluster_name']}_cluster_check.jython" do
    source "cluster_check.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :CLUSTER_NAME => u['cluster_name'])
    action :create
  end
  was_cluster "Create_cluster" do
    profile_path profilepath
    admin_user node['was']['security']['admin_user']
    admin_pwd adminuserpwd
    os_user node['was']['os_users']['was']['name']
    cluster_name u['cluster_name']
    action :create
  end
end
