# Cookbook Name:: ihs
# Recipe:: service_admin
#
# Copyright IBM Corp. 2016, 2017
#

# <> Configure admin server recipe (service_admin.rb)
# <> Configure and manage admin server service

# create sysV service control script if so requested
template "/etc/init.d/#{node['ihs']['admin_server']['service_name']}" do
  source 'ihsadmin.init.erb'
  mode '0750'
  owner 'root'
  group node['ihs']['os_users']['ihs']['gid']
  variables(
    :INSTALLDIR => node['ihs']['install_dir'],
    :IHSVERSION => node['ihs']['version'],
    :SERVICENAME => node['ihs']['admin_server']['service_name'],
    :IHSUSR => node['ihs']['os_users']['ihs']['name'],
    :IHSPORT => node['ihs']['admin_server']['port'],
    :INSTALLMODE => node['ihs']['install_mode']
  )
  only_if { node['ihs']['admin_server']['enabled'].to_s == 'true' && node['ihs']['config_os_service'].to_s == 'true' }
end

# ... and manage service, if requested
service node['ihs']['admin_server']['service_name'] do
  action [:enable, :start]
  supports [:restart, :status]
  only_if { node['ihs']['admin_server']['enabled'].to_s == 'true' && node['ihs']['config_os_service'].to_s == 'true' }
end

# ... or just start it
ruby_block 'start admin server' do
  block do
    cmd = "#{node['ihs']['install_dir']}/bin/adminctl start"
    user = if node['ihs']['install_mode'] == 'admin'
             'root'
           else
             node['ihs']['os_users']['ihs']['name']
           end
    run_shell_cmd(cmd, user)
  end
  only_if { ihs_first_run? }
  not_if { node['ihs']['config_os_service'].to_s == 'true' }
end
