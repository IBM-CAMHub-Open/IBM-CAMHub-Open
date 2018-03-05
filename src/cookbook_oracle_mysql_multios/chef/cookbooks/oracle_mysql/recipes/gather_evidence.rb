#
# Cookbook Name:: oracle_mysql
# Recipe:: gather_evidence
#
# Copyright IBM Corp. 2016, 2017
#
# <> Evidence gathering recipe (gather_evidence.rb)
# <> This recipe will collect functional product information and store it in an archive.


evidence_zip = node['ibm']['evidence_zip']
evidence_log = node['ibm']['evidence_log']
evidence_dir = node['ibm']['evidence_path']['unix']
mysql_log = node['mysql']['config']['log_file']
evidence_command = "netstat -nltpu | grep #{node['mysql']['config']['port']} > #{evidence_dir}/#{evidence_log}"
puts("gather_evidence: #{evidence_zip}")

# Create the evidence directory
directory evidence_dir do
  action :create
  mode '0755'
  recursive true
  not_if { Dir.exist?(evidence_dir) }
end

# Verify the installation using netstat command
execute 'Verify_installation' do
  command evidence_command
  only_if { Dir.exist?(evidence_dir) }
end

# Create the evindece tar file
ibm_cloud_utils_tar "Create_#{evidence_zip}" do
  case node['platform']
  when 'redhat'
    source "#{evidence_dir}/#{evidence_log} #{mysql_log}"
  when 'ubuntu'
    source "#{evidence_dir}/#{evidence_log}"
  end
  target_tar evidence_zip
  not_if { File.exist?("#{evidence_dir}/#{evidence_zip}") } # script exists only at first run
end
