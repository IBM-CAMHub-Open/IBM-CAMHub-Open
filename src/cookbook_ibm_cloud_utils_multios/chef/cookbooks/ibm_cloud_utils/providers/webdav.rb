#
# Cookbook Name:: ibm_cloud_utils
# Provider:: webdav
#
# Copyright IBM Corp. 2017, 2017
#

use_inline_resources

def whyrun_supported?
  true
end

action :download do
  require 'net/http'
  require 'openssl'
  repo_user = new_resource.sw_repo_user if new_resource.secure_repo == "true"
  repo_password = define_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.webdav_server)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.webdav_server.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.sw_repo_self_signed_cert == "true"

  download = Net::HTTP::Get.new(uri.request_uri + '/' + new_resource.collection + '/'+ new_resource.file)
  download.basic_auth(repo_user, repo_password) if new_resource.secure_repo == "true"
  begin
    f = http.request(download)
  rescue OpenSSL::SSL::SSLError
    raise "ERROR: Self signed certificate detected when trying to access #{new_resource.webdav_server}. Please use sw_repo_self_signed_cert == \"true\" "
  end
  case f.code
  when "200"
    Chef::Log.info "Found file: #{new_resource.file}"
    downloaded_file = open(new_resource.download_path + '/' + new_resource.file, 'w')
    downloaded_file.write(f.body)
    downloaded_file.close
    Chef::Log.info "File #{new_resource.file} downloaded to #{new_resource.download_path}"
  when "400"
    raise "\n ERROR: #{f.code} Bad Request. The request could not be understood by the server due to malformed syntax. \n"
  when "401"
    raise "\n ERROR: #{f.code} Unauthorized. The request requires user authentication. \n"
  when "404"
    raise "\n ERROR: File not found: #{new_resource.file} \n"
  end
  new_resource.updated_by_last_action(true)
end

action :upload do
  require 'net/http'
  require 'openssl'

  repo_user = new_resource.sw_repo_user if new_resource.secure_repo == "true"
  repo_password = define_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.webdav_server + '/' + new_resource.collection + '/' + new_resource.file)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.webdav_server.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.sw_repo_self_signed_cert == "true"
  upload = Net::HTTP::Put.new(uri)

  upload.basic_auth(repo_user, repo_password) if new_resource.secure_repo == "true"
  http.request(upload, ::File.read(new_resource.source_path + '/' + new_resource.file))
  Chef::Log.info "Uploaded file: #{new_resource.file} to #{new_resource.webdav_server}/#{new_resource.collection}/ "
  new_resource.updated_by_last_action(true)
end

action :delete do
  require 'net/http'
  require 'openssl'
  repo_user = new_resource.sw_repo_user if new_resource.secure_repo == "true"
  repo_password = define_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.webdav_server + '/' + new_resource.collection + '/' + new_resource.file)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.webdav_server.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.sw_repo_self_signed_cert == "true"

  delete_file = Net::HTTP::Delete.new(uri)
  delete_file.basic_auth(repo_user, repo_password) if new_resource.secure_repo == "true"
  http.request(delete_file)
  Chef::Log.info "Deleted file: #{new_resource.file} from #{new_resource.webdav_server}/#{new_resource.collection}/ "
  new_resource.updated_by_last_action(true)
end

action :create_collection do
  require 'net/http'
  require 'openssl'
  repo_user = new_resource.sw_repo_user if new_resource.secure_repo == "true"
  repo_password = define_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.webdav_server + '/' + new_resource.collection + '/')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.webdav_server.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.sw_repo_self_signed_cert == "true"

  new_collection = Net::HTTP::Mkcol.new(uri)
  new_collection.basic_auth(repo_user, repo_password) if new_resource.secure_repo == "true"
  http.request(new_collection)
  Chef::Log.info "Collection #{new_resource.collection} created in #{new_resource.webdav_server}/ "
  new_resource.updated_by_last_action(true)
end

action :delete_collection do
  require 'net/http'
  require 'openssl'
  repo_user = new_resource.sw_repo_user if new_resource.secure_repo == "true"
  repo_password = define_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.webdav_server + '/' + new_resource.collection + '/')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.webdav_server.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.sw_repo_self_signed_cert == "true"

  old_collection = Net::HTTP::Delete.new(uri)
  old_collection.basic_auth(repo_user, repo_password) if new_resource.secure_repo == "true"
  http.request(old_collection)
  Chef::Log.info "Collection #{new_resource.collection} deleted from #{new_resource.webdav_server}/ "
  new_resource.updated_by_last_action(true)
end

def define_repo_password
  repo_password = ''
  encrypted_id = node['ibm_internal']['vault']['item']
  chef_vault = node['ibm_internal']['vault']['name']
  unless chef_vault.empty?
    require 'chef-vault'
    repo_password = chef_vault_item(chef_vault, encrypted_id)['ibm']['sw_repo_password']
    raise "No password found for repo user in chef vault \'#{chef_vault}\'" if repo_password.empty?
    Chef::Log.debug "Found a password for repo user in chef vault \'#{chef_vault}\'"
  end
  repo_password
end
