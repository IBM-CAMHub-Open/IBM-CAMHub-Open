# Cookbook Name:: db2
# Library:: db2_helper
#
# Copyright IBM Corp. 2017, 2017
#
# <> library: DB2 helper
# <> Library Functions for the DB2 Cookbook
include Chef::Mixin::ShellOut

module DB2
  # Helper module
  module Helper
    def db2_installed_version(install_dir)
      return '0.0.0.0' unless File.exist?("#{install_dir}/install/db2ls")
      case node['os']
      when 'linux'
        cmd = shell_out!("#{install_dir}/install/db2ls -c")
        cmd.stdout.lines.grep(/\d+\.\d+\.\d+\.\d+/)[0].split(':')[1].strip
      end
    end

    def db2_installed?(install_dir, version)
      return false unless File.exist?("#{install_dir}/install/db2ls")
      case node['os']
      when 'linux'
        cmd = shell_out!("#{install_dir}/install/db2ls -c")
        instver = cmd.stdout.lines.grep(/\d+\.\d+\.\d+\.\d+/)[0].split(':')[1].strip
        Chef::Log.info("Installed version: #{instver}")
      end
      cmd.stderr.empty? && !(instver =~ /^#{version}/).nil?
    end

    def db2_fp_installed?(install_dir, fixpack)
      Chef::Log.debug "db2_installed? params: install_dir: #{install_dir}, fixpack: #{fixpack}"
      return false unless File.exist?("#{install_dir}/install/db2ls")
      case node['os']
      when 'linux'
        cmd = shell_out!("#{install_dir}/install/db2ls -c")
        instfp = cmd.stdout.lines.grep(/\d+\.\d+\.\d+\.\d+/)[0].split(':')[2].strip
      end
      raise "The db2_fixpack resource detected that the fix pack version being used is at a lower level #{fixpack} than the installed product's level #{instfp}." if fixpack.to_i < instfp.to_i
      cmd.stderr.empty? && !(instfp =~ /#{fixpack}/).nil?
    end

    def db2_instance_created?(install_dir, instance)
      Chef::Log.debug "db2_instance_created? params: install_dir: #{install_dir}, instance: #{instance}"
      return false unless File.exist?("#{install_dir}/instance/db2ilist")
      case node['os']
      when 'linux'
        command = "/instance/db2ilist"
      end
      cmd = shell_out!("#{install_dir}#{command}")
      cmd.stderr.empty? && /#{instance}/.match(cmd.stdout)
    end

    def db2_database_created?(db_name, install_dir, instance)
      raise "DB2 instance #{@new_resource.instance_username} does not exist. Please use the right instance or create #{@new_resource.instance_username} instance first" unless db2_instance_created?(install_dir, instance)
      Chef::Log.debug "db2_database_created? params: db_name: #{db_name}, instance: #{instance}"
      case node['os']
      when 'linux'
        command = "su - #{instance}  -s /bin/bash  -c \"( db2 'list database directory')\""
      end
      begin
        cmd = shell_out!(command)
      rescue StandardError
        return nil
      end
      cmd.stderr.empty? && /#{db_name}/i.match(cmd.stdout)
    end

    def db2_das_started?
      case node['os']
      when 'linux'
        command = "ps -ef"
      end
      cmd = shell_out!(command)
      cmd.stderr.empty? && /db2dasrrm/.match(cmd.stdout)
    end

    def db2_das_stopped?
      case node['os']
      when 'linux'
        command = "ps -ef"
      end
      cmd = shell_out!(command)
      cmd.stderr.empty? && /db2dasrrm/.match(cmd.stdout).nil?
    end

    def db2_instance_started?(instance)
      case node['os']
      when 'linux'
        command = "ps -ef"
      end
      cmd = shell_out!(command)
      cmd.stderr.empty? && /^#{instance}(.+)db2sysc/.match(cmd.stdout)
    end

    def db2_instance_stopped?(instance)
      case node['os']
      when 'linux'
        command = "ps -ef"
      end
      cmd = shell_out!(command)
      cmd.stderr.empty? && /^#{instance}(.+)db2sysc/.match(cmd.stdout).nil?
    end

    def db2_list_instances(db2_install_dir)
      Chef::Log.debug "db2_list_instances? params: db2_install_dir: #{db2_install_dir}"
      return [] unless File.exist?("#{db2_install_dir}/bin/db2ilist")
      cmd = shell_out!("#{db2_install_dir}/bin/db2ilist")
      instances=[]
      cmd.stdout.each_line do |line|
        instances.push line.chomp
      end
      instances
    end
  end
  
  # OS functions
  module OS
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
      all = File.stat(path).mode & 1 == 1 # other has x
      return all if user == 'nobody'
      # User may not exist at first run
      begin
        me = File.stat(path).uid == Etc.getpwnam(user).uid && File.stat(path).mode & 64 == 64 # owner has x
        us = File.stat(path).gid == Etc.getpwnam(user).gid && File.stat(path).mode & 8 == 8 # group has x
      rescue ArgumentError => e
        Chef::Log.debug("can_traverse?: #{e}")
        me = false
        us = false
      end
      me || us || all
    end
  end
end

Chef::Recipe.send(:include, DB2::Helper)
Chef::Resource.send(:include, DB2::Helper)
