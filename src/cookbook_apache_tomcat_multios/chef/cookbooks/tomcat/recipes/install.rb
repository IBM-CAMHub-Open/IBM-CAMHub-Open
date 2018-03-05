################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Installation recipe (install.rb)
# <> Perform an installation of selected tomcat package on the target node.

::Chef::Recipe.send(:include, TomcatHelper)
::Chef::Resource.send(:include, TomcatHelper)

################################################################################
# Setup variables
################################################################################

sw_repo = node['ibm']['sw_repo']
sw_repo_path = node['tomcat']['sw_repo_path']['base']
filename = node['tomcat']['archive_names']['tomcat']['filename']
expand_area = node['tomcat']['expand_area']
catalina_home = node['tomcat']['install_dir']
tomcat_user = node['tomcat']['os_users']['daemon']['name']
tomcat_group = node['tomcat']['os_users']['daemon']['gid']
tomcat_mode = '0750'
tomcat_version = node['tomcat']['version']
tomcat_service = node['tomcat']['service']['name']

instance_dirs = [
  {
    'source_path' => "#{catalina_home}/logs",
    'dest_path' => node['tomcat']['instance_dirs']['log_dir']
  },
  {
    'source_path' => "#{catalina_home}/temp",
    'dest_path' => node['tomcat']['instance_dirs']['temp_dir']
  },
  {
    'source_path' => "#{catalina_home}/work",
    'dest_path' => node['tomcat']['instance_dirs']['work_dir']
  },
  {
    'source_path' => "#{catalina_home}/webapps",
    'dest_path' => node['tomcat']['instance_dirs']['webapps_dir']
  }
]

# Manage base directory
subdirs, reason = subdirs_to_create(catalina_home, tomcat_user)
raise reason unless reason.empty?
subdirs.each do |dir|
  directory "create #{dir}" do
    path dir
    action :create
    recursive true
    owner tomcat_user
    group tomcat_group
    mode tomcat_mode
  end
end

#################################################################################
## Install tomcat
#################################################################################

tomcat_install "Installing to #{catalina_home}" do
  version tomcat_version
  owner tomcat_user
  group tomcat_group
  # mode tomcat_mode
  tomcat_service tomcat_service
  catalina_home catalina_home
  catalina_base catalina_home # future development
  package_path "#{sw_repo}/#{sw_repo_path}/#{filename}"
  expand_area expand_area
  vault_name node['tomcat']['vault']['name']
  vault_item node['tomcat']['vault']['encrypted_id']
  repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
  notifies :restart, "service[#{tomcat_service}]" if notify_service?(catalina_home)
end

################################################################################
# Process user directories
################################################################################

# Process user directories
instance_dirs.each do |dirname|
  next if dirname['dest_path'].empty? || dirname['source_path'] == dirname['dest_path']
  tomcat_link_dirs "manage #{dirname['dest_path']}" do
    dest_dir dirname['dest_path']
    source_dir dirname['source_path']
    owner tomcat_user
    group tomcat_group
    notifies :restart, "service[#{tomcat_service}]" if File.exist?("#{catalina_home}/bin/catalina.sh") # evaluated at compile time
  end
end

################################################################################
# Manage installed apps
################################################################################

node['tomcat']['webapps']['enabled'].each_pair do |webapp, enabled|
  next if webapp.nil? || webapp.empty?
  directory "Removing #{webapp}" do
    path node['tomcat']['instance_dirs']['webapps_dir'] + '/' + webapp
    recursive true
    action :delete
    only_if { enabled.to_s.casecmp('false') == 0 }
  end
end
