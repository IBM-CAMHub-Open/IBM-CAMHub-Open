#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Create server recipe (create_server.rb)
# <> Create a new liberty server
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - create_server
#----------------------------------------------------------------------------------------------------------------------------------------------

Chef::Log.info("-------------------------------------")
Chef::Log.info("Start executing recipe: create_server.rb")

# create liberty server
node['was_liberty']['liberty_servers'].each do |srv_index, v|
  server_name = v['name']
  next if srv_index['$INDEX'] && node['was_liberty']['skip_indexes'] == 'true'
  Chef::Log.info("start to create liberty server: #{server_name}")
  execute "create_server_#{server_name}" do
    command "#{node['was_liberty']['install_dir']}/bin/server create #{server_name}"
    user node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
    not_if { ::File.directory? "#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}" }
    action :run
  end
end
