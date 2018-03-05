################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Default recipe (default.rb)
# <> Include recipes for a standard installation

include_recipe 'tomcat::prereq_check'
include_recipe 'tomcat::prereq'
include_recipe 'tomcat::install'
include_recipe 'tomcat::configure_tomcat_init'
include_recipe 'tomcat::configure_tomcat_users'
include_recipe 'tomcat::configure_tomcat_server'
include_recipe 'tomcat::service'
include_recipe 'tomcat::gather_evidence'
include_recipe 'tomcat::cleanup'
