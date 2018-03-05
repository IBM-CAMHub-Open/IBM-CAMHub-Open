# Cookbook Name:: ihs
# Recipe:: cleanup
#
# Copyright IBM Corp. 2016, 2017
#

# <> Cleanup recipe (cleanup.rb)
# <> Perform post-install cleanup

directory 'deleting_expand_area' do
  path node['ihs']['expand_area']
  recursive true
  action :delete
end
