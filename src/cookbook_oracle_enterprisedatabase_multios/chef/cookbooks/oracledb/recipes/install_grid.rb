
#
# Cookbook Name:: oracledb
# Recipe:: install
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install_grid.rb)
# <> This recipe performs the Grid product installation.


# Creating the expand area directory

orabase = node['oracledb']['oracle_base']
ora_grid_home = node['oracledb']['ora_grid_home']

directory "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-grid" do
  recursive true
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0750'
  action :create
end



#   UNZIPPING THE ARCHIVES IN THE EXPAND DIRECTORY

unless Dir.exist? node['oracledb']['oracle_home']

  node['oracledb']['grid']['archive_names'].each do |_version, package|
    filename = package['filename']
    oracle_pkg_url = node['ibm']['sw_repo'] + '/grid/' + node['oracledb']['release_patchset'] + '/' + filename
    ibm_cloud_utils_unpack("Unpack grid binaries : #{filename}") do
      source oracle_pkg_url
      target_dir "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-grid/"
      mode '0755'
      remove_local true
      secure_repo 'true'
      repo_self_signed_cert 'true'
      # not_if { File.exist?("#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-base/database/install/.oui") }
    end
  end
end

=begin
# Create responce directory

directory "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-grid/grid/response" do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  recursive true
  mode '0750'
  action :create
end
=end

# PREPARATION OF GRID RESPONSE FILE

template "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-grid/grid/response/grid.rsp" do
    owner node['oracledb']['os_users']['oracle']['name']
    group node['oracledb']['install_group']
    mode '0640'
    source 'grid.rsp.erb'
    action :create
    variables(
        HOSTNAME:     node['fqdn'],
        ORAINVENTORY: node['oracledb']['grid_ora_inventory'],
        ORABASE:      node['oracledb']['oracle_base'],
        ORAHOME:      node['oracledb']['ora_grid_home']
    )
end


# Editing the oracleInst.loc file
file '/etc/oraInst.loc' do
  owner node['oracledb']['os_users']['oracle']['name']
  mode '0640'
  group node['oracledb']['install_group']
  content "inst_group=#{node['oracledb']['install_group']}\ninventory_loc = #{node['oracledb']['grid_ora_inventory']}"
end


# GRID INSTALLATION
execute 'Execute Grid Installation ' do
  command "su - #{node['oracledb']['os_users']['oracle']['name']} -c \"export ORACLE_HOME=#{ora_grid_home}; export ORACLE_BASE=#{orabase}; #{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-grid/grid/runInstaller -responseFile #{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/oracle-setup-grid/grid/response/grid.rsp -silent -ignorePrereq -ignoreInternalDriverError -waitforcompletion\""
  not_if { ::Dir.exist?("#{node['oracledb']['ora_grid_home']}/oui") }
end
