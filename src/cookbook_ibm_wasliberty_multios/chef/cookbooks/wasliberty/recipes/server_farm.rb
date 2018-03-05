#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Start server recipe (server_farm.rb)
# <> Add the required configuration for the liberty server farm
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - server_farm
#----------------------------------------------------------------------------------------------------------------------------------------------

# ------- removed as per #1561 --------- #
# ---- generate the private key file ----- #
# create directory
# key_dir = File.dirname(node['ssh']['private_key']['path'])
#
# directory key_dir do
#   recursive true
#   action :create
# end
#
# #retrieve the key content from the vault
# key_content = node['ssh']['private_key']['content']
# chef_vault = node['was_liberty']['vault']['name']
# if key_content.empty? && !chef_vault.empty?
#   encrypted_id = node['was_liberty']['vault']['encrypted_id']
#   require 'chef-vault'
#   key_content = chef_vault_item(chef_vault, encrypted_id)['ssh']['private_key']['content']
# end
#
# # generate private key file
# file 'generate_SSH_private_key_file' do
#   path node['ssh']['private_key']['path']
#   content Base64.decode64(key_content)
#   mode '600'
# end
# ------- removed as per #1561 --------- #

is_central_node = node['was_liberty']['farm']['central_node'].empty? ? true : false

farm_servers = if node.attribute?('was_liberty/farm_servers') && !node['was_liberty']['farm_servers'].empty?
                 node['was_liberty']['farm_servers'].split(/[\s,]+/).reject(&:empty?)
               else
                 Dir.entries("#{node['was_liberty']['wlp_user_dir']}/servers/").reject { |f| f.start_with?(".") }
               end

farm_servers.each do |server_name|
  # ------- removed as per #1561 --------- #
  # server_config_file = "#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/server.xml"

  # wasliberty_xml_file 'add_localConnector-1.0_feature' do
  #   source server_config_file
  #   search_path '/server/featureManager/feature'
  #   content 'localConnector-1.0'
  #   # notifies :start, "wasliberty_wl_server[#{server_name}]", :immediately
  # end
  #
  # wasliberty_xml_file 'add_pluginConfiguration' do
  #   source server_config_file
  #   search_path '/server/pluginConfiguration'
  #   node_attrs(
  #                'webserverPort' => node['was_liberty']['farm']['webserverPort'],
  #                'webserverSecurePort' => node['was_liberty']['farm']['webserverSecurePort'],
  #                'logFileName' => node['was_liberty']['farm']['logFileName'],
  #                'pluginInstallRoot' => node['was_liberty']['farm']['pluginInstallRoot'],
  #                'webserverName' => node['was_liberty']['farm']['webserverName'],
  #                'sslKeyringLocation' => node['was_liberty']['farm']['sslKeyringLocation'],
  #                'sslStashfileLocation' => node['was_liberty']['farm']['sslStashfileLocation'],
  #                'sslCertlabel' => node['was_liberty']['farm']['sslCertlabel']
  #   )
  #   # notifies :start, "wasliberty_wl_server[#{server_name}]", :immediately
  # end
  # ------- removed as per #1561 --------- #

  template "#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/server.env" do
    source "server.env.erb"
    owner node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
    # notifies :start, "wasliberty_wl_server[#{server_name}]", :immediately
  end

  # ------------------------------
  # server farm plugin generation
  # ------------------------------

  # Start all servers on the node
  wasliberty_wl_server server_name do
    action :nothing
    user node['was_liberty']['install_user']
    install_dir node['was_liberty']['install_dir']
    force_restart true
    subscribes :start, "wasliberty_xml_file[add_localConnector-1.0_feature]", :immediately
    subscribes :start, "wasliberty_xml_file[add_pluginConfiguration]", :immediately
    subscribes :start, "template[#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/server.env]", :immediately
  end

  # Create targetPath directory
  directory node['was_liberty']['farm']['plugins_dir'] do
    action :create
    owner node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
  end

  # Make sure the server is started before generating the plugin
  wasliberty_wl_server server_name do
    action :start
    user node['was_liberty']['install_user']
    install_dir node['was_liberty']['install_dir']
    force_restart false
  end

  # .Generate plugin
  execute 'generate_plugin' do
    command "#{node['was_liberty']['install_dir']}/bin/pluginUtility generate --server=#{server_name} --targetPath=#{node['was_liberty']['farm']['plugins_dir']}/plugin-cfg_#{server_name}.xml"
    user node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
  end

  # ------- removed as per #1561 --------- #
  # push the plugin file to the designated node
  # ibm_cloud_utils_file_copy 'push_plugin_file' do
  #   action :push
  #   source "#{node['was_liberty']['farm']['plugins_dir']}/plugin-cfg_#{server_name}.xml"
  #   destination node['was_liberty']['farm']['plugins_dir']
  #   remote_host node['was_liberty']['farm']['central_node']
  #   login node['was_liberty']['farm']['plugin_cpy_user']
  #   priv_ssh_key node['ssh']['private_key']['path']
  #   not_if { is_central_node }
  # end
  # ------- removed as per #1561 --------- #

end

# ------------------------------------------------------------------- #
# The next steps are just for the central (designated) node
# This is where the plugins are merged and pushed to the http server
# ------------------------------------------------------------------- #

# Create targetPath directory
directory node['was_liberty']['farm']['mergedplugins_dir'] do
  action :create
  owner node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
  only_if { is_central_node && node['was_liberty']['farm']['webserverhost'] && !node['was_liberty']['farm']['webserverhost'].empty? }
end

# merge the plugins
execute 'merge_plugins' do
  command "#{node['was_liberty']['install_dir']}/bin/pluginUtility merge  --sourcepath=#{node['was_liberty']['farm']['plugins_dir']} --targetpath=#{node['was_liberty']['farm']['mergedplugins_dir']}"
  user node['was_liberty']['install_user']
  group node['was_liberty']['install_grp']
  only_if { is_central_node && node['was_liberty']['farm']['webserverhost'] && !node['was_liberty']['farm']['webserverhost'].empty? }
end

# ------- removed as per #1561 --------- #
# push the merged plugin to the http server
# ibm_cloud_utils_file_copy 'push_merged_plugin_file_to_http_server' do
#   action :push
#   remote_host node['was_liberty']['farm']['webserverhost']
#   source "#{node['was_liberty']['farm']['mergedplugins_dir']}/merged-plugin-cfg.xml"
#   destination node['was_liberty']['farm']['httpd_plugins_dir']
#   login node['was_liberty']['farm']['httpd_user']
#   priv_ssh_key node['ssh']['private_key']['path']
#   only_if { is_central_node && node['was_liberty']['farm']['webserverhost'] && !node['was_liberty']['farm']['webserverhost'].empty? }
# end
# ------- removed as per #1561 --------- #
