# Cookbook Name:: ihs
# Recipe:: service_httpd
#
# Copyright IBM Corp. 2016, 2017
#

# <> Configure web server recipe (service_httpd.rb)
# <> Configure and manage web service

# create sysV service control script if so requested
template "/etc/init.d/#{node['ihs']['service_name']}" do
  source 'ihs.init.erb'
  mode '0750'
  owner 'root'
  group node['ihs']['os_users']['ihs']['gid']
  variables(
    :INSTALLDIR => node['ihs']['install_dir'],
    :IHSVERSION => node['ihs']['version'],
    :SERVICENAME => node['ihs']['service_name'],
    :IHSUSR => node['ihs']['os_users']['ihs']['name'],
    :IHSPORT => node['ihs']['port'],
    :INSTALLMODE => node['ihs']['install_mode']
  )
  only_if { node['ihs']['config_os_service'].to_s == 'true' }
end

# Enable IHS service
service "Enable #{node['ihs']['service_name']}" do
  service_name node['ihs']['service_name']
  action :enable
  supports [:restart, :status]
  only_if { node['ihs']['config_os_service'].to_s == 'true' }
end

# ...and manage
service node['ihs']['service_name'] do
  action :start
  supports [:restart, :status]
  only_if { node['ihs']['config_os_service'].to_s == 'true' }
  not_if { node['ihs']['plugin']['enabled'].to_s == 'true' } # not when fronting WAS
end

# ... or just start it, when:
#   - was mode, ihs_first_run
#   - non-was mode when config_os_service == false
#   - but not if config_os_service == true in non-was mode

ruby_block 'start webserver' do
  block do
    cmd = "#{node['ihs']['install_dir']}/bin/apachectl start"
    user = if node['ihs']['install_mode'] == 'admin'
             'root'
           else
             node['ihs']['os_users']['ihs']['name']
           end
    run_shell_cmd(cmd, user)
  end
  only_if { node['ihs']['plugin']['enabled'].to_s == 'true' || node['ihs']['config_os_service'].to_s != 'true' }
  only_if { File.exist?("#{node['ihs']['expand_area']}/ihs_validation.sh") }
end
