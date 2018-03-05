################################################################################
#
# Cookbook Name:: oracledb
# Recipe:: dbca
#
# Copyright IBM Corp. 2016, 2017
#
################################################################################
#
# <> Create RDBMS recipe (dbca.rb)
# <> This recipe will congire Database.

################################################################################

# Create template for Oracle Database Creation

template "#{node['oracledb']['oracle_home']}/assistants/dbca/templates/New_Database_Template.dbt" do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['os_users']['oracle']['gid']
  mode '0644'
  variables(
    DATA_MOUNT:  node['oracledb']['data_mount'],
    ORACLE_BASE: node['oracledb']['oracle_base']
  )
end

execute 'Setting stickybit in the $ORACLE_HOME/bin/oracle ' do
  command "chmod 6751 #{node['oracledb']['oracle_home']}/bin/oracle "
  action :run
end

sys_pw = ''
system_pw = ''
encrypted_id = node['oracledb']['vault']['encrypted_id']
chef_vault = node['oracledb']['vault']['name']
unless chef_vault.empty?
  require 'chef-vault'
  sys_pw = chef_vault_item(chef_vault, encrypted_id)['oracledb']['security']['sys_pw']
  raise "No password found for sys user in chef vault \'#{chef_vault}\'" if sys_pw.empty?
  Chef::Log.info "Found a password for sys user in chef vault \'#{chef_vault}\'"
  system_pw = chef_vault_item(chef_vault, encrypted_id)['oracledb']['security']['system_pw']
  raise "No password found for system user in chef vault \'#{chef_vault}\'" if system_pw.empty?
  Chef::Log.info "Found a password for system user in chef vault \'#{chef_vault}\'"
end

# File permission are specified in oracle documentation :: https://docs.oracle.com/database/121/LADBI/pre_install.htm#LADBI7645
# TODO The default fast recovery area is $ORACLE_BASE/fast_recovery_area.. As per above documentation, oracle recommendation is to have fast_recovery_area in /mount_point/fast_recovery_area
oradata_directory = node['oracledb']['data_mount'] + "/oradata"
directory oradata_directory do
  recursive true
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0755'
  action :create
end

# Configure Oracle Database

bash "dbca_#{node['oracledb']['SID']}" do
  environment node['oracledb']['env']
  timeout 864_00
  code "su - #{node['oracledb']['os_users']['oracle']['name']} -s /bin/bash -c \" #{node['oracledb']['oracle_home']}/bin/dbca -silent -createDatabase -templateName #{node['oracledb']['oracle_home']}/assistants/dbca/templates/New_Database_Template.dbt -gdbname #{node['oracledb']['SID']} -sid #{node['oracledb']['SID']} -sysPassword \\\"#{sys_pw}\\\" -systemPassword \\\"#{system_pw}\\\"\""
  #live_stream node['ibm']['debug_mode']
  not_if { IO.popen("cat /etc/oratab | egrep \"^#{node['oracledb']['SID']}\"").readlines.join.include? node['oracledb']['SID'] }
end

# Create or update Oracle oratab file

template '/etc/oratab' do
  source 'oratab.erb'
  mode '0755'
  variables(
    ORAHOME: node['oracledb']['oracle_home'],
    ORASID: node['oracledb']['SID']
  )
end
