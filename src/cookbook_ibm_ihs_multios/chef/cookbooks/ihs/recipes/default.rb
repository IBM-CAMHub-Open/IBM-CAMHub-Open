# Cookbook Name:: ihs
# Recipe:: default
#
# Copyright IBM Corp. 2016, 2017
#

# <> Default recipe (default.rb)
# <> Perform minimal product installation

# include_recipe 'ihs::prereq_check'
include_recipe 'ihs::prereq'
include_recipe 'ihs::install'
include_recipe 'ihs::config_httpd_conf'
include_recipe 'ihs::config_admin_conf'
include_recipe 'ihs::config_ssl_selfsigned'
include_recipe 'ihs::config_wasplugin'
include_recipe 'ihs::service_httpd'
include_recipe 'ihs::service_admin'
include_recipe 'ihs::gather_evidence'
include_recipe 'ihs::cleanup'
