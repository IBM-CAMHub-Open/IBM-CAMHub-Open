########################################################
#	  Copyright IBM Corp. 2017, 2017
########################################################
#

actions :check_package
default_action :check_package

# <> URL for IM repository
attribute :repository, :kind_of => String, :default => node['ibm']['im_repo']

# <> If the IM repo is secured but it uses a self signed SSL certificate this should be set to "true"
attribute :im_repo_self_signed_cert, :kind_of => String, :default => node['ibm']['im_repo_self_signed_cert']

# <> User used to access IM repo if this repo is secured and authentication is required This is not required if IM repo is not secured.
attribute :im_repo_user, :kind_of => String, :default => node['ibm']['im_repo_user']

# <> If the IM repo is public this should be set to "false"
attribute :secure_repo, :kind_of => String, :default => 'true'

# <> Offering ID. You can find the value in your IMRepo. Each Product has a different ID
attribute :offering_id, :kind_of => String, :name_attribute => true, :required => true

# <> Offering version. You can find the value in your IMRepo. Each Product has a different offering version
attribute :offering_version, :kind_of => String, :default => nil
