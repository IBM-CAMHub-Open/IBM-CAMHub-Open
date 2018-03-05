# Cookbook Name::was
# Recipe::install
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Installs WebSphere Application Server V8.5.5 or V9
#

case node['was']['install_mode']
when 'admin'
  was_user = 'root'
  was_group = 'root'
else
  was_user = node['was']['os_users']['was']['name']
  was_group = node['was']['os_users']['was']['gid']
end

edition = ''
node['was']['edition'].each_pair do |e, do_install|
  if do_install == 'true'
    edition = e
  end
end

feature_list = ''
node['was']['features'].each_pair do |feature, do_install|
  if do_install == 'true'
    feature_list = feature_list + feature + ','
  end
end

if feature_list == ''
  Chef::Application.fatal!('No features selected.', 1)
end
feature_list = feature_list.chomp(',')

java_editions = node['was']['java_features'].select { |_, props| props['enable'] == 'true' }
Chef::Log.info("JAVA editions Id: #{java_editions}")
raise "Please select either common IBM Java SDKs or IBM Websphere Java SDKs, but only one version can be set to true ." if java_editions.length > 1
install_java_flag = "false"
if !java_editions.empty?
  install_java_flag = "true"
  java_name = java_editions.keys.first # in prereq, we made sure there is only one key
  Chef::Log.info("JAVA name Id: #{java_name}")
  java_offering_id = java_editions[java_name]['offering_id']
  Chef::Log.info("JAVA offering Id: #{java_offering_id}")
else
  Chef::Log.info("Default Java Version to be installed.")
end
# Manage base directory
subdirs = subdirs_to_create(node['was']['install_dir'], node['was']['os_users']['was']['name'])
subdirs.each do |dir|
  directory dir do
    action :create
    recursive true
    owner was_user
    group was_group
  end
end

Chef::Resource::User.send(:include, IM::Helper)
Chef::Log.info("version-edition: #{edition}")
puts node['was']['offering_id']

boffering=node['was']['offering_id']
Chef::Log.info("boffering: #{boffering}")

offering_version = was_offering_version
offering_java_version = was_java_offering_version
offering_id = node['was']['offering_id'][edition]
profile_id = node['was']['profile_id'][edition]
Chef::Log.info("offering verion: #{offering_version}")
Chef::Log.info("install_path: #{node['was']['install_dir']}")
Chef::Log.info("im_repo: #{node['ibm']['im_repo']}")
Chef::Log.info("offering Id: #{offering_id}")
Chef::Log.info("profile Id: #{profile_id}")
Chef::Log.info("JAVA name Id: #{java_name}")
Chef::Log.info("JAVA offering Id: #{java_offering_id}")
Chef::Log.info("JAVA version Id: #{offering_java_version}")
Chef::Log.info("JAVA flag Id: #{install_java_flag}")

im_install 'ibm_websphere_server' do
  repositories node['ibm']['im_repo']
  install_dir node['was']['install_dir']
  response_file node['was']['im_install_template']
  offering_id offering_id
  offering_version was_offering_version
  profile_id profile_id
  feature_list feature_list
  im_install_mode node['was']['install_mode']
  install_java install_java_flag
  java_offering_id java_offering_id
  java_offering_version was_java_offering_version
  user was_user
  group was_group
  im_repo_user node['ibm']['im_repo_user']
  im_repo_nonsecureMode 'true'
  repo_nonsecureMode 'true'
  action [:install_im, :upgrade_im, :install]
end

was_managesdk "set_default_sdk" do
  action [:setCommandDefault, :setNewProfileDefault]
  only_if { java_editions.length == 1 }
end
