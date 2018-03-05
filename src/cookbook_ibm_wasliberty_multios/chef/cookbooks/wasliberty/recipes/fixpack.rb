#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Fixpack  recipe (fixpack.rb)
# <> Fixpack recipe, source the version, unpack the file and apply maintenance to the  product
#
#########################################################################

# Cookbook Name  - wasv90
# Recipe         - fixpack
#----------------------------------------------------------------------------------------------------------------------------------------------
#set the os user to install Installation Manager according to install mode
if File.exist? node['was_liberty']['install_dir']
  crt_version = IO.popen("/opt/IBM/WebSphere/Liberty/bin/productInfo version").readlines.grep(/version/).first.chomp.split(/\s*:\s*/)[1]
  if crt_version >= node['was_liberty']['fixpack']
    Chef::Log.info "Current Liberty version #{crt_version} is greater then or the same as fixpack no #{node['was_liberty']['fixpack']}"
    return
  end
end

Chef::Log.info("fixpack: #{node['was_liberty']['fixpack']}")

liberty_edition = Helpers.liberty_edition(node)
_, sdk_offering_id, sdk_features = Helpers.sdk_edition(node)
feature_list = Helpers.liberty_features(node)

# fetch and unpack fixpack binaries
node['was_liberty']['fixpack_names'].each_pair do |_p, v|
  filename = v['filename']
  sha256 = v['sha256']
  Chef::Log.info("Unpacking #{filename}...")

  ibm_cloud_utils_unpack "unpack-#{filename}" do
      source "#{node['ibm']['sw_repo']}/was/v90/maint/#{filename}"
      target_dir "#{node['was_liberty']['expand_area']}/was-v90/was-liberty-fp"
      mode '0755'
      checksum sha256
      remove_local node['was_liberty']['cleanpackages']
      not_if { ::File.directory?("#{node['was_liberty']['expand_area']}/was-v90/was-liberty-fp/native") }
  end
end

# fetch and unpack java7 fixpack if enabled
if node['was_liberty']['install_javafp'] == "true"
  node['was_liberty']['fixpack_names']['java8'].each_pair do |_p, v|
    filename = v['filename']
    sha256 = v['sha256']
    Chef::Log.info("Unpacking #{filename}...")

    ibm_cloud_utils_unpack "unpack-#{filename}" do
        source "#{node['ibm']['sw_repo']}/was/v90/maint/#{filename}"
        target_dir "#{node['was_liberty']['expand_area']}/was-v90/java8-fp"
        mode '0755'
        checksum sha256
        remove_local node['was_liberty']['cleanpackages']
        not_if { ::File.directory?("#{node['was_liberty']['expand_area']}/was-v90/java8-fp/native") }
    end
  end
end

# Prepare the silent install response file
silent_install_file="#{node['was_liberty']['expand_area']}/was-v90/was-liberty-fp/rds.WASLibertyCorev90.fp.xml"
template silent_install_file do
  source "rds.WASLibertyCorev90.fp.xml.erb"
  mode '0750'
  variables(
    :WAS_REPO_LOCATION => "#{node['was_liberty']['expand_area']}/was-v90/was-liberty-fp",
    :JAVA_REPO_LOCATION => "#{node['was_liberty']['expand_area']}/was-v90/java8-fp",
    :IMSHARED => node['was_liberty']['im_shared_dir'],
    :FEATURE_LIST =>  feature_list,
    :OFFERING_ID =>  node['was_liberty']['offering_id'][liberty_edition],
    :PROFILE_ID =>  node['was_liberty']['profile_id'][liberty_edition],
    :INSTALL_LOCATION => node['was_liberty']['install_dir'],
    :SDK_OFFERING_ID => sdk_offering_id,
    :SDK_FEATURES => sdk_features
  )
end

execute "installWASFP" do
  command "#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl -acceptLicense input #{silent_install_file} -log #{node['was_liberty']['tmp']}/rds.WASLibertyCorev90.#{liberty_edition}.fp.log"
  user node['was_liberty']['install_user']
  action :run
end
