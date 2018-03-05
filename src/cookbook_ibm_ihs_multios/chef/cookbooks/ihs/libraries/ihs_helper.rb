# Cookbook Name:: ihs
# Library:: ihs_helper
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: IHS helper
# <> Library Functions for the IHS Cookbook
module IHSHelper
  # Helper functions for IHS cookbook
  include Chef::Mixin::ShellOut

  # Functions to determine install status and version for IHS
  def ihs_installed?
    get_version = node['ihs']['install_dir'] + '/bin/versionInfo.sh'

    begin
      !/^IHS\s+installed$/.match(shell_out(get_version).stdout).to_s.empty?
    rescue Errno::ENOENT => e
      Chef::Log.info "File not found: #{get_version}, error: #{e}"
      return false
    end
  end

  def ihs_installed_version
    return '0.0.0.0' unless ihs_installed? #~ip_checker
    get_version = node['ihs']['install_dir'] + '/bin/versionInfo.sh'
    shell_out(get_version).stdout.scan(/Version\s+(\d+\.\d+\.\d+\.\d+)\s*\nID\s+IHS\n/m).first.first
  end

  def ihs_do_install?
    return true unless ihs_installed?
    @requested_version = node['ihs']['version'].split('.')
    @current_version = ihs_installed_version.split('.')
    (@requested_version.slice(0, 3) <=> @current_version.slice(0, 3)) == 0 && (@requested_version <=> @current_version) > 0
  end

  def ihs_first_run?
    ::File.exist?("#{node['ihs']['expand_area']}/ihs_validation.sh")
  end

  # Functions to determine install status and version for the WAS plugin
  def ihs_plg_installed?
    get_version = node['ihs']['plugin']['install_dir'] + '/bin/versionInfo.sh'

    begin
      !/^PLG\s+installed$/.match(shell_out(get_version).stdout).to_s.empty?
    rescue Errno::ENOENT => e
      Chef::Log.info "File not found: #{get_version}, error: #{e}"
      return false
    end
  end

  def ihs_plg_installed_version
    return '0.0.0.0' unless ihs_plg_installed? #~ip_checker
    get_version = node['ihs']['plugin']['install_dir'] + '/bin/versionInfo.sh'
    /^Version\s+(\d+\.\d+\.\d+\.\d+)\s*$/.match(shell_out(get_version).stdout)[1]
  end

  def ihs_plg_do_install?
    return true unless ihs_plg_installed?
    @requested_version = node['ihs']['version'].split('.')
    @current_version = ihs_plg_installed_version.split('.')
    (@requested_version.slice(0, 3) <=> @current_version.slice(0, 3)) == 0 && (@requested_version <=> @current_version) > 0
  end

  # Functions to check/create prescribed installation path
  def subdirs_to_create(dir, user)
    Chef::Log.info("Dir to create: #{dir}, user: #{user}")
    existing_subdirs = []
    remaining_subdirs = dir.split('/')
    remaining_subdirs.shift # get rid of '/'

    until remaining_subdirs.empty?
      Chef::Log.debug("remaining_subdirs: #{remaining_subdirs.inspect}, existing_subdirs: #{existing_subdirs.inspect}")
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

  # 8.5.5.11 -> 8.5.5011
  def make_offering_version(version)
    vers_arry = version.split('.')
    fp_vers = vers_arry.pop.to_i
    ml_vers = vers_arry.pop.to_i
    vers_arry.push((ml_vers * 1000 + fp_vers).to_s).join('.')
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

Chef::Recipe.send(:include, IHSHelper)
Chef::Resource.send(:include, IHSHelper)
