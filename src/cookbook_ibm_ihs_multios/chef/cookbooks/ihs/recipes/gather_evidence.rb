# Cookbook Name:: ihs
# Recipe:: gather_evidence
#
# Copyright IBM Corp. 2016, 2017
#

# <> Gather evidence recipe (gather_evidence.rb)
# <> Gather evidence that installation was successful

evidence_dir = node['ibm']['evidence_path']
evidence_tar = node['ibm']['evidence_file']
evidence_log = "ihs-#{node['hostname']}.log"
ihs_logs = "#{node['ihs']['install_dir']}/logs/postinstall/*"
validation_script = "#{node['ihs']['expand_area']}/ihs_validation.sh"

# Run validation script
execute 'Verify installation - IHS' do
  command validation_script
  only_if { ihs_first_run? }
end

# Tar logs
ibm_cloud_utils_tar "Create_#{evidence_tar} - IHS" do
  source "#{evidence_dir}/#{evidence_log} #{ihs_logs}"
  target_tar evidence_tar
  only_if { ihs_first_run? }
end

# Remove validation script
execute 'Remove validation script - IHS' do
  command "rm -f #{validation_script}"
  only_if { ihs_first_run? }
end
