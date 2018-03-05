# Cookbook Name::was
# Recipe::gather_evidence
#
#         Copyright IBM Corp. 2016, 2017
#
# <>  Gather evidence that installation was successful
#
evidence_dir = node['ibm']['evidence_path']
evidence_tar = node['ibm']['evidence_file']
evidence_log = node['ibm']['evidence_log']
validation_script = "#{node['was']['install_dir']}/bin/versionInfo.sh"

################################################################################
# Create Evidence Directory
################################################################################

[node['ibm']['evidence_path']].each do |dir|
    directory dir do
      recursive true
      action :create
      mode '0755'
    end
end


################################################################################
# Run validation script
################################################################################
execute 'Verify installation' do
  command "#{validation_script} -maintenancePackages >> #{evidence_dir}/#{evidence_log}"
  only_if { File.exist?(validation_script) } # script exists only at first run
end

################################################################################
# Tar logs
################################################################################
ibm_cloud_utils_tar "Create_#{evidence_tar}" do
  source "#{evidence_dir}/#{evidence_log}"
  target_tar evidence_tar
  only_if { File.exist?(validation_script) } # script exists only at first run
end
