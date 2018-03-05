# Cookbook Name:: httpd
# Recipe:: service
#
# Copyright IBM Corp. 2016, 2017
#
# <> Service control recipe (service.rb)

# <> Enable and start the httpd service
service node['httpd']['service_name'] do
 action [:enable, :start]
end
