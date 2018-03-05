#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Install  recipe (install.rb)
# <> Installation recipe, source the version, unpack the file and install product
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - install
#----------------------------------------------------------------------------------------------------------------------------------------------

# get the liberty and sdk aditions, plus the liberty feature list
liberty_edition = Helpers.liberty_edition(node)
_, sdk_offering_id, sdk_features = Helpers.sdk_edition(node)
feature_list = Helpers.liberty_features(node)

# Create targetPath directory
directory node['was_liberty']['install_dir'] do
  action :create
  recursive true
  owner node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
end

im_install "com.ibm.websphere.liberty.CORE" do
  action [:install_im, :install]
  repositories node['ibm']['im_repo']
  install_dir node['was_liberty']['install_dir']
  im_install_dir node['was_liberty']['im_install_dir']
  im_install_mode node['was_liberty']['install_mode']
  response_file "rds.WASLibertyCorev90.install.xml"
  offering_id node['was_liberty']['offering_id'][liberty_edition]
  offering_version node['was_liberty']['base_version']
  profile_id node['was_liberty']['profile_id'][liberty_edition]
  feature_list feature_list
  user node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
  install_java node['was_liberty']['install_java']
  java_offering_id sdk_offering_id # JAVA_OFFERING_ID
  java_offering_version node['was_liberty']['java_version'] #
  java_feature_list sdk_features # JAVA_FEATURES
  im_repo_user node['ibm']['im_repo_user']
  im_repo_nonsecureMode 'true'
  repo_nonsecureMode 'true'
  not_if { File.exist?("#{node['was_liberty']['install_dir']}/bin/server") }
end

# Create User Data Directory
directory node['was_liberty']['wlp_user_dir'] do
  action :create
  recursive true
  owner node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
end


java_home = "#{node['was_liberty']['install_dir']}/java/#{node['was_liberty']['java_version'][0..2]}"
# if File.directory?("#{node['was_liberty']['install_dir']}/java/#{node['was_liberty']['java_version'][0..2]}")
#   "#{node['was_liberty']['install_dir']}/java/#{node['was_liberty']['java_version'][0..2]}"
# else
#   "/" + IO.popen("which java").read.chomp.split("/")[1]
# end

directory "#{node['was_liberty']['install_dir']}/etc/" do
  user node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
end

template "#{node['was_liberty']['install_dir']}/etc/server.env" do
  source "server.env.erb"
  variables(
    :WLP_USER_DIR => node['was_liberty']['wlp_user_dir'],
    :JAVA_HOME => java_home
  )
  user node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
end
