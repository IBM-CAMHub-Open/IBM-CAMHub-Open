# Cookbook Name::was
# Recipe::cleanup
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Cleanup Post WebSphere Install
#
cookbook_expandarea = node['was']['expand_area']

Chef::Log.info("Cleanup #{cookbook_expandarea} \n")
directory cookbook_expandarea do
  recursive true
  action :delete
end
