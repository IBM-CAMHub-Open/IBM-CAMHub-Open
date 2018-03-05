# Cookbook Name::was
#  Recipe::prereq
#
#	  Copyright IBM Corp. 2016, 2017
#
# <> This recipe will add to the environment the necessary Pre-Requisites to be added prior ro WebSphere Instalation, this will include
# <> Adding users, Packages, Kernel Configuration
#

ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end

ibm_cloud_utils_enable_awsyumrepo 'enable_aws_extra_yumrepo' do
  action :enable
end

if node['was']['features']['com.ibm.sdk.6_32bit'] == "true" && node['was']['features']['com.ibm.sdk.6_64bit'] == "true"
  Chef::Application.fatal!("Select either 32-bit SDK feature OR 64-bit SDK feature.", 1)
end

feature_list=""
node['was']['features'].each_pair do |feature, do_install|
  if do_install == "true"
    feature_list = feature_list + feature + ","
  end
end

if feature_list == ""
  Chef::Application.fatal!("No features selected.", 1)
end

unless feature_list.include?("core.feature") || feature_list.include?("liberty")
  Chef::Application.fatal!("Either \"core.feature\" or \"liberty\" must be selected.", 1)
end

num_of_editions=0
node['was']['edition'].each_pair do |_e, do_install|
  if do_install == "true"
    num_of_editions+=1
  end
end

if num_of_editions != 1
  Chef::Application.fatal!("Only select one edition to be installed.", 1)
end

# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
chef_gem 'chef-vault' do
  action :install
  version '2.9.0'
  compile_time true
end

execute 'Update debian/ubuntu repos' do
  command "apt-get update"
  only_if { node['platform_family'] == "debian" }
end

case node['platform_family']
when 'rhel', 'debian'

  # Install the prereq packages
  node['was']['prereq_packages'].each do |p|
    package p do
      action :install
    end
  end

  # set hard/soft ulimit for open files in /etc/security/limits.conf
  template "/etc/security/limits.d/was-limits.conf" do
    source "was-limits.conf.erb"
    mode '0644'
    variables(
      :OSUSER => (node['was']['os_users']['was']['name']).to_s
    )
  end

  #create OS users and groups
  node['was']['os_users'].each_pair do |_k, u|
    next if u['name'].nil?
    next if u['gid'].nil?
    next if u['ldap_user'] == 'true'
    group u['gid'] do
      action :create
    end

    user u['name'] do
      action :create
      comment u['comment']
      home u['home']
      gid u['gid']
      shell u['shell']
      manage_home true
    end
  end
end

[node['was']['expand_area'], node['ibm']['temp_dir'], node['ibm']['log_dir']].each do |dir|
    directory dir do
      recursive true
      action :create
      mode '0755'
    end
end
