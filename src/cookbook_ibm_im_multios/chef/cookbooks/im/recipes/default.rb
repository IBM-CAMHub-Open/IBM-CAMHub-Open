# Cookbook Name:: im
# Recipe:: default
#
# Copyright IBM Corp. 2016, 2017
#
# <> Default recipe (default.rb)
# <> The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.

# Installation of IM is included in im_install LWRP

# This will be used only for standalone installation for kitchen tests

case node['platform_family']
when 'rhel', 'debian'
  node['im']['os_users'].each_pair do |_k, u|
    next if u['ldap_user'] == 'true' || u['name'].nil?
    group u['gid'] do
      action :create
      not_if { u['gid'] == node['root_group'] }
    end
    user u['name'] do
      comment u['comment']
      home u['home']
      gid u['gid']
      shell u['shell']
      manage_home true
      action :create
      not_if { u['name'] == 'root' }
    end
  end
end

im_install "Standalone_IM" do
  repositories node['ibm']['im_repo']
  im_install_mode node['im']['install_mode']
  im_repo_user node['ibm']['im_repo_user']
  user node['im']['os_users']['im_user']['name']
  group node['im']['os_users']['im_user']['gid']
  im_repo_nonsecureMode "true"
  repo_nonsecureMode "true"
  action [:install_im, :upgrade_im]
end
