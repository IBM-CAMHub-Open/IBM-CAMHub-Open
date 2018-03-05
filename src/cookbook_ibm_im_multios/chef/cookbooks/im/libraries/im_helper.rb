# Cookbook Name:: im
# Library:: im_helper
#
# Copyright IBM Corp. 2016, 2017
#
# <> library: IM helper
# <> Library Functions for the IM Cookbook

include Chef::Mixin::ShellOut

module IM
  # Helper module
  module Helper
    # Determine if IM is already installed, for idempotence guards
    def im_installed?(install_dir, version = '', user = 'root')
      Chef::Log.debug "im_installed? params: install_dir: #{install_dir}, user: #{user}, version: #{version}"
      return false unless File.exist?("#{install_dir}/eclipse/tools/imcl")
      cmd = "#{install_dir}/eclipse/tools/imcl version | grep ^Version || true"
      cmd_out = run_shell_cmd(cmd, user)
      begin
        cmd_match = /^Version: (\d+\.\d+\.\d+)/.match(cmd_out.stdout).captures[0]
      rescue NoMethodError => e
        Chef::Log.debug "Error in im_installed? library function: #{e}"
        return false
      end
      cmd_out.stderr.empty? && (version.empty? ? !cmd_match.empty? : cmd_match == version)
    end

    # helper module used to check if the latest fixpack available in IM Repository is installed.
    def im_fixpack_installed?(install_dir, repository, security_params, offering_id_im_version, user = 'root')
      Chef::Log.debug "im_fixpack_installed? params: install_dir: #{install_dir}, repository: #{repository}, offering_id: #{offering_id_im_version}, user: #{user}"
      cmd = "#{install_dir}/eclipse/tools/imcl listAvailablePackages -repositories #{repository} #{security_params} | grep #{offering_id_im_version} | sort -nr | head -1 || true"
      latest_available_cmd = run_shell_cmd(cmd, user)
      latest_available = latest_available_cmd.stdout.chomp
      return true if latest_available.empty?
      cmd = "#{install_dir}/eclipse/tools/imcl listInstalledPackages | grep #{latest_available} || true"
      cmd_out = run_shell_cmd(cmd, user)
      Chef::Log.debug "Installed package: #{cmd_out.stdout} ; Latest available Package: #{latest_available}"
      cmd_out.stderr.empty? && (cmd_out.stdout.chomp == latest_available)
    end

    # Determine if IM offering (with optional version) is already installed
    def ibm_installed?(install_dir, offering_id, offering_version = '', user = 'root')
      Chef::Log.debug "ibm_installed? params: install_dir: #{install_dir}, offering_id: #{offering_id}, offering_version: #{offering_version}, user: #{user}"
      cmd = "#{install_dir}/eclipse/tools/imcl listInstalledPackages | grep #{offering_id}_#{offering_version} || true"
      cmd_out = run_shell_cmd(cmd, user)
      cmd_out.stderr.empty? && (cmd_out.stdout =~ /^#{offering_id}_#{offering_version}/)
    end

    # List IM offerings per offering_id
    def im_listavailable?(install_dir, repository, security_params, offering_id, user = 'root')
      Chef::Log.debug "im_listavailable? params: install_dir: #{install_dir}, repository: #{repository}, offering_id: #{offering_id}, user: #{user}"
      cmd = "#{install_dir}/eclipse/tools/imcl listAvailablePackages -repositories #{repository} #{security_params} | grep #{offering_id} || true"
      list_available_cmd = run_shell_cmd(cmd, user)
      packages_array = []
      list_available_cmd.stdout.each_line do |line|
        packages_array << line.chomp
      end
      packages_array
    end

    # Determine if IM offering (with version) is available in supplied repository
    def im_isavailable?(install_dir, repository, security_params, offering, user = 'root')
      offering_id = offering.match("_").pre_match
      offering_version = offering.match("_").post_match
      Chef::Log.debug "im_isavailable? params: install_dir: #{install_dir}, repository: #{repository}, offering_id: #{offering_id}, offering_version: #{offering_version}, user: #{user}"
      cmd = "#{install_dir}/eclipse/tools/imcl listAvailablePackages -repositories #{repository} #{security_params}| grep #{offering_id}_#{offering_version} || true"
      is_available_cmd = run_shell_cmd(cmd, user)
      packages_array = []
      is_available_cmd.stdout.each_line do |line|
        a = line.chomp.scan(/#{offering_id}_(#{offering_version}.*)$/).first.first.to_s
        packages_array.push(a)
      end
      raise "No packages found for #{offering_id}_#{offering_version}!" if packages_array.empty?
      packages_array
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

    # Verify user exists
    def im_user_exists_unix?(user)
      cmd = shell_out!("getent passwd #{user} || true", :cwd => '/tmp') # ~password_checker
      cmd.stderr.empty? && (cmd.stdout =~ /^#{user}/)
    end

    def chef_vault_item(bag, id)
      if ChefVault::Item.vault?(bag, id)
        ChefVault::Item.load(bag, id)
      elsif node['chef-vault']['databag_fallback']
        Chef::DataBagItem.load(bag, id)
      else
        raise "Trying to load a regular data bag item #{id} from #{bag}, and databag_fallback is disabled"
      end
    end
  end
end

module HandlerSensitiveFiles
  # Helper module for sensitive files
  class Helper
    # Helper module for sensitive files
    def remove_sensitive_files_on_run_failure
      FileUtils.rm("/tmp/master_password_file.txt") if ::File.exist?('/tmp/master_password_file.txt')
      FileUtils.rm("/tmp/credential.store") if ::File.exist?('/tmp/credential.store')
      Chef::Log.info "Sensitive files removed"
    end
  end
end

Chef::Recipe.send(:include, IM::Helper)
Chef::Resource.send(:include, IM::Helper)
