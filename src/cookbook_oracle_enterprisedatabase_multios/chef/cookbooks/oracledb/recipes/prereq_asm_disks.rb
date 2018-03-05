################################################################################
#
# Cookbook Name:: oracledb
# Recipe:: prereq_asm_disks
#
# Copyright IBM Corp. 2016, 2017
#
################################################################################
#
# <> Installation recipe (prereq_asm_disks.rb)
# <> This recipe configures the operating prerequisites for the ASM.

################################################################################


########################################################
# ASM libraries and utility instalaltion
########################################################

oracleasm_support_path_split = node['oracledb']['asm']['oracleasm-support'].split('/')
oracleasm_support_binary = oracleasm_support_path_split[oracleasm_support_path_split.length - 1]

ibm_cloud_utils_unpack("Unpack grid binaries : #{oracleasm_support_binary}") do
    source node['oracledb']['asm']['oracleasm-support'] + ".tar"
    target_dir "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/#{oracleasm_support_binary}"
    mode '0755'
    remove_local true
    secure_repo 'true'
    repo_self_signed_cert 'true'
    not_if "rpm -qa | grep oracleasm-support"
end

oracleasmlib_path_split = node['oracledb']['asm']['oracleasmlib'].split('/')
oracleasmlib_binary = oracleasmlib_path_split[oracleasmlib_path_split.length - 1]

ibm_cloud_utils_unpack("Unpack grid binaries : #{oracleasmlib_binary}") do
    source node['oracledb']['asm']['oracleasm-support'] + ".tar"
    target_dir "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/#{oracleasmlib_binary}"
    mode '0755'
    remove_local true
    secure_repo 'true'
    repo_self_signed_cert 'true'
    not_if "rpm -qa | grep oracleasmlib"
end

yum_package "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/#{oracleasm_support_binary}" do
    action :install
    not_if "rpm -qa | grep oracleasm-support"
end

yum_package "#{node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)}/#{oracleasmlib_binary}" do
    action :install
    not_if "rpm -qa | grep oracleasmlib"
end


# ASM modules start

execute 'Starting Oracle ASM modules' do
  command 'modprobe oracleasm'
  action :run
  not_if "lsmod | grep oracleasm"
end


# ASM configure

template '/etc/sysconfig/oracleasm' do
  source 'oracleasm.erb'
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0750'
  variables(
    ORACLEASM_UID:       node['oracledb']['os_users']['oracle']['name'],
    ORACLEASM_GID:       node['oracledb']['install_group']
  )
end


# ASM initialization with new configuration

execute 'Init Oracle ASM with the new configuration ' do
  command 'oracleasm init'
  action :run
end


# ASM directory ownership change

directory '/dev/oracleasm' do
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  mode '0750'
  recursive true
  action :create
end


# ASM disk scaning

execute 'Starting scan for ASM disks' do
  command 'oracleasm scandisks'
  action :run
end

########################################################
# ASM FRA disks volumes creation
########################################################

node['oracledb']['asm']['fra_diskpartitions'].each do |volname, diskname|
  execute "Creating #{volname} volumes" do
    command "oracleasm createdisk #{volname} #{diskname}"
    action :run
    not_if "oracleasm listdisks | grep #{volname}"
  end
end

# Oracleasm rescan
execute 'Oracle ASM scandisks for FRA volumes' do
command 'oracleasm scandisks'
end

########################################################
# ASM DATA disks volumes creation
########################################################

node['oracledb']['asm']['data_diskpartitions'].each do |volname, diskname|
  execute "Creating #{volname} volumes" do
    command "oracleasm createdisk #{volname} #{diskname}"
    action :run
    not_if "oracleasm listdisks | grep #{volname}"
  end
end

# Oracleasm rescan
execute 'Oracle ASM scandisks for data volumes' do
command 'oracleasm scandisks'
end
