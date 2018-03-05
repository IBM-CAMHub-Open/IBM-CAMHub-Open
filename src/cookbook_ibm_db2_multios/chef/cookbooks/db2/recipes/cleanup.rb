#
# Cookbook Name:: db2
# Recipe:: cleanup
#
# Copyright IBM Corp. 2017, 2017
#
# <> Cleanup recipe (cleanup.rb)
# <> This recipe will remove any temporary installation files created as part of the automation.

cookbook_expandarea = node['db2']['expand_area']

directory "Deleting db2 expand area" do
  path cookbook_expandarea
  recursive true
  action :delete
end
