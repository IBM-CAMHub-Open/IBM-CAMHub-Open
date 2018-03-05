################################################################################
#
# Cookbook Name:: oracledb
# Recipe:: config_asm
#
# Copyright IBM Corp. 2016, 2017
#
################################################################################
#
# <> Installation recipe (config_asm.rb)
# <> This recipe preforms the post installation operation of ASM

################################################################################


# POST INSTALLATION SCRIPTS - NO GUARD ARE NEEDED THE SCRIPT
# ONLY MODIFY SOME PERMISSIONS AND LAST 2 SECONDS TO RUN EACH

orahome = node['oracledb']['ora_grid_home']

execute 'Execute Grid Install post installation script 1' do
  action :run
  command orahome + '/root.sh'
end


# POST INSTALLATION SCRIPTS - Grid configuration with Standalone option

execute 'Execute Grid Configuration for Standalone' do
  command "#{orahome}/perl/bin/perl -I#{node['oracledb']['ora_grid_home']}/perl/lib -I#{orahome}/install #{orahome}/crs/install/roothas.pl"
  action :run
end
