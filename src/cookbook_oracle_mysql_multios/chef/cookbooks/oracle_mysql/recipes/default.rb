#
# Cookbook Name:: oracle_mysql
# Recipe:: default
#
# Copyright IBM Corp. 2016, 2017
#
# <> Default recipe (default.rb)
# <> The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.

# Recipe's to run in this cookbook
# ----------------------------------------------------------------
include_recipe "#{cookbook_name}::prereq"
include_recipe "#{cookbook_name}::install"
include_recipe "#{cookbook_name}::fixpack"
include_recipe "#{cookbook_name}::service"
include_recipe "#{cookbook_name}::harden"
include_recipe "#{cookbook_name}::config_mysql"
include_recipe "#{cookbook_name}::gather_evidence"
#include_recipe "#{cookbook_name}::cleanup"
