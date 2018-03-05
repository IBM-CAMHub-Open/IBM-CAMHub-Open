#
# Cookbook Name:: oracledb
# Recipe:: gather_evidence
#
# Copyright IBM Corp. 2016, 2017
#
# <> Evidence gathering recipe (gather_evidence.rb)
# <> This recipe will collect functional product information and store it in an archive.

evidence_tar = node['ibm']['evidence_file'].gsub('--cookbook_name--', cookbook_name)
evidence_log = node['ibm']['evidence_log'].gsub('--cookbook_name--', cookbook_name)
evidence_dir = node['ibm']['evidence_path'].gsub('--cookbook_name--', cookbook_name)

# create evidence directory
directory evidence_dir do
  owner 'root'
  group 'root'
  mode '0750'
  recursive true
  action :create
end

# setup validation script
template "#{evidence_dir}/ora_rdbms_validation.sh" do
  source 'ora_rdbms_validation.sh.erb'
  mode '0750'
  variables(
    evidence_dir: evidence_dir,
    evidence_log: evidence_log,
    listen: node['oracledb']['port'],
    orabase: node['oracledb']['oracle_home'],
    orauser: node['oracledb']['os_users']['oracle']['name']
  )
  only_if { Dir.glob("#{evidence_dir}/#{cookbook_name}*.tar").empty? }
end

# Executing the validation script
# - Checking install base directory created
# - Checking oracle user creation
# - Checking existance of /etc/init.d/oracle
# - Checking oracle services
# - Checking listening port
ora_rdbms_validation_sh = "#{evidence_dir}/ora_rdbms_validation.sh"
execute ora_rdbms_validation_sh do
  # Waiting 30 seconds for Oracle service to start
  command "sleep 30; #{ora_rdbms_validation_sh}"
  only_if { Dir.glob("#{evidence_dir}/#{cookbook_name}*.tar").empty? }
end


# Tar logs and put in evidence directory
ibm_cloud_utils_tar "Create_#{evidence_tar}" do
  source "#{evidence_dir}  #{node['oracledb']['db_ora_inventory']}/logs/*"
  target_tar evidence_tar
  only_if { Dir.glob("#{evidence_dir}/#{cookbook_name}*.tar").empty? }
end
