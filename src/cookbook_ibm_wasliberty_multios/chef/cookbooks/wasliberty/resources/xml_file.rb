########################################################
# Copyright IBM Corp. 2016, 2017
########################################################
#
# Cookbook Name:: wasliberty
###############################################################################
actions :add_element
default_action :add_element

attribute :source, :kind_of => String, :name_attribute => true
attribute :search_path, :kind_of => String, :required => true
attribute :content, :kind_of => String, :default => nil
attribute :node_attrs, :kind_of => Hash, :default => {}
