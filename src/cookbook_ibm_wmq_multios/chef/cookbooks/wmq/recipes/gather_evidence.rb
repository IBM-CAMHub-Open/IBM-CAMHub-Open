#
# Cookbook Name:: wmq
# Recipe:: gather_evidence
#
# Copyright IBM Corp. 2016, 2017
#
# <> Evidence gathering recipe (gather_evidence.rb)
# <> This recipe will collect functional product information and store it in an archive.

evidence_file = node['ibm']['evidence_file'].gsub('--cookbook_name--', cookbook_name)
evidence_log = "wmq-#{node['hostname']}.log"

# Create evidence directory
# ----------------------------------------------------------------------------
Chef::Log.info("Create evidence dir #{node['ibm']['evidence_path']}")
directory node['ibm']['evidence_path'] do
  recursive true
  action :create
  mode '0775'
  not_if { File.exist?(evidence_file) }
end

# Create Evidence File
# ------------------------------------------------------------------------------
Chef::Log.info("Storing dspmqver as evidence")
case node['platform_family']
when 'rhel', 'debian'
  execute 'run_dspmqver' do
    command "#{node['wmq']['install_dir']}/bin/dspmqver >> #{evidence_log}"
    action :run
    user node['wmq']['os_users']['mqm']['name']
    group node['wmq']['os_users']['mqm']['gid']
    cwd node['ibm']['evidence_path']
    not_if { File.exist?(evidence_file) }
  end
end

Chef::Log.info("Storing dspmq -o all as evidence")
case node['platform_family']
when 'rhel', 'debian'
  execute 'run_dspmqver_-o_all' do
    command "#{node['wmq']['install_dir']}/bin/dspmq -o all >> #{evidence_log}"
    action :run
    user node['wmq']['os_users']['mqm']['name']
    group node['wmq']['os_users']['mqm']['gid']
    cwd node['ibm']['evidence_path']
    not_if { File.exist?(evidence_file) }
  end
end

# Compress Evidence Log
# ----------------------------------------------------------------------------
Chef::Log.info("Creating #{evidence_file}")
ibm_cloud_utils_tar "Create_#{evidence_file}" do
  source "#{node['ibm']['evidence_path']}/#{evidence_log}"
  target_tar evidence_file
  not_if { File.exist?(evidence_file) }
end
