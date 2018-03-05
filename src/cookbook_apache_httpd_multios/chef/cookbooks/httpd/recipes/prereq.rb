# Cookbook Name:: httpd
# Recipe:: prereq
#
# Copyright IBM Corp. 2016, 2017
#
# <> Prerequisites recipe (prereq.rb)
# <> Perform prerequisite tasks.

ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end

dir_owner = node['httpd']['os_users']['web_content_owner']['name']
dir_owner.empty? && dir_owner = 'root'
validation_script = "#{node['ibm']['evidence_path']['unix']}/http_validation.sh"
ssl_port = node['httpd']['ssl']['https_port']
ssl_enabled = node['httpd']['ssl']['install_mod_ssl']

#TODO - Check disk space
# create OS users and groups

node['httpd']['os_users'].each_pair do |_key, user|
  next if user['ldap_user'] == 'true' || user['name'].nil? || user['name'].empty? # || user['name'] == 'apache'

  group user['gid'] do
    action :create
  end

  user user['name'] do
    action :create
    comment user['comment']
    home user['home']
    gid user['gid']
    shell user['shell']
    manage_home true
  end
end

# Create expand area

directory node['ibm']['expand_area'] do
  action :create
  mode '0755'
  recursive true
end


# Create home for data dir

directory node['httpd']['httpd_home'] do
  action :create
  mode node['httpd']['data_dir_mode']
  owner dir_owner
  group node['httpd']['os_users']['daemon']['gid']
  recursive true
end

directory node['httpd']['document_root'] do
  action :create
  mode node['httpd']['data_dir_mode']
  owner dir_owner
  group node['httpd']['os_users']['daemon']['gid']
  recursive true
end

# Update the package cache
apt_update 'update' do
  action :update
  only_if { node['platform_family'] == 'debian' }
end

#Clear outstanding package dependencies for DEBIAN only
execute 'run-apt-install' do
  command 'apt-get -y -f install'
  only_if { node['platform_family'] == 'debian' }
end



# Install the prereq packages
node['httpd']['prereq_packages'].each do |p|
  package p do
    action :install
  end
end

# Create the evidence path

directory node['ibm']['evidence_path']['unix'] do
  action :create
  mode '0755'
  recursive true
end

directory node['httpd']['log_dir'] do
  action :create
  mode '0755'
  recursive true
  only_if { node['platform_family'] == 'debian' }
end

template validation_script do
  source 'http_validation.sh.erb'
  cookbook 'httpd' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  mode '0755'
  variables(
    :evidence_dir => node['ibm']['evidence_path']['unix'],
    :evidence_log => node['httpd']['evidence_log'],
    :httpd_user => node['httpd']['os_users']['daemon']['name'],
    :listen => node['httpd']['listen'],
    :ssl_enabled => ssl_enabled,
    :ssl_port => ssl_port
  )
  if node['platform_family'] == 'rhel'
    not_if 'rpm -q httpd'
  elsif node['platform_family'] == 'debian'
    not_if 'dpkg -l apache2'
  end
end
