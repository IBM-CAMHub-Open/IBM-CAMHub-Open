#
# Cookbook Name:: db2
# Recipe:: install
#
# Copyright IBM Corp. 2017, 2017
#
# <> Installation recipe (install.rb)
# <> This recipe performs the product installation.

if node['db2']['base_version'] == '0.0.0.0' || node['db2']['base_version'].casecmp('none').zero?
  # installing from fp package
  setup_dir = node['db2']['fp_dir']
  package = node['db2']['fixpack_names']
  sw_repo_path = node['db2']['fp_repo_path']
  version = node['db2']['fp_version'].split('.')[0, 2].join('.')
else
  # installing from base package
  setup_dir = node['db2']['base_dir']
  package = node['db2']['archive_names']
  sw_repo_path = node['db2']['sw_repo_path']
  version = node['db2']['base_version']
end

package.each_pair do |p, v|
  next if p.to_s != version
  filename = v['filename']
  sha256 = v['sha256']

  ibm_cloud_utils_unpack "unpack-#{filename}" do
    source "#{node['ibm']['sw_repo']}#{sw_repo_path}/#{filename}"
    target_dir node['db2']['expand_area']
    checksum sha256 unless sha256.nil?
    remove_local true
    vault_name node['db2']['vault']['name']
    vault_item node['db2']['vault']['encrypted_id']
    repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
  end
end

execute 'Install db2' do
  cwd setup_dir
  command "./db2setup -l #{node['ibm']['log_dir']}/DB2_install.log -r #{node['db2']['expand_area']}/db2_install.rsp"
  not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
end

# Enable db2fmcd for DB2 v10 on systemd
service 'db2fmcd' do
  action [:enable, :start]
  only_if { node['init_package'] == 'systemd' }
  not_if { node['db2']['fp_version'].split('.').first.to_i > 10 }
end
