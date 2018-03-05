########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################

actions :push, :pull
default_action :push

attribute :remote_host, :kind_of => String
attribute :login, :kind_of => String
attribute :password, :kind_of => String, :default => nil
attribute :source, :kind_of => String
attribute :destination, :kind_of => String
attribute :priv_ssh_key, :kind_of => String, :default => nil
