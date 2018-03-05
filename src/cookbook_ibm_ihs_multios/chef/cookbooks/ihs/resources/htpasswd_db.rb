#
# Cookbook Name:: ihs
# Provider:: htpasswd_db.rb
#
# Copyright IBM Corp. 2016, 2017
#
actions :create
default_action :create

# <> Full path to the htpasswd program
attribute :htpasswd_path, :kind_of => String, :default => nil

# <> Full path and filename of the password database
attribute :htpasswd_db, :kind_of => String, :default => nil

# <> Owner of the db; has to pre-exist
attribute :owner, :kind_of => String, :default => node['ihs']['os_users']['ihs']['name']

# <> Group of the above; has to pre-exist
attribute :group, :kind_of => String, :default => node['ihs']['os_users']['ihs']['gid']

# <> User to add to db
attribute :user, :kind_of => String, :default => nil

# <> Passsword of the above
attribute :password, :kind_of => String, :default => ''

# <> openssl binary; default to the one embedded
attribute :openssl_exec, :kind_of => String, :default => node['chef_packages']['chef']['chef_root'].gsub(/embedded\/.*$/, 'embedded/bin/openssl')
