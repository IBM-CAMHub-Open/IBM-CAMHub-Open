# Cookbook Name::was
# Recipe::configure_standalone
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Configure Websphere standalone server JVM min and max HeapSize.
#

# Create directories incase cleanup recipe as been executed before
[node['was']['expand_area'], node['ibm']['temp_dir'], node['ibm']['log_dir']].each do |dir|
    directory dir do
      recursive true
      action :create
      mode '0755'
    end
end
#create wsadmin libraries
create_wsadmin_library(node['ibm']['temp_dir'])

adminuserpwd = node['was']['security']['admin_user_pwd']
chef_vault = node['was']['vault']['name']
unless chef_vault.empty?
  encrypted_id = node['was']['vault']['encrypted_id']
  require 'chef-vault'
  adminuserpwd = chef_vault_item(chef_vault, encrypted_id)['was']['security']['admin_user_pwd']
end

nodename = was_tags(node['was']['wsadmin']['standalone']['jvmproperty']['node_name'])
servername = node['was']['wsadmin']['standalone']['jvmproperty']['server_name']
propertyvalueinitial = node['was']['wsadmin']['standalone']['jvmproperty']['property_value_initial']
propertyvaluemaximum = node['was']['wsadmin']['standalone']['jvmproperty']['property_value_maximum']

#create jython template to set initial/maximum heap size
{ "initialHeapSize" => propertyvalueinitial, "maximumHeapSize" => propertyvaluemaximum }.each_pair do |propertyname, propertyvalue|
  template "#{node['ibm']['temp_dir']}/#{propertyname}_jvmproperty_set.jython" do
    cookbook 'was'
    source "jvmproperty_set.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :PROPNAME => propertyname,
              :PROPVALUE => propertyvalue,
              :NODENAME => nodename,
              :SERVERNAME => servername)
    action :create
  end
  template "#{node['ibm']['temp_dir']}/#{propertyname}_jvmproperty_get.jython" do
    cookbook 'was'
    source "jvmproperty_get.jython.erb"
    mode "755"
    variables(:TMP => node['ibm']['temp_dir'],
              :PROPNAME => propertyname,
              :NODENAME => nodename,
              :SERVERNAME => servername)
    action :create
  end
end

was_setheapsize "Set_heap_size" do
  profile_type "standalone"
  profile_path node['was']['wsadmin']['standalone']['jvmproperty']['profile_path']
  admin_user node['was']['security']['admin_user']
  admin_pwd adminuserpwd
  os_user node['was']['os_users']['was']['name']
  property_value_initial propertyvalueinitial
  property_value_maximum propertyvaluemaximum
  node_name nodename
  server_name servername
  action [:set_initial_heap_size, :set_maximum_heap_size]
end
