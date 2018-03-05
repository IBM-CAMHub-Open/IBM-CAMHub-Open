#########################################################################
########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Install  recipe (install.rb)
# <> Installation recipe, source the version, unpack the file and install product
#
#########################################################################

# Cookbook Name  - wasliberty
# Recipe         - config_srv.rb
#-------------------------------------------------------------------------------

Chef::Log.info("-------------------------------------")
Chef::Log.info("Start executing recipe: config_srv.rb")

node['was_liberty']['liberty_servers'].each do |srv_index, v|
  server_name = v['name']
  srv_feature_list = v['feature'].split(/[\s,]+/)
  next if srv_index['$INDEX'] && node['was_liberty']['skip_indexes'] == 'true'
  Chef::Log.info("feature list: #{srv_feature_list}")
  # 'users' => {
  #   'admin01': {
  #      'password' => "",
  #      'role' => "admin"
  #   },
  #   'nonadmin01' : {
  #      'password' => "",
  #     'role' => "nonadmin"
  #   }
  # }
  admincenter_users = Hash[ v['users'].map { |_id, data| [ data['name'], Helpers.pwd_encode('xor', data['password']) ] } ]
  admins = v['users'].select { |_, data| data['role'] == 'admin' }.map { |_id, data| data['name'] }

  v['users'].each do |usr_index, usr_data|
    pass = node['was_liberty']['liberty_servers'][srv_index]['users'][usr_index]['password']
    chef_vault = node['was_liberty']['vault']['name']
    unless chef_vault.empty?
      encrypted_id = node['was_liberty']['vault']['encrypted_id']
      require 'chef-vault'
      # pass = ChefVault::Item.load(chef_vault, encrypted_id)['was_liberty']['liberty_servers'][srv_index]['users'][usr_index]['password']
      pass = chef_vault_item(chef_vault, encrypted_id)['was_liberty']['liberty_servers'][srv_index]['users'][usr_index]['password']
    end
    admincenter_users[usr_data['name']] = Helpers.pwd_encode('xor', pass)
  end

  Chef::Log.info("All users: #{admincenter_users.keys}")
  Chef::Log.info("Admin users: #{admins}")
  server_config_file="#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/server.xml"

  new_pass = node['was_liberty']['liberty_servers'][srv_index]['keystore_password']
  chef_vault = node['was_liberty']['vault']['name']
  Chef::Log.info "chef_vault: #{chef_vault}"
  unless chef_vault.empty?
    encrypted_id = node['was_liberty']['vault']['encrypted_id']
    require 'chef-vault'
    # new_pass = ChefVault::Item.load(chef_vault, encrypted_id)['was_liberty']['liberty_servers'][srv_index]['keystore_password']
    new_pass = chef_vault_item(chef_vault, encrypted_id)['was_liberty']['liberty_servers'][srv_index]['keystore_password']
  end

  unless new_pass.empty? # allow for empty keystore password, case in which we don't do anything
    raise "Keystore password should be at least 6 characters long !" if new_pass.length < 6

    ruby_block 'change default keystore pwd' do
      block do
        cmdobj = Mixlib::ShellOut.new("export PATH=$PATH:#{Dir.glob("#{node['was_liberty']['install_dir']}/java/*/jre/bin").first}; keytool -storepasswd -keystore #{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/resources/security/key.jks -storepass Liberty -new #{new_pass}")
        cmdobj.run_command
      end
      only_if "export PATH=$PATH:#{Dir.glob("#{node['was_liberty']['install_dir']}/java/*/jre/bin").first}; keytool -list -keystore #{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/resources/security/key.jks -storepass Liberty"
    end

    ruby_block 'change default key pwd' do
      block do
        cmdobj = Mixlib::ShellOut.new("export PATH=$PATH:#{Dir.glob("#{node['was_liberty']['install_dir']}/java/*/jre/bin").first}; keytool -keypasswd -keystore #{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/resources/security/key.jks -storepass #{new_pass} -alias default -keypass Liberty -new #{new_pass}")
        cmdobj.run_command
      end
      only_if "export PATH=$PATH:#{Dir.glob("#{node['was_liberty']['install_dir']}/java/*/jre/bin").first};  keytool -keypasswd -keystore #{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/resources/security/key.jks -storepass #{new_pass} -alias default -keypass Liberty -new Liberty"
    end
  end

  template server_config_file do
    source "server.xml.erb"
    mode '0750'
    owner node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
    variables(
      :SERVER_NAME => server_name,
      :FEATURE_LIST => srv_feature_list,
      :HOST => node['ipaddress'],
      :HTTPPORT => v['httpport'],
      :HTTPSPORT => v['httpsport'],
      :USERS_PWDS => admincenter_users,
      :ADMINS => admins,
      :KEYSTORE_ID => v['keystore_id'],
      :KEYSTORE_PASSWORD => Helpers.pwd_encode('xor', new_pass)
    )
    notifies :create, "template[#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/jvm.options]"
    notifies :start, "wasliberty_wl_server[#{server_name}]"
  end

  template "#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/jvm.options" do
    source 'jvm.options.erb'
    variables(
      :jvm_options => v['jvm_params'].split
    )
    owner node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
  end

  wasliberty_wl_server server_name do
    action :nothing
    user node['was_liberty']['install_user']
    timeout v['timeout']
    install_dir node['was_liberty']['install_dir']
    force_restart true
    jvm_options v['jvm_params']
  end

  template "#{node['was_liberty']['wlp_user_dir']}/servers/#{server_name}/server.env" do
    source "server.env.erb"
    owner node['was_liberty']['install_user']
    group node['was_liberty']['install_grp']
  end
end
