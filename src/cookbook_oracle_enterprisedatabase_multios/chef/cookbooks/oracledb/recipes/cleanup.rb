########################################################
#
# Cookbook Name:: oracledb
# Recipe:: cleanup
#
# Copyright IBM Corp. 2017, 2017
#
########################################################

# <> Cleanup recipe (cleanup.rb)
# <> This recipe will remove any temporary installation files created as part of the automation.

oracle_setup_base = node['oracledb']['expand_area'].gsub('--cookbook_name--', cookbook_name)
directory oracle_setup_base do
  recursive true
  action :delete
end
