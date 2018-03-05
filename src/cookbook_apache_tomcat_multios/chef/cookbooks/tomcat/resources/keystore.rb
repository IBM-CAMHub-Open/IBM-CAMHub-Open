#
# Cookbook Name:: tomcat
# Resource:: keystore.rb
#
# Copyright IBM Corp. 2017, 2017
#
actions :create
default_action :create

# <> Java version to install. Should match platform-specific version, e.g. 1.8.0 for openjdk
attribute :java_home, :kind_of => String, :default => '/usr/java'

# <> Vendor, aka IBM, Oracle, 'platform' openjdk (e.g. rpm in RHEL yum repo)
attribute :java_vendor, :kind_of => String, :default => 'openjdk'

# <> Owner
attribute :owner, :kind_of => String, :default => nil

# <> Group of owner
attribute :group, :kind_of => String, :default => nil

# <> Keystore file name
attribute :keystore, :kind_of => String, :default => nil

# <> Keystore password
attribute :keystore_pass, :kind_of => String, :default => nil

# <> Keystore type
attribute :keystore_type, :kind_of => String, :default => 'JKS'

# <> Keystore algorithm
attribute :keystore_alg, :kind_of => String, :default => 'RSA'

# <> Self-signed certificate data
attribute :cert_data, :kind_of => Hash, :default => nil
