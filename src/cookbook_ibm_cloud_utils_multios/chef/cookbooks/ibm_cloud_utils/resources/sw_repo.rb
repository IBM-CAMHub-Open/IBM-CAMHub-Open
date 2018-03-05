########################################################
#	  Copyright IBM Corp. 2017, 2017
########################################################
#

actions :check_package
default_action :check_package

# <> URL for software repository
attribute :repository, :kind_of => String, :default => node['ibm']['sw_repo']

# <> If the software repo is secured but it uses a self signed SSL certificate this should be set to "true"
attribute :sw_repo_self_signed_cert, :kind_of => String, :default => node['ibm']['sw_repo_self_signed_cert']

# <> User used to access software repo if this repo is secured and authentication is required This is not required if software repo is not secured.
attribute :sw_repo_user, :kind_of => String, :default => node['ibm']['sw_repo_user']

# <> If the software repo is public this should be set to "false"
attribute :secure_repo, :kind_of => String, :default => 'true'

# <> The repository path where the package should be located
attribute :sw_repo_path, :kind_of => String, :default => '/'

# <> The name of the package
attribute :package, :kind_of => String, :name_attribute => true, :required => true
