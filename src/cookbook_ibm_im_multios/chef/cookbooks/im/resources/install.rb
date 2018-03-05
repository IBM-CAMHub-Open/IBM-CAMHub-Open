#
# Cookbook Name:: im
# Provider:: im_install
#
# Copyright IBM Corp. 2016, 2017
#
actions :install, :install_im, :upgrade_im
default_action :install

# <> The repository to search. Multiple repositories can be specified with a comma-separated list.
attribute :repositories, :kind_of => String, :default => node['ibm']['im_repo']

# <> User used to access IM repo if this repo is secured and authentication is required This is not required if IM repo is not secured.
attribute :im_repo_user, :kind_of => String, :default => nil

# <> If the IM repo is public this should be set to "false"
attribute :secure_repo, :kind_of => String, :default => 'true'

# <> If the IM repo is secured but it uses a self signed SSL certificate this should be set to "true"
attribute :im_repo_nonsecureMode, :kind_of => String, :default => 'false'

# <> If the Software repo is secured but it uses a self signed SSL certificate this should be set to "true"
attribute :repo_nonsecureMode, :kind_of => String, :default => 'false'

# <> The response file for the IBM Installation Manager.
attribute :response_file, :kind_of => String, :default => nil

# <> Installation directory for the product that is installed using this LWRP
attribute :install_dir, :kind_of => String, :default => nil

# possible values:
# offering_id                                            profile_id
# com.ibm.websphere.IHS.v85     ->         IBM HTTP Server for WebSphere Application Server V8.5
# com.ibm.websphere.PLG.v85     ->         Web Server Plug-ins for IBM WebSphere Application Server V8.5
# com.ibm.websphere.ND.v85      ->         IBM WebSphere Application Server V8.5
# <> Offering ID. You can find the value in your IMRepo. Each Product has a different ID
attribute :offering_id, :kind_of => String, :default => nil

# <> Java offering ID. You can find the value in your IMRepo. Each Product has a different ID
attribute :java_offering_id, :kind_of => String, :default => nil

# <> Offering version. You can find the value in your IMRepo. Each Product has a different offering version
attribute :offering_version, :kind_of => String, :default => nil

# <> Java offering version. You can find the value in your IMRepo. Each Product has a different offering version
attribute :java_offering_version, :kind_of => String, :default => nil

# <> Profile ID. This is a description of the product
attribute :profile_id, :kind_of => String, :default => nil

# <> Feature list for the product. This is a list of components that should be installed for a specific product
attribute :feature_list, :kind_of => String, :default => nil

# <> Java feature list for the product. This is a list of components that should be installed for a specific product
attribute :java_feature_list, :kind_of => String, :default => nil

# <> Flag for Java Installation. Supports "true" or "false"
attribute :install_java, :kind_of => String, :default => "false"

# <> Directory where installation artifacts are stored.
attribute :im_shared_dir, :kind_of => String, :default => nil

# <> User used to install IM and that should be used to install a product
attribute :user, :kind_of => String, required: true, :default => nil

# <> Group used to install IM and that should be used to install a product
attribute :group, :kind_of => String, required: true, :default => nil

# <> Installation mode used to install IM and that should be used to install a product
attribute :im_install_mode, :kind_of => String, :default => 'admin'

# <> Directory where im was installed
attribute :im_install_dir, :kind_of => String, :default => nil

# <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
attribute :log_dir, :kind_of => String, :default => node['ibm']['evidence_path']

# <> Installation Manager Version Number to be installed. Supported versions: 1.8.5, 1.8.6
attribute :version, :kind_of => String, :default => node['im']['version']

# <> Installation Manager Data Directory
attribute :im_data_dir, :kind_of => String, :default => nil


attr_accessor :im_installed
attr_accessor :fp_installed
attr_accessor :installed
