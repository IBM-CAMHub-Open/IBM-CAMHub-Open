#
# Cookbook Name:: db2
# Recipe:: prereq
#
# Copyright IBM Corp. 2017, 2017
#
# <> Prerequisite recipe (prereq.rb)
# <> This recipe configures the operating prerequisites for the product.

dirs = { '/var' => 512,
         '/tmp' => 2048,
         node['db2']['install_dir'] => 500,
         node['ibm']['temp_dir'] => 4096,
         '/home' => 1536 }

dirs.each_pair do |dir, size|
  ibm_cloud_utils_freespace "check-freespace-for-#{dir}-directory" do
    path dir
    required_space size
    continue true
    action :check
    error_message "Please make sure you have at least #{size}MB free space under #{dir}"
  end
end

ibm_cloud_utils_ram "Check RAM" do
  required "1024"
  action :check
  error_message "Please make sure you have at least 1 GB of RAM"
end

# Install prerequisites
case node['platform_family']
when 'rhel'

  execute 'enable_extra_repository' do
    command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
    only_if { node['db2']['os_libraries'].include?('compat-libstdc++-33') }
    not_if 'yum list compat-libstdc++-33'
    only_if { node['platform_family'] == 'rhel' }
    only_if { node['platform_version'].split('.').first.to_i >= 7 }
    not_if { File.foreach('/sys/devices/virtual/dmi/id/bios_version').grep(/amazon$/).empty? }
  end

  # Install the prereq packages
  node['db2']['os_libraries'].each do |p|
    package p do
      action :install
    end
  end

when 'debian'

  execute 'enable_extra_repository' do
    command 'dpkg --add-architecture i386'
  end

  execute 'update repos' do
    command 'apt-get update'
  end

  node['db2']['os_libraries'].each do |p|
    package p do
      action :install
    end
  end
end

[node['ibm']['log_dir'], node['db2']['expand_area']].each do |dir|
  directory "Creating prereq directories: #{dir}" do
    path dir
    mode '755'
    recursive true
    action :create
  end
end

# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
chef_gem 'chef-vault' do
  action :install
  compile_time true
end

require 'chef-vault'
das_password = ''
encrypted_id = node['db2']['vault']['encrypted_id']
chef_vault = node['db2']['vault']['name']
unless chef_vault.empty?
  require 'chef-vault'
  das_password = chef_vault_item(chef_vault, encrypted_id)['db2']['das_password']
  raise "No password found for DAS user in chef vault \'#{chef_vault}\'" if das_password.empty?
  log "Found a password for DAS user in chef vault \'#{chef_vault}\'"
end

# Create DB2 repsonse file for DB2 installation
rsp_file = "#{node['db2']['expand_area']}/db2_install.rsp"
template rsp_file do
  source 'db2_install.rsp.erb'
  owner 'root'
  group 'root'
  mode '0644'
  sensitive true
  variables(
    :VERSION => node['db2']['version'],
    :DAS_USERNAME => node['db2']['das_username'],
    :DAS_PASSWORD => das_password
  )
  not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
end

# Create service file for DB2 v10 on systemd systems
template '/etc/systemd/system/db2fmcd.service' do
  source 'db2fmcd.service.erb'
  owner 'root'
  group 'root'
  mode '0640'
  variables(
    :INSTALL_DIR => node['db2']['install_dir']
  )
  only_if { node['init_package'] == 'systemd' }
  not_if { node['db2']['fp_version'].split('.').first.to_i > 10 }
end

node['db2']['kernel'].each_pair do |k, v|
  ruby_block "set-#{k}" do
    block do
      file = Chef::Util::FileEdit.new("/etc/sysctl.conf")
      file.search_file_replace_line(/^#{k}/, "#{k} = #{v}")
      file.insert_line_if_no_match(/^#{k}/, "#{k} = #{v}")
      file.write_file
    end
    notifies :run, 'execute[reload-sysctl]', :immediately
    not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
  end
end

execute 'reload-sysctl' do
  command 'sysctl -e -p'
  action :nothing
end
