# Cookbook Name::was
# Recipe::start_clustermember
#
#         Copyright IBM Corp. 2016, 2017
#
# <> Start the Websphere cluster members/application servers
#


node['was']['wsadmin']['clusters'].each_pair do |_k, u|
  u['cluster_servers'].each_pair do |_j, i|
    # create the service init script
    create_server_init((node['was']['profiles']['node_profile']['profile']).to_s, i['server_name'], i['server_name'])
    #start the application server
    start_server(i['server_name'])
  end
end
