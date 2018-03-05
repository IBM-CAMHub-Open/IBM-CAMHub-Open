################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

# <> Configure tomcat server recipe (configure_tomcat_server.rb)
# <> Setup the main server configuration file

keystore_pass = chef_vault_item(node['tomcat']['vault']['name'], node['tomcat']['vault']['encrypted_id'])['tomcat']['ssl']['keystore']['password']

# Create keystore if SSL enabled
tomcat_keystore 'manage SSL keystore' do
  java_home node['tomcat']['java']['java_home']
  java_vendor node['tomcat']['java']['vendor']
  owner node['tomcat']['os_users']['daemon']['name']
  group node['tomcat']['os_users']['daemon']['gid']
  keystore node['tomcat']['ssl']['keystore']['file']
  keystore_pass keystore_pass
  keystore_type node['tomcat']['ssl']['keystore']['type']
  keystore_alg node['tomcat']['ssl']['keystore']['alg']
  cert_data node['tomcat']['ssl']['cert']
  only_if { node['tomcat']['ssl']['enabled'].casecmp('true').zero? }
end

# Create initial server.xml
template "#{node['tomcat']['instance_dirs']['conf_dir']}/server.xml" do
  source 'server.xml.erb'
  mode '0750'
  owner node['tomcat']['os_users']['daemon']['name']
  group node['tomcat']['os_users']['daemon']['gid']
  variables(
    :tomcat_version => node['tomcat']['version'],
    :shutdown_cmd => node['tomcat']['server']['shutdown_cmd'],
    :server_port => node['tomcat']['server']['port'],
    :http_port => node['tomcat']['http']['port'],
    :ajp_port => node['tomcat']['ajp']['port'],
    :ssl_enabled => node['tomcat']['ssl']['enabled'].downcase,
    :ssl_max_threads => node['tomcat']['ssl']['options']['max_threads'],
    :ssl_protocol => node['tomcat']['ssl']['options']['protocol'],
    :ssl_ciphers => node['tomcat']['ssl']['options']['ciphers'],
    :ssl_port => node['tomcat']['ssl']['port'],
    :keystore => node['tomcat']['ssl']['keystore']['file'],
    :keystore_pass => keystore_pass.split('').map { |x| '&#' + x.ord.to_s + ';' }.join
  )
  only_if { node['tomcat']['server']['manage'].casecmp('true').zero? || first_run? }
  notifies :restart, "service[#{node['tomcat']['service']['name']}]" if notify_service?(node['tomcat']['install_dir'])
end
