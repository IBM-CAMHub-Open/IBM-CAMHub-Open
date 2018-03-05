#
# Cookbook Name:: db2
# Provider:: db2_database
#
# Copyright IBM Corp. 2017, 2017
#
# ::Chef::Resource.send(:include, DB2::Helper)
include DB2::Helper
include DB2::OS
use_inline_resources

action :create do
  if @current_resource.db2_database_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  elsif @current_resource.db2_instance_created
    converge_by("Install #{@new_resource}") do
      raise "db2 name is limited to 8 character" if new_resource.db_name.length > 8

      # create directories
      subdirs, reason = subdirs_to_create(new_resource.db_data_path, new_resource.instance_username)
      raise reason unless reason.empty?
      subdirs.each do |dir|
        directory "create db_data_path: #{dir}" do
          path dir
          action :create
          owner new_resource.instance_username
          group new_resource.instance_groupname
          recursive true
        end
      end

      unless new_resource.db_path.empty? || new_resource.db_path == new_resource.db_data_path
        subdirs, reason = subdirs_to_create(new_resource.db_path, new_resource.instance_username)
        raise reason unless reason.empty?
        subdirs.each do |dir|
          directory "create db_path: #{dir}" do
            path dir
            action :create
            owner new_resource.instance_username
            group new_resource.instance_groupname
            recursive true
          end
        end
      end
 
      # compose command line
      cmd = "create database #{new_resource.db_name} ON #{new_resource.db_data_path}"
      cmd += " DBPATH ON #{new_resource.db_path}" unless new_resource.db_path.empty? || new_resource.db_path == new_resource.db_data_path
      cmd += " USING CODESET #{new_resource.codeset}" unless new_resource.codeset.empty?
      cmd += " TERRITORY #{new_resource.territory}" unless new_resource.territory.empty?
      cmd += " COLLATE USING #{new_resource.db_collate}" unless new_resource.db_collate.empty?
      cmd += " PAGESIZE #{new_resource.pagesize}" unless new_resource.pagesize.empty?
      execute "Create database(#{new_resource.db_name})" do
        command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 '#{cmd}' | tee -a ~/db2_create_database_#{new_resource.db_name}.log\""
      end
    end

    # create database users and grant access
    unless new_resource.database_users.empty?
      new_resource.database_users.each_pair do |user, data|
        # skip LDAP users
        Chef::Log.debug("user #{user}: #{data.inspect}")
        unless data['ldap_user'].casecmp('true') == 0
          # create group
          group "creating OS group #{data['user_gid']}" do
            group_name data['user_gid']
          end
          # create user
          user "creating OS user #{data['user_name']}" do
            username data['user_name']
            gid data['user_gid']
            # home data['user_home'] unless data['user_home'].casecmp('default') == 0
            manage_home true
          end
          # set password
          chef_vault = node['db2']['vault']['name']
          encrypted_id = node['db2']['vault']['encrypted_id']
          user_pwd = chef_vault_item(chef_vault, encrypted_id)['db2']['instances'][new_resource.instance_key]['databases'][new_resource.database_key]['database_users'][user]['user_password']
          execute "seting password for #{data['user_name']}" do
            command "echo #{data['user_name']}:\'#{user_pwd}\' | chpasswd"
            sensitive true
          end
        end
        # grant access
        execute "granting \'#{data['user_access']}\' on database \'#{new_resource.db_name}\' to user \'#{data['user_name']}\'" do
          command "su - #{new_resource.instance_username} -s /bin/bash -c \"exec > >(tee -a ~/db2_create_database_#{new_resource.db_name}.log); exec 2> >(tee -a ~/db2_create_database_#{new_resource.db_name}.log); \
            db2 CONNECT TO #{new_resource.db_name} && \
            db2 GRANT #{data['user_access']} ON DATABASE TO USER #{data['user_name']} && \
            db2 terminate\""
          not_if { data['user_access'].casecmp('none') == 0 } # the user is created, but no access is granted
        end
      end
    end

    # update database
    # this is 'install only', updates on prod db should not be performed without proper backup configuration
    unless new_resource.database_update.empty?
      dummy_backup = false
      new_resource.database_update.each_pair do |option, value|
        next if value.casecmp('default').zero?
        dummy_backup = true
        if option.casecmp('NEWLOGPATH').zero? || option.casecmp('FAILARCHPATH').zero?
          subdirs, _reason = subdirs_to_create(value, new_resource.instance_username)
          # raise reason unless reason.empty?
          subdirs.each do |dir|
            directory "create #{option}: #{dir}" do
              path dir
              action :create
              owner new_resource.instance_username
              group new_resource.instance_groupname
              recursive true
            end
          end
        end
        execute "Update #{new_resource.db_name} using #{option} = #{value}" do
          command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 UPDATE DB CFG FOR #{new_resource.db_name} USING #{option} #{value} DEFERRED | tee -a ~/db2_create_database_#{new_resource.db_name}.log\""
        end
      end

      # perform dummy backup to enable updates
      execute "Perform dummy backup #{new_resource.db_name} to enable updates" do
        command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 BACKUP DB #{new_resource.db_name} TO /dev/null | tee -a ~/db2_create_database_#{new_resource.db_name}.log\""
        only_if { dummy_backup }
      end
      
      # ... and restart instance
      db2_service "Stop instance #{new_resource.instance_username}" do
        instance_username new_resource.instance_username
        action :stop_instance
      end
      db2_service "Start instance #{new_resource.instance_username}" do
        instance_username new_resource.instance_username
        action :start_instance
      end
    end

    # save execution log
    execute "Save log for #{new_resource.db_name}" do
      command "mv #{Etc.getpwnam(new_resource.instance_username).dir}/db2_create_database_#{new_resource.db_name}.log #{node['ibm']['log_dir']}"
    end

  else
    raise "DB2 instance #{@new_resource.instance_username} does not exist. Please use the right instance or create #{@new_resource.instance_username} instance first"
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::Db2Database.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.db_name(@new_resource.db_name)
  @current_resource.db2_install_dir(@new_resource.db2_install_dir)
  @current_resource.instance_username(@new_resource.instance_username)

  #Get current state
  @current_resource.db2_database_created = db2_database_created?(@new_resource.db_name, @new_resource.db2_install_dir, @new_resource.instance_username)
  @current_resource.db2_instance_created = db2_instance_created?(@new_resource.db2_install_dir, @new_resource.instance_username)
end
