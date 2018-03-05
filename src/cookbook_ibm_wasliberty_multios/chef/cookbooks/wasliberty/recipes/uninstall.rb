########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# recipe to remove the expand_area / tmp folders from a provisioned machine
# <> Uninstall recipe (uninstall.rb)
# <> Uninstalls liberty core and removes the folders, where the binaries were extracted
#

liberty_edition = Helpers.liberty_edition(node)
_, sdk_offering_id, = Helpers.sdk_edition(node)

liberty_servers = if File.directory?(node['was_liberty']['install_dir'])
                    Dir.entries("#{node['was_liberty']['wlp_user_dir']}/servers/").reject { |f| f.start_with?(".") }
                  else
                    []
                  end

liberty_servers.each do |server_name|
  wasliberty_wl_server server_name do
    action :stop
    user node['was_liberty']['install_user']
    timeout '20'
    install_dir node['was_liberty']['install_dir']
  end
end

execute 'uninstall_java_sdk' do
  command "su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl uninstall #{sdk_offering_id}'"
  only_if { IO.popen("su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl listInstalledPackages'").read.include? sdk_offering_id }
end

liberty_offering_id = node['was_liberty']['offering_id'][liberty_edition]

execute 'uninstall_liberty' do
  command "su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl uninstall #{liberty_offering_id}'"
  only_if { IO.popen("su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl listInstalledPackages'").read.include? liberty_offering_id }
end

execute 'uninstall_IM' do
  command "su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl uninstall com.ibm.cic.agent'"
  only_if do
    File.exist?("#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl") &&
      IO.popen("su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl listInstalledPackages'").readlines.size == 1 &&
      IO.popen("su - #{node['was_liberty']['install_user']} -c '#{node['was_liberty']['im_install_dir']}/eclipse/tools/imcl listInstalledPackages'").read.include?('com.ibm.cic.agent')
  end
end

directory node['was_liberty']['install_dir'] do
  recursive true
  action :delete
end

# cleanup the temporary download directory
include_recipe "#{cookbook_name}::cleanup"
