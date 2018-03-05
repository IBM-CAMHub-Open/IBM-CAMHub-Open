#
# Cookbook Name:: db2
# Recipe:: cleanup
#
# Copyright IBM Corp. 2017, 2017
#
# <> Create database recipe (create_db.rb)
# <> This recipe will create instances and databases as specified in attributes.

node['db2']['instances'].each_pair do |instance, attrs|
  next if instance.match('INDEX') && node['db2']['skip_indexes']

  inst_password = instance_password(instance, attrs['instance_username'])
  fenc_password = fenced_password(instance, attrs['fenced_username'])

  db2_instance "Create instance #{attrs['instance_username']}" do
    instance_prefix attrs['instance_prefix']
    instance_type attrs['instance_type']
    instance_username attrs['instance_username']
    instance_groupname attrs['instance_groupname']
    instance_password inst_password
    instance_dir attrs['instance_dir']
    port attrs['port']
    fenced_username attrs['fenced_username']
    fenced_groupname attrs['fenced_groupname']
    fenced_password fenc_password
    fcm_port attrs['fcm_port']
    action :create
  end

  attrs['databases'].each_pair do |db, p|
    next if db.match('INDEX') && node['db2']['skip_indexes']

    db2_database "Create database #{p['db_name']}" do
      instance_username attrs['instance_username']
      instance_groupname attrs['instance_groupname']
      db_name p['db_name']
      db_data_path p['db_data_path']
      db_path p['db_path']
      pagesize p['pagesize']
      territory p['territory']
      codeset p['codeset']
      db_collate p['db_collate']
      database_update p['database_update'] unless p['database_update'].nil?
      database_users p['database_users'] unless p['database_users'].nil?
      instance_key instance # needed for password retriebal of db users
      database_key db       # needed for password retriebal of db users
      action :create
    end
  end
end
