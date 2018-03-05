#
# Cookbook Name:: oracledb
# Recipe:: services
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (services.rb)
# <> This recipe creates and starts database services.

################################################################################
# Oracle service creation
################################################################################


# Oracle service creation
template '/etc/init.d/oracle' do
  source 'ora_init_script.erb'
  mode '0750'
  variables(
    ORAHOME: node['oracledb']['oracle_home'],
    ORAUSER: node['oracledb']['os_users']['oracle']['name']
  )
end

directory "#{node['oracledb']['oracle_home']}/bin" do
  mode '0750'
  recursive true
end

service "oracle" do
  supports :status => true
  action [:enable, :start]
end

################################################################################
# Oracle qlogin.sql run to set oracle user login information
################################################################################
glogin_sql = "#{node['oracledb']['oracle_home']}/sqlplus/admin/glogin.sql"
cookbook_file "#{node['oracledb']['oracle_home']}/sqlplus/admin/glogin.sql" do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['os_users']['oracle']['gid']
  mode '0644'
  only_if { File.exist?(glogin_sql) }
end
