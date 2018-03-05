################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Cleanup recipe (cleanup.rb)
# <> Perform post-install cleanup

directory 'deleting expand_area' do
  path node['tomcat']['expand_area']
  recursive true
  action :delete
end
