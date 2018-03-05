#
# Cookbook Name:: db2
# Recipe:: gather_evidence
#
# Copyright IBM Corp. 2017, 2017
#
# <> Evidence gathering recipe (gather_evidence.rb)
# <> This recipe will collect functional product information and store it in an archive.

evidence_dir = node['ibm']['evidence_path']
evidence_tar = node['ibm']['evidence_zip']
evidence_log = "#{cookbook_name}-#{node['hostname']}.log"

################################################################################
# Create Evidence Directory
################################################################################

directory node['ibm']['evidence_path'] do
  recursive true
  action :create
  mode '775'
end

################################################################################
# Run validation script
################################################################################
execute 'Verify installation' do
  command "#{node['db2']['install_dir']}/bin/db2val -l #{evidence_dir}/#{evidence_log}"
  only_if { Dir.glob("#{node['ibm']['evidence_path']}/#{cookbook_name}*.tar").empty? }
end


################################################################################
# Tar logs
################################################################################
ibm_cloud_utils_tar "Create_#{node['ibm']['evidence_zip']}" do
  source "#{evidence_dir}/#{evidence_log}"
  target_tar evidence_tar
  only_if { Dir.glob("#{node['ibm']['evidence_path']}/#{cookbook_name}*.tar").empty? }
end
