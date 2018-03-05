# Cookbook Name:: was
# Library:: was_helper
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: WAS helper
# <> Library Functions for the WAS Cookbook
module WASHelper
  # Helper functions for WAS cookbook
  include Chef::Mixin::ShellOut

  # Run shell command
  def run_shell_cmd(cmd, user)
    shell_command = if user == 'root'
                      cmd
                    else
                      "su - #{user} -s /bin/sh -c \"#{cmd}\""
                    end
    shell_out!(shell_command)
  end

  def subdirs_to_create(dir, user)
    Chef::Log.info("Dir to create: #{dir}, user: #{user}")
    existing_subdirs = []
    remaining_subdirs = dir.split('/')
    remaining_subdirs.shift # get rid of '/'

    until remaining_subdirs.empty?
      Chef::Log.info("remaining_subdirs: #{remaining_subdirs.inspect}, existing_subdirs: #{existing_subdirs.inspect}")
      path = existing_subdirs.push('/' + remaining_subdirs.shift).join
      break unless File.exist?(path)
      raise "Path #{path} exists and is a file, expecting directory." unless File.directory?(path)
      raise "Directory #{path} exists but is not traversable by #{user}." unless can_traverse?(user, path)
    end

    new_dirs = [existing_subdirs.join]
    new_dirs.push(new_dirs.last + '/' + remaining_subdirs.shift) until remaining_subdirs.empty?
    new_dirs
  end

  def can_traverse?(user, path)
    return true if user == 'root'
    byme = File.stat(path).uid == -> { Etc.getpwnam(user).uid } && File.stat(path).mode & 64 == 64 # owner has x
    byus = File.stat(path).gid == -> { Etc.getpwnam(user).gid } && File.stat(path).mode & 8 == 8 # group has x
    byall = File.stat(path).mode & 1 == 1 # other has x
    byme || byus || byall
  end

  def was_offering_version
    vers_arry = node['was']['version'].split('.')
    fp_vers = vers_arry.pop.to_i
    ml_vers = vers_arry.pop.to_i
    second_ver = vers_arry.pop.to_s
    first_ver = vers_arry.pop.to_s
    version = (first_ver + second_ver)
    case version
    when '85'
      vers_arry.push((ml_vers * 1000 + fp_vers).to_s).join('.')
    when '90'
      vers_arry.push((ml_vers * 1 + fp_vers).to_s).join('.')
    end
    first_ver + '.' + second_ver + '.' + vers_arry.pop.to_s
  end

  def was_java_offering_version
    vers_arry = node['was']['java_version'].split('.')
    fp_vers = vers_arry.pop.to_i
    ml_vers = vers_arry.pop.to_i * 10
    second_ver = vers_arry.pop.to_s
    first_ver = vers_arry.pop.to_s
    #vers_arry.push((ml_vers * 10 + fp_vers).to_s).join('.')
    first_ver + '.' + second_ver + '.' + ml_vers.to_s + fp_vers.to_s
  end

  def was_tags(in_string)
    if in_string.include? "{SHORTHOSTNAME}"
      short_hostname = node['hostname']
      in_string.gsub("{SHORTHOSTNAME}", short_hostname)
    elsif in_string.include? "{FULLHOSTNAME}"

      full_hostname = node['fqdn']
      Chef::Log.info("ohai hostname fqdn: #{full_hostname}")
      in_string.gsub("{FULLHOSTNAME}", full_hostname)
    else
      in_string
    end
  end

  def fix_user_ownership(folders)
    folders.each do |folder|
      execute "chown-#{folder}" do
        command "chown -R #{node['was']['os_users']['was']['name']}:#{node['was']['os_users']['was']['gid']} #{folder}"
        not_if { File.stat(folder).uid == Etc.getpwnam(node['was']['os_users']['was']['name']).uid && File.stat(folder).gid == Etc.getpwnam(node['was']['os_users']['was']['name']).gid }
      end
    end
  end
end

Chef::Recipe.send(:include, WASHelper)
Chef::Resource.send(:include, WASHelper)
