#
# Cookbook Name:: tomcat
# Resource:: install.rb
#
# Copyright IBM Corp. 2017, 2017
#
actions :install # ,:upgrade
default_action :install

# <> Tomcat archive full download path
attribute :package_path, :kind_of => String, :default => nil

# <> Tomcat version
attribute :version, :kind_of => String, :default => nil

# <> CATALINA_HOME
attribute :catalina_home, :kind_of => String, :default => nil

# <> CATALINA_BASE (location of default instance)
attribute :catalina_base, :kind_of => String, :default => nil

# <> User directories hash
# attribute :instance_dirs, :kind_of => Hash, :default => node['tomcat']['instance_dirs']

# <> Daemon user
attribute :owner, :kind_of => String, :default => 'tomcat'

# <> Daemon group
attribute :group, :kind_of => String, :default => 'tomcat'

# <> Service name
attribute :tomcat_service, :kind_of => String, :default => 'tomcat'

# <> Temp dir for unpacking files
attribute :expand_area, :kind_of => String, :default => node['tomcat']['expand_area']

# <> Vault name containing repository credentials
attribute :vault_name, :kind_of => String, :default => nil

# <> Vault encrypted item
attribute :vault_item, :kind_of => String, :default => nil

# <> Repo has self-signed certificate?
attribute :repo_self_signed_cert, :kind_of => String, :default => nil
