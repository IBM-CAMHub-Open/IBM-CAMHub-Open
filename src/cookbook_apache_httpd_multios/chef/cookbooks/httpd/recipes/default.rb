# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright IBM Corp. 2016, 2017
#
# <> Default recipe (default.rb)
# <> The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.

include_recipe "#{cookbook_name}::prereq"
include_recipe "#{cookbook_name}::install"
include_recipe "#{cookbook_name}::config_httpd_conf"
include_recipe "#{cookbook_name}::config_ssl"
include_recipe "#{cookbook_name}::config_vhosts"
include_recipe "#{cookbook_name}::service"
include_recipe "#{cookbook_name}::gather_evidence"
#include_recipe "#{cookbook_name}::cleanup"
