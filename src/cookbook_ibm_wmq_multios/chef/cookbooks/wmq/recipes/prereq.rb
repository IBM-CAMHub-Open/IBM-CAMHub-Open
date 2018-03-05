#
# Cookbook Name:: mq80
# Recipe:: prereq
#
# Copyright IBM Corp. 2016, 2017
#
# <> Prerequisites recipe (prereq.rb)
# <> This recipe configures the operating prerequisites for the product.

ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end
# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
# chef_gem 'chef-vault' do
#   action :install
#   compile_time true
# end

####
expand_area = node['wmq']['expand_area']
setup_base = expand_area + '/base'

#if node['platform_family'] == 'aix'
#  filesets = setup_base + '/aix/' + node['wmq']['aix-version']
#end

install_dir = node['wmq']['install_dir']
evidence_path = node['ibm']['evidence_path']

swap_file_size = node['wmq']['swap_file_size']
swap_file_name = node['wmq']['swap_file']

# Create users and groups
# ------------------------------------------------------------------------------

Chef::Log.info("Creating users and groups")
case node['platform_family']
when 'rhel', 'debian'
  node['wmq']['os_users'].each_pair do |_k, u|
    next if u['ldap_user'] == 'true' || u['name'].nil?
    group u['gid'] do
      action :create
      not_if { u['gid'].nil? }
    end
    next if u['name'] == 'root'
    user u['name'] do
      supports 'manage_home' => true
      comment u['comment']
      gid u['gid']
      home u['home']
      shell u['shell']
      action :create
    end
    directory u['home'] do
      recursive true
      action :create
      owner u['name']
      group u['gid']
    end
  end
end

# KERNEL PARAMS
# ------------------------------------------------------------------------------

Chef::Log.info("Setting kernel parameters")
case node['platform_family']
when 'rhel', 'debian'
  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.core.rmem_default"
    value node['wmq']['net_core_rmem_default']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.core.rmem_max"
    value node['wmq']['net_core_rmem_max']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.core.wmem_default"
    value node['wmq']['net_core_wmem_default']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.core.wmem_max"
    value node['wmq']['net_core_wmem_max']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_rmem"
    value node['wmq']['net_ipv4_tcp_rmem']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_wmem"
    value node['wmq']['net_ipv4_tcp_wmem']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_sack"
    value node['wmq']['net_ipv4_tcp_sack']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_timestamps"
    value node['wmq']['net_ipv4_tcp_timestamps']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_window_scaling"
    value node['wmq']['net_ipv4_tcp_window_scaling']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_keepalive_time"
    value node['wmq']['net_ipv4_tcp_keepalive_time']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_keepalive_intvl"
    value node['wmq']['net_ipv4_tcp_keepalive_intvl']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "net.ipv4.tcp_fin_timeout"
    value node['wmq']['net_ipv4_tcp_fin_timeout']
  end

  ibm_cloud_utils_ibm_cloud_sysctl "apply" do
    key "vm.swappiness"
    value node['wmq']['vm_swappiness']
  end
end

# Configure Shell Limits and System Configuration Parameters
# ------------------------------------------------------------------------------
Chef::Log.info("Configuring Shell and ulimit for mqm user")
case node['platform_family']
when 'rhel', 'debian'
  execute 'set_ulimit' do
    command "echo 'ulimit -n 10240' >> /root/.bashrc; . /root/.bashrc"
    not_if { IO.popen('cat /root/.bashrc').readlines.join.include? 'ulimit -n 10240' }
  end
end

case node['platform_family']
when 'rhel', 'debian'
  template '/etc/security/limits.conf' do
    owner 'root'
    group 'root'
    source 'wmq-limits.conf.erb'
    variables(
      'user' => node['wmq']['os_users']['mqm']['name'],
      'nofile_value' => node['wmq']['nofile_value']
    )
  end
end

# Linux Package installation
# ------------------------------------------------------------------------------
apt_update 'update' do
  action :update
  only_if { node['platform_family'] == 'debian' }
end

execute 'enable_extra_repository' do
  command 'yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional'
  only_if { node['wmq']['prereqs'].include?('compat-libstdc++-33') }
  not_if 'yum list compat-libstdc++-33'
  only_if { node['platform_family'] == 'rhel' }
  only_if { node['platform_version'].split('.').first.to_i >= 7 }
  not_if { File.foreach('/sys/devices/virtual/dmi/id/bios_version').grep(/amazon$/).empty? }
end

prereqs =  node['wmq']['prereqs']
Chef::Log.info("Installing pre-requisite packages. #{prereqs}")
case node['platform_family']
when 'rhel', 'debian'
  prereqs.each do |p|
    package p do
      action :install
    end
  end
end


# Preparation base directory for installation
# ------------------------------------------------------------------------------
Chef::Log.info("Configuring base directory #{install_dir}")
case node['platform_family']
when 'rhel', 'debian'
  directory install_dir do
    owner 'root'
    group 'root'
    mode node['wmq']['perms']
    action :create
    recursive true
    not_if { wmq_installed? }
  end
end

# Preparation base directory for packages unpack
# ------------------------------------------------------------------------------

Chef::Log.info("Configuring expand area #{setup_base}")
directory setup_base do
  owner 'root'
  group 'root'
  mode '0775'
  action :create
  recursive true
  not_if { wmq_installed? }
end


# Create Evidence Log directory
# ------------------------------------------------------------------------------

Chef::Log.info("Configuring evidence directory #{evidence_path}")
directory evidence_path do
  recursive true
  action :create
end

# Create data & logs directories
# ------------------------------------------------------------------------------
Chef::Log.info("Configuring mq log and data directory #{node['wmq']['data_dir']}, #{node['wmq']['log_dir']}")
case node['platform_family']
when 'rhel', 'debian'
  [node['wmq']['data_dir'], node['wmq']['log_dir']].each do |dirs|
    directory dirs do
      owner node['wmq']['os_users']['mqm']['name']
      group node['wmq']['os_users']['mqm']['gid']
      mode '0775'
      recursive true
      action :create
    end
  end
end

# Create a regular swap file
# ------------------------------------------------------------------------------
ibm_cloud_utils_ibm_cloud_swap swap_file_name do
  action :enable
  swapfile swap_file_name
  size swap_file_size
  label swap_file_name
end
