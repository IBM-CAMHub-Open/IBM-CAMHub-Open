#
# Cookbook Name:: oracle_mysql
# Recipe:: prereq
#
# Copyright IBM Corp. 2016, 2017
#
# <> Prerequisite recipe (prereq.rb)
# <> This recipe configures the operating prerequisites for the product.

ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end
################################################################################
# create OS users and groups
################################################################################

node['mysql']['os_users'].each_pair do |_key, user|
  next if user['ldap_user'] == 'true' || user['name'].nil?

  group user['gid'] do
    action :create
    not_if "getent group #{user['gid']}"
  end

  user user['name'] do
    action :create
    comment user['comment']
    home user['home']
    gid user['gid']
    shell user['shell']
    manage_home true
    not_if "getent passwd #{user['name']}"
  end
end

# Create expand area

directory node['ibm']['expand_area'] do
  action :create
  mode '0755'
  recursive true
end

case node['platform_family']
when 'rhel'
  # <> Archive names for RHEL6/7 and version separation
  if node['platform_version'].start_with?("7.")
    # Remove MariaDb libs
    package 'mariadb-libs' do
      action :remove
    end
  elsif node['platform_version'].start_with?("6.")
    package 'mysql-libs' do
      action :remove
    end
  end
when "debian"
  execute 'Update debian/ubuntu repos' do
    command "apt-get update"
  end

  apt_package 'install_prerequisites' do
    package_name node['mysql']['prereq_libraries']
    action :upgrade
  end
end
# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
chef_gem 'chef-vault' do
  action :install
  compile_time true
end
