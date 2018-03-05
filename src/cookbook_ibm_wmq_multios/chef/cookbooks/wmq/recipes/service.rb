#
# Cookbook Name:: wmq
# Recipe:: service
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create the MQ service and enables it on RHEL 7

# <> Determine Service Type, systemd or not
systemd = Dir.exist?('/etc/systemd/system')

# <> Create the MQ service file
template "/etc/systemd/system/#{node['wmq']['service_name']}.service" do
  source 'mq.service.erb'
  cookbook 'wmq' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode 0644
  only_if { systemd == true }
end

# <> Create Upstart Service File
template "/etc/init/#{node['wmq']['service_name']}.conf" do
  source 'mq.service.upstart.erb'
  cookbook 'wmq' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode 0644
  only_if { systemd == true }
  only_if { Dir.exist?('/etc/init') }
end


# <> Create the MQ service script

template "#{node['wmq']['os_users']['mqm']['home']}/mq-service.sh" do
  source 'mq-service.sh.erb'
  cookbook 'wmq' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode 0755
  variables(
    :queue_managers => node['wmq']['global_mq_service'] == 'false' ? node['wmq']['qmgr'].values.map { |qmgrs| qmgrs['name'] }.join(" ") : "*"
  )
  only_if { systemd == true } 
end

template "/etc/init.d/#{node['wmq']['service_name']}" do
  source 'mq-service-nosystemd.erb'
  cookbook 'wmq' # specified to avoid FC033 warning: https://github.com/acrmp/foodcritic/issues/449
  owner 'root'
  group 'root'
  mode 0755
  variables(
    :queue_managers => node['wmq']['global_mq_service'] == 'false' ? node['wmq']['qmgr'].values.map { |qmgrs| qmgrs['name'] }.join(" ") : "*",
    :service_name => node['wmq']['service_name']
  )
  only_if { systemd == false }
end

# <> Enable and start the httpd service
Chef::Log.info("Running the reload-daemon command on systemd enabled linux systems")
case node['platform_family']
when 'rhel', 'debian'
  execute 'daemon-reload' do
    command "/bin/systemctl daemon-reload"
    action :run
    user 'root'
    group 'root'
    only_if { systemd == true }
    only_if { File.exist?('/bin/systemctl') }
  end
end

# <> Enable and start the httpd service
execute 'mqseries-chkconfig' do
  command "chkconfig --add #{node['wmq']['service_name']}"
  action :run
  user 'root'
  group 'root'
  only_if { systemd == false }
end

# <> Enable the MQ service
service node['wmq']['service_name'] do
  action [:enable]
end

# <> Start the MQ service
service node['wmq']['service_name'] do
  action [:start]
end

