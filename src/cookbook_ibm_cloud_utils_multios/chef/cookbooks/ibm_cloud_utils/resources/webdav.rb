########################################################
#	  Copyright IBM Corp. 2017, 2017
########################################################
#

actions :upload, :download, :delete, :create_collection, :delete_collection
default_action :upload

# <> URL for WebDAV server
attribute :webdav_server, :kind_of => String, :default => node['ibm']['sw_repo'] + '/sharedStorage'

# <> If the WebDAV server is secured but it uses a self signed SSL certificate this should be set to "true"
attribute :sw_repo_self_signed_cert, :kind_of => String, :default => node['ibm']['sw_repo_self_signed_cert']

# <> User used to access WebDAV server if this server is secured and authentication is required. This is not required if WebDAV server is not secured.
attribute :sw_repo_user, :kind_of => String, :default => node['ibm']['sw_repo_user']

# <> If the WebDAV server is public this should be set to "false"
attribute :secure_repo, :kind_of => String, :default => 'true'

# <> The name of the file that will be uploaded/deleted to/from WebDAV server
attribute :file, :kind_of => String, :name_attribute => true, :required => true

# <> This is the local path where the file will be downloaded from WebDAV server
attribute :download_path, :kind_of => String, :default => nil

# <> This is the local path of the file that will be uploaded to WebDAV server
attribute :source_path, :kind_of => String, :default => nil

# <> Collection that will be used to store the files on the WebDAV server
attribute :collection, :kind_of => String, :required => true
