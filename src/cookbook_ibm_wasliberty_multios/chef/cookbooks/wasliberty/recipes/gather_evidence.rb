#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Gather evidence recipe (gather_evidence.rb)
# <> Gather evidence that installation was successful
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - gather_evidence
#----------------------------------------------------------------------------------------------------------------------------------------------

Chef::Log.info("-------------------------------------")
Chef::Log.info("start executing recipe\\gather_evidence.rb\n")

evidence_dir = node['ibm']['evidence_path']
evidence_tar = node['ibm']['evidence_tar'].gsub('--cookbook_name--', cookbook_name)
evidence_log = "#{cookbook_name}-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.log"
validation_script = "#{node['was_liberty']['install_dir']}/bin/productInfo"

# Create Evidence Directory
directory evidence_dir do
  recursive true
  action :create
end

# Run validation script
execute 'Verify installation' do
  command "su - #{node['was_liberty']['install_user']} -c '#{validation_script} version >> #{evidence_dir}/#{evidence_log}'"
  only_if { File.exist?(validation_script) }
end

# Tar logs
ibm_cloud_utils_tar "Create_#{evidence_tar}" do
  source "#{evidence_dir}/#{evidence_log}"
  target_tar evidence_tar
  only_if { File.exist?(validation_script) }
end
