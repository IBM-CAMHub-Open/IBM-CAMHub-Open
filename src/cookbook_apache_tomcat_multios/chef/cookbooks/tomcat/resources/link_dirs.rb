#
# Cookbook Name:: tomcat
# Resource:: link_dirs.rb
#
# Copyright IBM Corp. 2017, 2017
#

actions :link
default_action :link

# <> Destination directory
attribute :dest_dir, :kind_of => String, :default => nil

# <> Source directory
attribute :source_dir, :kind_of => String, :default => nil

# <> Owner
attribute :owner, :kind_of => String, :default => nil

# <> Group of owner
attribute :group, :kind_of => String, :default => nil

# <> Mode of created directory
attribute :mode, :kind_of => String, :default => '0750'
