#
# Cookbook Name:: oracle_mysql
# Recipe:: cleanup
#
# Copyright IBM Corp. 2016, 2017
#
# <> Cleanup recipe (cleanup.rb)
# <> This recipe will remove any temporary installation files created as part of the automation.


Chef::Log.info("Cleanup #{node['ibm']['expand_area']} \n")
directory node['ibm']['expand_area'] do
  recursive true
  action :delete
end
