################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Create init script (configure_tomcat_init.rb)
# <> Create init script.

catalina_home = node['tomcat']['install_dir']
catalina_base = catalina_home
tomcat_user = node['tomcat']['os_users']['daemon']['name']
tomcat_group = node['tomcat']['os_users']['daemon']['gid']
tomcat_log_dir = node['tomcat']['instance_dirs']['log_dir']
tomcat_pidfile = tomcat_log_dir + '/tomcat8.pid'
tomcat_service = node['tomcat']['service']['name']
java_home = node['tomcat']['java']['java_home']
catalina_opts = node['tomcat']['java']['catalina_opts']
java_opts = node['tomcat']['java']['java_opts']
java_vendor = node['tomcat']['java']['vendor']
java_home = node['tomcat']['java']['java_home']

# Create env script
template "#{catalina_base}/bin/setenv.sh" do
  source 'setenv.sh.erb'
  mode '0755'
  owner tomcat_user
  group tomcat_group
  variables(
    lazy do
      {
        :java_home => java_vendor == 'openjdk' ? File.dirname(File.dirname(File.realpath('/usr/bin/java'))) : java_home,
        :java_opts => java_opts,
        :catalina_opts => catalina_opts,
        :catalina_home => catalina_home,
        :catalina_base => catalina_base,
        :tomcat_user => tomcat_user,
        :tomcat_group => tomcat_group,
        :catalina_pid => tomcat_pidfile
      }
    end
  )
  notifies :restart, "service[#{tomcat_service}]" if notify_service?(catalina_home)
end

################################################################################
# Service Script
################################################################################

case node['init_package']
when 'init' # good ole sysV
  init_script = "/etc/init.d/#{tomcat_service}"
  script_template = 'tomcat-sysV.erb'
when 'systemd' # RHEL7, SLES12, Ubuntu 16.04
  init_script = "/etc/systemd/system/#{tomcat_service}.service"
  script_template = 'tomcat-systemd.erb'
when 'upstart' # Debian
  init_script = "/etc/init/#{tomcat_service}.conf"
  script_template = 'tomcat-upstart.erb'
end

template init_script do
  source script_template
  mode '0755'
  variables(
    :catalina_home => catalina_home,
    :tomcat_user => tomcat_user,
    :tomcat_group => tomcat_group,
    :catalina_pid => tomcat_pidfile
  )
  notifies :restart, "service[#{tomcat_service}]" if notify_service?(catalina_home)
end
