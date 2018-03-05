#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Pre-Requisite recipe (prereq.rb)
# <> Pre-Requisite recipe to install packages, create users and folders.
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - prereq
#----------------------------------------------------------------------------------------------------------------------------------------------

ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end

# set hard/soft ulimit for open files in /etc/security/limits.conf
template "/etc/security/limits.d/was-limits.conf" do
  source "was-limits.conf.erb"
  mode '0644'
  variables(
    :OSUSER => node['was_liberty']['os_users']['wasadmin']['name']
  )
end

Chef::Log.info("IM1x Install User: #{node['was_liberty']['install_user']}")
Chef::Log.info("IM1x Install Group: #{node['was_liberty']['install_grp']}")

# create OS users and groups
if node['was_liberty']['create_os_users'] == 'true'
  node['was_liberty']['os_users'].each_pair do |_k, u|
    next if u['name'].nil?
    next if u['gid'].nil?
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

["#{node['was_liberty']['expand_area']}/was-v90", node['was_liberty']['tmp']].each do |dir|
  directory dir do
    recursive true
    action :create
  end
end

# chef_gem 'chef-vault' do
#   action :install
#   compile_time true
# end
