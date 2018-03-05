# Cookbook Name:: httpd
# Recipe:: cleanup
#
# Copyright IBM Corp. 2016, 2017
#
# <> Cleanup recipe (cleanup.rb)
# <> Perform post-install cleanup


log "Cleanup #{node['ibm']['expand_area']}"
directory 'Cleaning up' do
  path node['ibm']['expand_area']
  recursive true
  action :delete
end
