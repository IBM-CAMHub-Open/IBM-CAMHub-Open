#
# Cookbook Name:: oracledb
# Recipe:: install
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install.rb)
# <> This recipe performs the product installation.

# Extract oracle archives

node['oracledb']['database']['archive_names'].each do |_version, package|
  filename = package['filename']
  # sha256_value = package['sha256']
  oracle_pkg_url = node['oracledb']['sw_repo_path']['base'] + '/' + node['oracledb']['release_patchset'] + '/' + filename
  ibm_cloud_utils_unpack "Fetch and unpack :#{filename}" do
    source oracle_pkg_url
    target_dir "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-base"
    mode '0777' # ~mode_checker
    repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    vault_name node['oracledb']['vault']['name']
    vault_item node['oracledb']['vault']['encrypted_id']
    not_if { ::Dir.exist?("#{node['oracledb']['oracle_home']}/oui") }
  end
end


template "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-base/database/response/db_install.rsp" do
  mode '0777' # ~mode_checker
  source 'db_install.erb'
  action :create
  variables(
    FQDN:             node['fqdn'],
    INVENTORY:        node['oracledb']['db_ora_inventory'],
    GROUP:            node['oracledb']['install_group'],
    LANGUAGE:         node['oracledb']['language'],
    ORAHOME:          node['oracledb']['oracle_home'],
    ORABASE:          node['oracledb']['oracle_base'],
    DBAGRP:           node['oracledb']['dba_group'],
    OPERGRP:          node['oracledb']['dba_group'],
    BKUPGRP:          node['oracledb']['dba_group'],
    DGDBAGRP:         node['oracledb']['dba_group'],
    KMDBAGRP:         node['oracledb']['dba_group'],
    RACDBAGRP:        node['oracledb']['dba_group'],
    STORAGETYPE:      node['oracledb']['database']['ora_storage_type'],
    ASMDISKGROUP:     node['oracledb']['asm']['DiskVolName_DATA'],
    ASMSNMPPASSWORD:  node['oracledb']['asm']['asmsnmpPassword']
  )
  not_if { ::Dir.exist?("#{node['oracledb']['oracle_home']}/oui") }
end

# TODO.. why the invPtrLoc to different folder than /etc/oraInst.loc

# run oracle installer

bash 'run_installer' do
  environment node['oracledb']['env']
  code "su - #{node['oracledb']['os_users']['oracle']['name']} -c \" #{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-base/database/runInstaller -silent -waitforcompletion -ignorePrereq -responseFile #{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-base/database/response/db_install.rsp -showProgress \""
  not_if { ::Dir.exist?("#{node['oracledb']['oracle_home']}/oui") }
end

# Run the post installation scripts
orainst_root_sh = "#{node['oracledb']['db_ora_inventory']}/orainstRoot.sh"
execute 'orainstRoot.sh' do
  command orainst_root_sh
  not_if { File.exist?("/etc/oraInst.loc") }
end

# Run the post installation scripts
root_sh = "#{node['oracledb']['oracle_home']}/root.sh"
execute 'root.sh' do
  command root_sh
  not_if { File.exist?(node['oracledb']['file_mapping_utility_path']) }
end

# create listener.ora file
template "#{node['oracledb']['oracle_home']}/network/admin/listener.ora" do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0640'
  variables(
    ORACLE_HOME: node['oracledb']['oracle_home'],
    SID_NAME: node['oracledb']['SID'],
    PORT: node['oracledb']['port'],
    HOST: node['fqdn']
  )
  action :create_if_missing
end

template "#{node['oracledb']['oracle_home']}/network/admin/sqlnet.ora" do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0640'
  action :create_if_missing
end

# create tnsnames.ora file
template "#{node['oracledb']['oracle_home']}/network/admin/tnsnames.ora" do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0640'
  variables(
    ORAUPPERSID: node['oracledb']['SID'].upcase,
    SERVICE_NAME: node['oracledb']['SID'],
    PORT: node['oracledb']['port'],
    HOST: node['fqdn']
  )
  action :create_if_missing
end

# Permision configuration for admin folder with recursive

admin_dir = "#{node['oracledb']['oracle_home']}/network/admin"
execute 'permission_oracle' do
  command "chown -R #{node['oracledb']['os_users']['oracle']['name']}:#{node['oracledb']['os_users']['oracle']['gid']} #{node['oracledb']['oracle_home']}/network/admin"
  action :run
  only_if { ::Dir.exist?(admin_dir) }
end
