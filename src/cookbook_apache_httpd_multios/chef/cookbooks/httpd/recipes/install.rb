# Cookbook Name:: httpd
# Recipe:: install
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install.rb)
# <> Perform an installation of selected httpd package on the target node.

node['httpd']['server_packages'].each do |p|
  package p do
    action :install
  end
end

package 'mod_ssl' do
  action :install
  only_if { node['httpd']['ssl']['install_mod_ssl'] == 'true' }
  only_if { node['platform_family'] == 'rhel' }
end

execute 'enable mod_ssl' do
  command 'a2enmod ssl'
  only_if { node['httpd']['ssl']['install_mod_ssl'] == 'true' }
  only_if { node['platform_family'] == 'debian' }
end 

execute 'enable default ssl site' do
  command 'a2ensite default-ssl'
  only_if { node['httpd']['ssl']['install_mod_ssl'] == 'true' }
  only_if { node['platform_family'] == 'debian' }
end 

node['httpd']['php_packages'].each do |pk|
  package pk do
    action :install
    only_if { node['httpd']['php_mod_enabled'] == 'true' }
  end
end
