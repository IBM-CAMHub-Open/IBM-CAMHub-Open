#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Start server recipe (start_server.rb)
# <> Start server recipe, start liberty servers
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - start_server
#----------------------------------------------------------------------------------------------------------------------------------------------

start_servers = if !node['was_liberty']['start_servers'].empty?
                  node['was_liberty']['start_servers'].split(/[\s,]+/).reject(&:empty?)
                else
                  Dir.entries("#{node['was_liberty']['wlp_user_dir']}/servers/").reject { |f| f.start_with?(".") }
                end

log "start_servers" do
  message "****** Starting servers: #{start_servers} ******"
  level :info
end

# start liberty servers
node['was_liberty']['liberty_servers'].each do |srv_index, v|

  server_name = v['name']
  next unless start_servers.include?(server_name)

  log "start_server" do
    message "Server start: <#{server_name}>"
    level :info
  end

  jvm_opts_file = "#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/jvm.options"
  jvm_params = node['was_liberty']['liberty_servers'][srv_index]['jvm_params']

  template jvm_opts_file do
    source 'jvm.options.erb'
    variables(
      :jvm_options => jvm_params.split
    )
    user node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
  end

  wasliberty_wl_server server_name do
    action :start
    user node['was_liberty']['install_user']
    timeout node['was_liberty']['liberty_servers'][srv_index]['timeout']
    install_dir node['was_liberty']['install_dir']
    force_restart node['was_liberty']['force_restart']
    jvm_options jvm_params
  end
end
