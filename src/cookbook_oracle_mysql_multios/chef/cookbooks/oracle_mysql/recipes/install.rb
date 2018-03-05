#
# Cookbook Name:: oracle_mysql
# Recipe:: install
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install.rb)
# <> This recipe performs the product installation.


node['mysql']['archive_names'].each_pair do |_key, source|
  filename = source['filename']
  sha256 = source['sha256']
  Chef::Log.info("Unpacking artifacts #{filename}...")
  Chef::Log.info("Shasum is #{sha256}...")

  ibm_cloud_utils_unpack "unpack-#{filename}" do
    source "#{node['ibm']['sw_repo']}/#{node['mysql']['sw_repo_path']}/#{filename}"
    target_dir node['ibm']['expand_area']
    checksum sha256
    vault_name node['mysql']['vault']['name']
    vault_item node['mysql']['vault']['encrypted_id']
    repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    remove_local false
    not_if { mysql_installed?(node['mysql']['config']['data_dir'], node['mysql']['version']) }
  end

end


case node['platform_family']
when 'rhel'
  node['mysql']['archive_names'].each_pair do |_key, pkg|
    pkg['binaries'].each do |binary|
      package binary do
        action :install
        source node['ibm']['expand_area']+"/#{binary}"
        not_if { mysql_installed?(node['mysql']['config']['data_dir'], node['mysql']['version']) }
      end
    end
  end
when 'debian'
  node['mysql']['archive_names'].each_pair do |_key, pkg|
    pkg['binaries'].each do |binary|
      dpkg_package binary do
        action :install
        source node['ibm']['expand_area']+"/#{binary}"
        not_if { mysql_installed?(node['mysql']['config']['data_dir'], node['mysql']['version']) }
      end
    end
    pkg['server'].each do |server_pkg|
      execute "install server package #{server_pkg}" do
        command "dpkg --unpack -R #{node['ibm']['expand_area']}/#{server_pkg}"
        not_if { mysql_installed?(node['mysql']['config']['data_dir'], node['mysql']['version']) }
      end
    end
  end
when 'windows'

end
