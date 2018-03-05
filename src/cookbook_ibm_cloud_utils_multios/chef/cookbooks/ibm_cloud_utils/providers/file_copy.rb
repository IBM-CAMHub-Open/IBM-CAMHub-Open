########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################

require 'net/ssh'
require 'net/scp'

use_inline_resources

def whyrun_supported?
  true
end


action :pull do

  Net::SSH.start(new_resource.remote_host, new_resource.login, :password => new_resource.password) do |session|

    @dest = if ::File.directory?(new_resource.destination) # destination is a directory
              ::File.join(new_resource.destination, ::File.basename(new_resource.source))
            else # either it's a file, or...it's missing entirely (case in which we'll also consider it a file)
              new_resource.destination
            end

    Chef::Log.debug "=============== Destination: [#{@dest}] ==============="

    output = session.exec!("md5sum #{new_resource.source}")
    raise "Source file [#{new_resource.source}] missing !" if output =~ /No such file/
    raise "Source file [#{new_resource.source}] not readable !" if output =~ /Permission denied/
    @remote_sum = output.split[0]
    @remote_fsize = session.exec!("stat --printf='%s' #{new_resource.source}").to_i
  end

  # check the local (destionation) file
  if ::File.exist?(@dest)
    local_sum = IO.popen("md5sum #{@dest}").read.split[0]
    @status = "- checksum: #{local_sum}"
  else
    @status = "- not present"
  end

  Chef::Log.info "Remote file: #{new_resource.source} - checksum: #{@remote_sum}"
  Chef::Log.info " Local file: #{@dest} #{@status}"

  if local_sum == @remote_sum
    new_resource.updated_by_last_action(false)
  else
    if !new_resource.priv_ssh_key.nil?
      opts = { keys: [ new_resource.priv_ssh_key ], keys_only: true }
    elsif  !new_resource.password.nil?
      opts = { password: new_resource.password }
    else
      raise "No private key and no password was provided to connect to the remote host !"
    end
    Net::SCP.start(new_resource.remote_host, new_resource.login, opts) do |session|
      Chef::Log.info "Pulling the remote file #{new_resource.source} from #{new_resource.remote_host}..."
      session.download!(new_resource.source, @dest) do |_ch, _name, received, total|
        Chef::Log.info "#{received}/#{total}..." if @remote_fsize > 1_000_000
      end
      Chef::Log.info "Done"
    end
    new_resource.updated_by_last_action(true)
  end
end


action :push do

  raise "Source file [#{new_resource.source}] missing" unless ::File.exist?(new_resource.source)

  Net::SSH.start(new_resource.remote_host, new_resource.login, :password => new_resource.password) do |session|
    testfordir = session.exec!("cd #{new_resource.destination}")

    @dest = if testfordir.empty? # destination is a directory
              ::File.join(new_resource.destination, ::File.basename(new_resource.source))
            else # either it's a file, or...it's missing entirely (case in which we'll also consider it a file)
              new_resource.destination
            end

    Chef::Log.debug "=============== Destination: [#{@dest}] ==============="

    output = session.exec!("md5sum #{@dest}")
    raise "Target file not readable" if output =~ /Permission denied/
    if output =~ /No such file/
      @status = "- not present"
    else
      @remote_sum = output.split[0]
      @status = "- checksum: #{@remote_sum}"
    end
  end

  local_sum = IO.popen("md5sum #{new_resource.source}").read.split[0]
  Chef::Log.info " Local file: #{new_resource.source} - checksum: #{local_sum}"
  Chef::Log.info "Remote file: #{@dest} #{@status}"

  if local_sum == @remote_sum
    new_resource.updated_by_last_action(false)
  else
    if !new_resource.priv_ssh_key.nil?
      opts = { keys: [ new_resource.priv_ssh_key ], keys_only: true }
    elsif  !new_resource.password.nil?
      opts = { password: new_resource.password }
    else
      raise "No private key and no password was provided to connect to the remote host !"
    end
    Net::SCP.start(new_resource.remote_host, new_resource.login, opts) do |session|
      Chef::Log.info "Pushing the local file #{new_resource.source} to #{new_resource.remote_host}"
      session.upload!(new_resource.source, @dest) do |_ch, name, sent, total|
        Chef::Log.info "#{sent}/#{total}..." if ::File.stat(name).size > 1_000_000
      end
      Chef::Log.info "Done"
    end
    new_resource.updated_by_last_action(true)
  end
end
