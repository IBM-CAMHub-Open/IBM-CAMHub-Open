#
# Cookbook Name:: db2
# Provider:: db2_fixpack
#
# Copyright IBM Corp. 2017, 2017
#
actions :install
default_action :install

attribute :fixpack, :kind_of => String, :default => node['db2']['fixpack']
attribute :log_dir, :kind_of => String, :default => node['ibm']['log_dir']
attribute :db2_install_dir, :kind_of => String, :default => node['db2']['install_dir']
attribute :das_user, :kind_of => String, :default => node['db2']['das_username']
attribute :fp_dir, :kind_of => String, :default => node['db2']['fp_dir']
attribute :db2_base_version, :kind_of => String, :default => node['db2']['version']


attr_accessor :db2_fp_installed
