# Cookbook Name:: tomcat
# Library:: tomcat_helper
#
# Copyright IBM Corp. 2017, 2017
#

# <> library: Tomcat helper
# <> Library Functions for the Tomcat Cookbook
module TomcatHelper
  # Helper functions for Tomcat cookbook
  include Chef::Mixin::ShellOut

  # Is this the first run?
  def first_run?
    ::File.exist?(node['tomcat']['validation_script'])
  end

  # Functions to determine install status and version for Tomcat
  def tomcat_installed?(catalina_home)
    get_version = catalina_home + '/bin/version.sh'

    begin
      !/^Server version:\s+Apache Tomcat\/(\d+\.\d+\.\d+)\s*$/.match(shell_out(get_version).stdout)[1].empty?
    rescue Errno::ENOENT => e
      Chef::Log.debug "File not found: #{get_version}, error: #{e}"
      return false
    end
  end

  def tomcat_installed_version(catalina_home)
    get_version = catalina_home + '/bin/version.sh'
    return '0.0.0' unless ::File.exist?(get_version)
    begin
      /^Server version:\s+Apache Tomcat\/(\d+\.\d+\.\d+)\s*$/.match(shell_out(get_version).stdout)[1]
    rescue Errno::ENOENT => e
      Chef::Log.debug "Error running #{get_version}: \'#{e}\'"
      return false
    end
  end

  def tomcat_upgrade?(catalina_home, version)
    return false unless tomcat_installed?(catalina_home)
    requested_version = version.split('.')
    current_version = tomcat_installed_version(catalina_home).split('.')
    (requested_version.slice(0, 2) <=> current_version.slice(0, 2)) == 0 && (requested_version <=> current_version) > 0
  end

  def notify_service?(catalina_home)
    # we don't want to restart service at initial install (after gathering evidence)
    # neither if the service state is not set to in attributes
    tomcat_installed?(catalina_home) && node['tomcat']['service']['started'].to_s.casecmp('true') == 0
  end

  # Build partial path
  # User has to pre-exist, if not - default to 'other' perms
  def subdirs_to_create(dir, user)
    Chef::Log.debug("Dir to create: #{dir}, user: #{user}")
    existing_subdirs = []
    remaining_subdirs = dir.split('/')
    remaining_subdirs.shift # get rid of '/'
    reason = ''
    
    until remaining_subdirs.empty?
      Chef::Log.debug("remaining_subdirs: #{remaining_subdirs.inspect}, existing_subdirs: #{existing_subdirs.inspect}")
      path = existing_subdirs.push('/' + remaining_subdirs.shift).join
      break unless File.exist?(path)
      reason = "Path \'#{path}\' exists and is a file, expecting directory." unless File.directory?(path)
      reason = "Directory \'#{path}\' exists but is not traversable by user \'#{user}\'." unless can_traverse?(user, path)
    end

    new_dirs = [existing_subdirs.join]
    new_dirs.push(new_dirs.last + '/' + remaining_subdirs.shift) until remaining_subdirs.empty?
    [new_dirs, reason]
  end

  def can_traverse?(user, path)
    return true if user == 'root'
    # User may not exist at first run
    begin
      me = File.stat(path).uid == Etc.getpwnam(user).uid && File.stat(path).mode & 64 == 64 # owner has x
      us = File.stat(path).gid == Etc.getpwnam(user).gid && File.stat(path).mode & 8 == 8 # group has x
    rescue ArgumentError => e
      Chef::Log.debug("can_traverse?: #{e}")
      me = false
      us = false
    end
    all = File.stat(path).mode & 1 == 1 # other has x
    me || us || all
  end

  # Run shell command
  def run_shell_cmd(cmd, user)
    shell_command = if user == 'root'
                      cmd
                    else
                      "su - #{user} -s /bin/sh -c \"#{cmd}\""
                    end
    shell_out!(shell_command)
  end
end
