# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
require 'net/ssh'

use_inline_resources

def whyrun_supported?
  true
end

def ssh_exec!(ssh, command)
  stdout_data = ''
  stderr_data = ''
  exit_code = nil
  exit_signal = nil
  ssh.open_channel do |channel|
    channel.exec(command) do |_ch, success|
      abort "FAILED: couldn't execute command (ssh.channel.exec)" unless success

      channel.on_data { |_ch, data| stdout_data += data }
      channel.on_extended_data { |_ch, _type, data| stderr_data += data }
      channel.on_request('exit-status') { |_ch, data| exit_code = data.read_long }
      channel.on_request('exit-signal') { |_ch, data| exit_signal = data.read_long }
    end
  end
  ssh.loop
  [stdout_data, stderr_data, exit_code, exit_signal]
end

def check
  only_if = 0
  not_if = 1
  Net::SSH.start(new_resource.server, new_resource.user, :password => new_resource.password) do |ssh|
    unless new_resource.only_if_check.nil?
      only_if = ssh_exec!(ssh, new_resource.only_if_check)[2]
      Chef::Log.debug("Only_if constraint is #{only_if}")
    end
    unless new_resource.not_if_check.nil?
      not_if = ssh_exec!(ssh, new_resource.not_if_check)[2]
      Chef::Log.debug("Not if constraint is #{not_if}")
    end
    if only_if.zero? && not_if != 0
      Chef::Log.debug('Constraint conditions are met')
      return true
    else
      Chef::Log.debug('Constraint conditions are not met')
      return false
    end
  end
end

action :copy do
  res = ''
  c = Net::SSH.start(new_resource.server, new_resource.user, :password => new_resource.password)
  c.open_channel do |channel|
    channel.exec("cat > #{new_resource.target}") do |_ch, _success|
      channel.on_data do |_ch, data|
        res << data
      end
      data = ::File.read(new_resource.source)
      channel.send_data data
      channel.eof!
    end
  end
  c.loop
  new_resource.updated_by_last_action(true)
end

action :exec do
  Net::SSH.start(new_resource.server, new_resource.user, :password => new_resource.password) do |ssh|
    if check
      rc = ssh_exec!(ssh, new_resource.command)[2]
      Chef::Log.debug("Executed command #{new_resource.command} with return code #{rc} ")
    else
      Chef::Log.info('One of the constraints failed')
    end
  end
  new_resource.updated_by_last_action(true)
end
