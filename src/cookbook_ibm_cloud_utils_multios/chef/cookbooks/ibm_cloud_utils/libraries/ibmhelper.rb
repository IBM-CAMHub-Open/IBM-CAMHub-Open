# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
include Chef::Mixin::ShellOut
# Helper module
module IBM
  require 'rbconfig'
  # Include various helper functions
  module IBMHelper
    # TODO: make it support Windows too
    def self.find_mountpoint(path)
      path = Pathname.new(path)
      until path.mountpoint?
        path = path.parent
        Chef::Log.debug("Parrent path: #{path}.")
      end
      path
    end

    def self.check_free_space(node, path, freespace, continue = false, errormessage = nil)
      Chef::Log.info("Checking path #{path} has at least #{freespace} MB freespace.")
      errormessage ||= "Make sure there are at least #{freespace} MB available under #{path}!"
      @mountfound = false
      mountpoint = IBMHelper.find_mountpoint(path)
      Chef::Log.debug("Checking mountpoint #{mountpoint} has #{freespace} MB.")
      node.to_hash['filesystem'].each do |_k, v|
        Chef::Log.debug("Checking filesystem mounted at: #{v['mount']} with available kb #{v['kb_available']}.")
        # if v['mount'].eql? mountpoint.to_s
        next unless v['mount'].eql? mountpoint.to_s

        @mountfound = true
        mb_available = v['kb_available'].to_i / 1024
        Chef::Application.fatal!(errormessage, 13) if mb_available < freespace && !continue
        Chef::Log.warn(errormessage) if mb_available < freespace && continue
        Chef::Log.info("Mountpoint #{mountpoint} has #{mb_available} MB available.")
        break

        # end  # pair if
      end
      Chef::Application.fatal!("No mountpoint found for #{path}!", 15) unless @mountfound || continue
    end

    # This function is used to retrive the item name from within a databag
    # based on a key + value that is found in that item.
    def self.get_item_by_hostname(data_bag_name, key_name, value)
      # for now works on linux only
      return unless RUBY_PLATFORM.downcase.include?('linux')
      data_bag(data_bag_name).each do |item_name|
        next unless data_bag_item(data_bag_name, item_name).key?(key_name)
        next unless data_bag_item(data_bag_name, item_name)[key_name] == value
        return item_name
      end
    end

    # Get a sensitive data (password) from a Vault server
    def self.get_vault_secret(vault_server, session_token, secret_path)
      require 'net/http'
      require 'net/https'
      require 'json'

      Chef::Application.fatal!("Invalid Vault URL: #{vault_server}", 16) unless vault_server.include?('http')
      Chef::Application.fatal!("Invalid path to secret: #{secret_path}", 17) if secret_path.empty? || secret_path.nil?

      vault_server += '/v1/secret/' unless vault_server.include?('v1')
      vault_url = (vault_server + '/' + path).gsub(%r{//}, '/').gsub(/\:\//, '://')
      Chef::Log.debug("Getting secret from Vault: #{vault_url}")

      uri = URI.parse(vault_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      # Force ignore of self signed certificate
      # TODO: need to find out a better way
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      resp = http.get(uri.path, 'X-Vault-Token' => session_token)
      Chef::Application.fatal!('Permission denied', 17) if resp.code == '403'

      data = resp.code == '200' ? JSON.parse(resp.body) : nil

      data ? data['data']['value'] : nil
    end

    # Verify whether the pattern is supported on operating system of the vm
    def self.verify_supported_os(node, supported_os_list, error_message)
      operating_system = node['platform']
      supported_os_list.each_pair do |os, support|
        next if os.to_s != operating_system.to_s
        next unless support == "false"
        Chef::Log.warn(error_message)
        Chef::Log.info("OS not supported by pattern: #{os}")
        raise error_message
      end
    end

    def self.awscloud?
      get_version = 'cat /sys/devices/virtual/dmi/id/bios_version'

      begin
        !/amazon$/.match(shell_out(get_version).stdout).to_s.empty?
      rescue Errno::ENOENT => e
        Chef::Log.info "File not found: #{get_version}, error: #{e}"
        return false
      end
    end
  end
end
