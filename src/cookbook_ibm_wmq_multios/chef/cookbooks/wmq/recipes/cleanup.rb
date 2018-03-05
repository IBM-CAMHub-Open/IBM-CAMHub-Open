
# Cookbook Name:: wmq
# Recipe:: cleanup
#
# Copyright IBM Corp. 2016, 2017
#
# <> Cleanup recipe (cleanup.rb)
# <> Perform post-install cleanup

directory 'deleting_expand_area' do
  path node['wmq']['expand_area']
  recursive true
  action :delete
end

