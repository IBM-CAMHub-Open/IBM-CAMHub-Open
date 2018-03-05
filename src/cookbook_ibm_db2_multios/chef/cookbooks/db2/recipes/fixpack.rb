#
# Cookbook Name:: db2
# Recipe:: fixpack
#
# Copyright IBM Corp. 2017, 2017
#
# <> Fixpack recipe (fixpack.rb)
# <> This recipe performs product fixpack installation.

db2_fixpack "Install FP" do
  action :install
  not_if { db2_installed?(node['db2']['install_dir'], node['db2']['fp_version']) }
end
