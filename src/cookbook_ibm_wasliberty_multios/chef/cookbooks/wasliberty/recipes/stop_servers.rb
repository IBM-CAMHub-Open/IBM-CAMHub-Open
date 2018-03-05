#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Stop serverss recipe (stop_servers.rb)
# <> Stop servers recipe, stop liberty servers
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - stop_servers
#----------------------------------------------------------------------------------------------------------------------------------------------

# liberty_servers = node['was_liberty']['liberty_servers'].values.map { |elem| elem['name'] }
liberty_servers = if !node['was_liberty']['stop_servers'].empty?
                    node['was_liberty']['stop_servers'].split(/[\s,]+/).reject(&:empty?)
                  else
                    Dir.entries("#{node['was_liberty']['wlp_user_dir']}/servers/").reject { |f| f.start_with?(".") }
                  end
# liberty_servers = if File.directory?(node['was_liberty']['install_dir'])
#                     Dir.entries("#{node['was_liberty']['wlp_user_dir']}/servers/").reject { |f| f.start_with?(".") }
#                   else
#                     []
#                   end

log "Shutting down servers: #{liberty_servers}" do
  level :info
end

liberty_servers.each do |server_name|
  wasliberty_wl_server server_name do
    action :stop
    user node['was_liberty']['install_user']
    timeout '30'
    install_dir node['was_liberty']['install_dir']
  end
end
