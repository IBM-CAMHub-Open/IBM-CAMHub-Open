#
# Cookbook Name:: ibm_cloud_utils
# Provider:: sw_repo
#
# Copyright IBM Corp. 2017, 2017
#

use_inline_resources

def whyrun_supported?
  true
end

action :check_package do
  require 'net/http'
  require 'openssl'
  sw_repo_user = new_resource.sw_repo_user if new_resource.secure_repo == "true"
  sw_repo_password = define_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.repository)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.repository.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.sw_repo_self_signed_cert == "true"
  request = Net::HTTP::Head.new(uri.request_uri + '/' + new_resource.sw_repo_path + '/' + new_resource.package)
  request.basic_auth(sw_repo_user, sw_repo_password) if new_resource.secure_repo == "true"
  begin
    res = http.request(request)
  rescue OpenSSL::SSL::SSLError
    raise "ERROR: Self signed certificate detected when trying to access #{new_resource.repository}. Please use sw_repo_self_signed_cert == \"true\" "
  end
  if res.code == "200"
    print "\n PASS: Package #{new_resource.package} found in #{new_resource.repository}/#{new_resource.sw_repo_path} \n"
  elsif res.code == "400"
    raise "\n ERROR: #{res.code} Bad Request. The request could not be understood by the server due to malformed syntax. \n"
  elsif res.code == "401"
    raise "\n ERROR: #{res.code} Unauthorized. The request requires user authentication. \n"
  elsif res.code == "404"
    raise "\n ERROR: Package #{new_resource.package} not found in #{new_resource.repository}/#{new_resource.sw_repo_path} \n"
  end
  new_resource.updated_by_last_action(true)
end

def define_repo_password
  sw_repo_password = ''
  encrypted_id = node['ibm_internal']['vault']['item']
  chef_vault = node['ibm_internal']['vault']['name']
  unless chef_vault.empty?
    require 'chef-vault'
    sw_repo_password = chef_vault_item(chef_vault, encrypted_id)['ibm']['sw_repo_password']
    raise "No password found for software repo user in chef vault \'#{chef_vault}\'" if sw_repo_password.empty?
    Chef::Log.info "Found a password for software repo user in chef vault \'#{chef_vault}\'"
  end
  sw_repo_password
end
