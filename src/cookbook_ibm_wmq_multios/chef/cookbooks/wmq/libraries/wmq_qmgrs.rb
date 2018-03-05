# Cookbook Name:: wmq
# Library:: wmq_qmgrs
#
# Copyright IBM Corp. 2016, 2017
#
# <> library: WMQ QMGR
# <> Queue Manager Management fo the WMQ cookbook

# <> library: WMQQmgrs
# <> Library Functions for to manage Queue Managers
module WMQQmgrs
  # <> Queue Manager Management fo the WMQ cookbook
  include Chef::Mixin::ShellOut

  def wmq_qmgr_defined?(qmgr_name)
    #Returns a boolean depending on whether a queue manager is defined or not
    run_cmd = node['wmq']['install_dir'] + '/bin/dspmq | grep ' + qmgr_name
    output = shell_out(run_cmd)
    !output.stdout.to_s.empty?
  end

  def wmq_qmgr_started?(qmgr_name)
    #Returns a boolean depending on whether a queue manager Running or not
    run_cmd = node['wmq']['install_dir'] + '/bin/dspmq | grep ' + qmgr_name + ' | grep Running'
    output = shell_out(run_cmd)
    !output.stdout.to_s.empty?
  end

  def execute_create_qmgr(qmgrobject)
    # Creates a queue manager if not already created
    name = qmgrobject['name']
    description = qmgrobject['description']
    listener_port = qmgrobject['listener_port']
    loggingtype = qmgrobject['loggingtype']
    primarylogs = qmgrobject['primarylogs']
    secondarylogs = qmgrobject['secondarylogs']
    logsize = qmgrobject['logsize']
    dlq = qmgrobject['dlq']

    Chef::Log.info("Creating Queue Manager.....")
    Chef::Log.info("   NAME:               #{name}")
    Chef::Log.info("   DESCRIPTION:        #{description}")
    Chef::Log.info("   LISTENER_PORT:      #{listener_port}")
    Chef::Log.info("   LOGGINGTYPE:        #{loggingtype}")
    Chef::Log.info("   PRIMARYLOGS:        #{primarylogs}")
    Chef::Log.info("   SECONDARYLOGS:      #{secondarylogs}")
    Chef::Log.info("   LOGSIZE:            #{logsize}")
    Chef::Log.info("   DLQ:                #{dlq}")

    execute "create_qmgr" do
      command "#{node['wmq']['install_dir']}/bin/crtmqm -p #{listener_port} -#{loggingtype} -lp #{primarylogs} -ls #{secondarylogs} -lf #{logsize} -u #{dlq} #{name}"
      user node['wmq']['os_users']['mqm']['name']
      group node['wmq']['os_users']['mqm']['gid']
      only_if { !wmq_qmgr_defined?(name) }
    end
  end

  def execute_start_qmgr(qmgrobject)
    # Creates a queue manager if not already created
    name = qmgrobject['name']

    Chef::Log.info("Starting Queue Manager.....")
    Chef::Log.info("   NAME:               #{name}")

    execute "start_qmgr" do
      command "#{node['wmq']['install_dir']}/bin/strmqm #{name}"
      user node['wmq']['os_users']['mqm']['name']
      group node['wmq']['os_users']['mqm']['gid']
      returns [0, 5]
      not_if { wmq_qmgr_started?(name) }
      only_if { wmq_qmgr_defined?(name) }
    end
  end

  def execute_stop_qmgr(qmgrobject)
    # Creates a queue manager if not already created
    name = qmgrobject['name']

    Chef::Log.info("Stopping Queue Manager.....")
    Chef::Log.info("   NAME:               #{name}")

    execute "stop_qmgr" do
      command "#{node['wmq']['install_dir']}/bin/endmqm -w #{name}"
      user node['wmq']['os_users']['mqm']['name']
      returns [0, 40]
      group node['wmq']['os_users']['mqm']['gid']
      only_if { wmq_qmgr_started?(name) }
    end
  end
end

Chef::Recipe.send(:include, WMQQmgrs)
Chef::Resource.send(:include, WMQQmgrs)
