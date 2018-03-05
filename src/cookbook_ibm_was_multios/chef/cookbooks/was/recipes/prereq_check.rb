# Cookbook Name::was
#  Recipe::prereq_check
#
#         Copyright IBM Corp. 2016, 2017
#
# <> This recipe will check the environment prior to installing software.
#

ibm_cloud_utils_supported_os_check 'check-supported-opeartingsystem-for-pattern' do
  supported_os_list node['was']['OS_supported']
  action :check
  error_message "WAS pattern only supports opearting systems #{node['was']['OS_supported']}"
end

if node['was']['features']['com.ibm.sdk.6_32bit'] == "true" && node['was']['features']['com.ibm.sdk.6_64bit'] == "true"
  raise 'Select either 32-bit SDK feature OR 64-bit SDK feature.'
end


feature_list=""
node['was']['features'].each_pair do |feature, do_install|
  if do_install == "true"
    feature_list = feature_list + feature + ","
  end
end

if feature_list == ""
  raise 'No features selected.'
end

unless feature_list.include?("core.feature") || feature_list.include?("liberty")
  raise 'Either core.feature or liberty must be selected.'
end

num_of_editions=0
node['was']['edition'].each_pair do |_e, do_install|
  if do_install == "true"
    num_of_editions+=1
  end
end

if num_of_editions != 1
  raise 'Only select one edition to be installed.'
end

# System must have valid fqdn, or install will silently fail
raise 'Please ensure hostname -f returns a valid FQDN' if node['fqdn'].nil?

# Check Free Space on install_dir
ibm_cloud_utils_freespace 'check-freespace-install-dir-directory' do
  path node['was']['install_dir']
  required_space 2000
  continue true
  action :check
  error_message "Please make sure you have at least 2000MB free space under #{node['was']['install_dir']}"
end

# Check Free Space on temp_dir
ibm_cloud_utils_freespace 'check-freespace-temp-dir-directory' do
  path node['ibm']['temp_dir']
  required_space 2000
  continue true
  action :check
  error_message "Please make sure you have at least 2000MB free space under #{node['ibm']['temp_dir']}"
end
