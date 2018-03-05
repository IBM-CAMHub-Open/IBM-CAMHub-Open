#
# Cookbook Name:: tomcat
# Recipe:: configure_tomcat_users
#
# Copyright IBM Corp. 2017, 2017

require 'chef-vault'
::Chef::Recipe.send(:include, TomcatUsers)

passwords = chef_vault_item(node['tomcat']['vault']['name'], node['tomcat']['vault']['encrypted_id'])['tomcat']['ui_control']
acl = TomcatACL.new(node['tomcat']['ui_control'].to_hash, passwords)

template "#{node['tomcat']['instance_dirs']['conf_dir']}/tomcat-users.xml" do
  source 'tomcat-users.xml.erb'
  variables(
    :xml_data => acl.to_xml
  )
  not_if { acl.empty? }
end
