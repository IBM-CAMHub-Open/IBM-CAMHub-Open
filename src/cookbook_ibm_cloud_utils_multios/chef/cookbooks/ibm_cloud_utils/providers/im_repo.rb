#
# Cookbook Name:: ibm_cloud_utils
# Provider:: im_repo
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
  im_repo_user = new_resource.im_repo_user if new_resource.secure_repo == "true"
  im_repo_password = define_im_repo_password if new_resource.secure_repo == "true"

  uri = URI.parse(new_resource.repository)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if new_resource.repository.include? "https"
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE if new_resource.im_repo_self_signed_cert == "true"

  get_im_repo_details = Net::HTTP::Get.new(uri.request_uri + '/repository.config')
  get_im_repo_details.basic_auth(im_repo_user, im_repo_password) if new_resource.secure_repo == "true"
  begin
    config = http.request(get_im_repo_details)
  rescue OpenSSL::SSL::SSLError
    raise "ERROR: Self signed certificate detected when trying to access #{new_resource.repository}. Please use im_repo_self_signed_cert == \"true\" "
  end
  case config.code
  when "200"
    print "\n PASS: IM Repository #{new_resource.repository} configured \n"
    im_repo_type = if /LayoutPolicy=P1/ =~ config.body
                     'simple'
                   elsif /LayoutPolicy=Composite/ =~ config.body
                     'composite'
                   else
                     print "\n Warning: Unknown IM repository type\n"
                   end
    if im_repo_type == 'composite'
      repo_dirs = []
      config.body.each_line do |line|
        repo_dirs.push(line.split('=./')[1].chomp) if line =~ /^repository.url/
      end
    end
  when "400"
    raise "\n ERROR: #{config.code} Bad Request. The request could not be understood by the server due to malformed syntax. \n"
  when "401"
    raise "\n ERROR: #{config.code} Unauthorized. The request requires user authentication. \n"
  when "404"
    raise "\n ERROR: IM Repository #{new_resource.repository} not configured \n"
  end

  case im_repo_type
  when 'simple'
    request = if new_resource.offering_version.nil?
                Net::HTTP::Get.new(uri.request_uri + '/Offerings/')
              else
                Net::HTTP::Head.new(uri.request_uri + '/Offerings/' + new_resource.offering_id + '_' + new_resource.offering_version + '.jar')
              end
    request.basic_auth(im_repo_user, im_repo_password) if new_resource.secure_repo == "true"
    begin
      res = http.request(request)
    rescue OpenSSL::SSL::SSLError
      raise "ERROR: Self signed certificate detected when trying to access #{new_resource.repository}. Please use im_repo_self_signed_cert == \"true\" "
    end
    if new_resource.offering_version.nil?
      raise "\n ERROR: Package #{new_resource.offering_id} not found in #{new_resource.repository} \n" unless /#{new_resource.offering_id}/ =~ res.body
      print "\n PASS: At least one package #{new_resource.offering_id} found in #{new_resource.repository} \n"
    else
      case res.code
      when "200"
        print "\n PASS: Package #{new_resource.offering_id}_#{new_resource.offering_version} found in #{new_resource.repository} \n"
      when "400"
        raise "\n ERROR: #{res.code} Bad Request. The request could not be understood by the server due to malformed syntax. \n"
      when "401"
        raise "\n ERROR: #{res.code} Unauthorized. The request requires user authentication. \n"
      when "404"
        raise "\n ERROR: Package #{new_resource.offering_id}_#{new_resource.offering_version} not found in #{new_resource.repository} \n"
      end
    end
  when 'composite'
    found = "false"
    repo_dirs.each do |im_repo_path|
      request = if new_resource.offering_version.nil?
                  Net::HTTP::Get.new(uri.request_uri + '/' + im_repo_path + '/Offerings/')
                else
                  Net::HTTP::Head.new(uri.request_uri + '/' + im_repo_path + '/Offerings/' + new_resource.offering_id + '_' + new_resource.offering_version + '.jar')
                end
      request.basic_auth(im_repo_user, im_repo_password) if new_resource.secure_repo == "true"
      begin
        res = http.request(request)
      rescue OpenSSL::SSL::SSLError
        raise "ERROR: Self signed certificate detected when trying to access #{new_resource.repository}. Please use im_repo_self_signed_cert == \"true\" "
      end
      if new_resource.offering_version.nil?
        if /#{new_resource.offering_id}/ =~ res.body
          print "\n PASS: At least one package #{new_resource.offering_id} found in #{new_resource.repository} \n"
          found = "true"
          break
        end
      else
        case res.code
        when "200"
          print "\n PASS: Package #{new_resource.offering_id}_#{new_resource.offering_version} found in #{new_resource.repository} \n"
          found = "true"
          break
        when "400"
          raise "\n ERROR: #{res.code} Bad Request. The request could not be understood by the server due to malformed syntax. \n"
        when "401"
          raise "\n ERROR: #{res.code} Unauthorized. The request requires user authentication. \n"
        when "404"
          found = "false"
        end
      end
    end
    raise "\n ERROR: Package #{new_resource.offering_id} not found in #{new_resource.repository} \n" if found == "false"
  end
  new_resource.updated_by_last_action(true)
end

def define_im_repo_password
  im_repo_password = ''
  encrypted_id = node['ibm_internal']['vault']['item']
  chef_vault = node['ibm_internal']['vault']['name']
  unless chef_vault.empty?
    require 'chef-vault'
    im_repo_password = chef_vault_item(chef_vault, encrypted_id)['ibm']['im_repo_password']
    raise "No password found for IM repo user in chef vault \'#{chef_vault}\'" if im_repo_password.empty?
    Chef::Log.info "Found a password for IM repo user in chef vault \'#{chef_vault}\'"
  end
  im_repo_password
end
