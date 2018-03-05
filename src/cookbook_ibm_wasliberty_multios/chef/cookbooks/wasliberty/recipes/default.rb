#
# Cookbook Name:: wasliberty
# Recipe:: default
#
#	  Copyright IBM Corp. 2016, 2017


include_recipe "#{cookbook_name}::prereq"
include_recipe "#{cookbook_name}::install"
