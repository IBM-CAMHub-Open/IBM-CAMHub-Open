# Cookbook Name:: httpd
# Recipe:: gather_evidence
#
# Copyright IBM Corp. 2016, 2017
#
# <> Gather evidence recipe (gather_evidence.rb)
# <> Gather evidence that installation was successful

evidence_dir = node['ibm']['evidence_path']['unix']
evidence_tar = node['httpd']['evidence_zip']
httpd_logs = "#{node['httpd']['log_dir']}/*"
validation_script = "#{node['ibm']['evidence_path']['unix']}/http_validation.sh"

# Run validation script

execute 'Verify_installation' do
  command validation_script
  only_if { File.exist?(validation_script) } # script exists only at first run
end

# Archive logs and artifacts

ibm_cloud_utils_tar "Create_#{evidence_tar}" do
  source "#{evidence_dir}/#{node['httpd']['evidence_log']} #{httpd_logs}"
  target_tar evidence_tar
  only_if { File.exist?(validation_script) } # script exists only at first run
end

# Remove validation script

file 'Removing validation script' do
  path validation_script
  action :delete
end
