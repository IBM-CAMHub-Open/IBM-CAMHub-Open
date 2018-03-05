#
# Cookbook Name:: tomcat
# Resource:: java.rb
#
# Copyright IBM Corp. 2017, 2017
#
actions :upgrade
default_action :upgrade

# <> Java version to install. Should match platform-specific version, e.g. 1.8.0 for openjdk
attribute :version, :kind_of => String, :default => nil

# <> Vendor, aka IBM, Oracle, 'platform' openjdk (e.g. rpm in RHEL yum repo)
attribute :vendor, :kind_of => String, :default => 'openjdk'

# <> SDK if 'true', JRE if 'false'
attribute :sdk, :kind_of => String, :default => 'false'

# <> Archive URI; not for openjdk
attribute :archive_url, :kind_of => String, :default => nil

# <> Installation directory (will be JAVA_HOME); not for openjdk
attribute :install_dir, :kind_of => String, :default => nil
