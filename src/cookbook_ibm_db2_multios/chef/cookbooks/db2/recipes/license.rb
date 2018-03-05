#
# Cookbook Name:: db2
# Recipe:: license
#
# Copyright IBM Corp. 2017, 2017
#
# <> License recipe (license.rb)
# <> This recipe will apply the license file from a repo server, in case a base package cannot be installed.

if node['platform_family'] == 'debian'

  ibm_cloud_utils_unpack "unpack-#{node['db2']['license_package']}" do
    source "#{node['ibm']['sw_repo']}#{node['db2']['sw_license_path']}/#{node['db2']['license_package']}"
    target_dir node['db2']['expand_area']
    remove_local true
    vault_name node['db2']['vault']['name']
    vault_item node['db2']['vault']['encrypted_id']
    repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    only_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
  end

  execute 'Install db2 license' do
    cwd node['db2']['install_dir']
    command "./adm/db2licm -a #{node['db2']['expand_area']}/ese_u/db2/license/db2ese_u.lic"
    only_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
  end
end
