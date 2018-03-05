# Cookbook Name:: oracle_mysql
# Recipe:: service
#
# Copyright IBM Corp. 2016, 2017
#
# <> Service control recipe (service.rb)

# <> Enable and start the MySQL service
service 'mysql service resource' do
  service_name node['mysql']['service_name']
  case node['platform']
  when 'redhat'
    action [:start, :enable]
  when 'ubuntu'
    action [:start]
  end
end
