################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Gather evidence recipe (gather_evidence.rb)
# <> Gather evidence that installation was successful

evidence_dir = node['ibm']['evidence_path']['unix']
evidence_tar = node['ibm']['evidence_tar']
validation_log = node['tomcat']['validation_log']
catalina_logs = node['tomcat']['instance_dirs']['log_dir']
validation_script = node['tomcat']['validation_script']

################################################################################
# Run validation script
################################################################################
execute 'Validate installation' do
  command validation_script
  only_if { File.exist?(validation_script) } # script exists only at first run
end

################################################################################
# Tar logs
################################################################################
ibm_cloud_utils_tar "Create #{evidence_tar}" do
  source "#{evidence_dir}/#{validation_log} #{catalina_logs}/"
  target_tar evidence_tar
  only_if { File.exist?(validation_script) } # script exists only at first run
end

################################################################################
# Remove validation script
################################################################################
file 'Remove validation script' do
  path validation_script
  action :delete
  only_if { File.exist?(validation_script) } # script exists only at first run
end
