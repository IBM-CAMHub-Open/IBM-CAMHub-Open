#
# Cookbook Name:: im
# Provider:: im_install
#
# Copyright IBM Corp. 2016, 2017
#
include IM::Helper
use_inline_resources

action :install do
  if @current_resource.installed
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  elsif @current_resource.im_installed
    converge_by("Install #{@new_resource}") do
      check_install_mode_value
      im_install_dir = define_im_install_dir
      im_shared_dir = define_im_shared_dir
      im_repo = define_im_repo
      user = define_user
      group = define_group
      if new_resource.im_repo_user.nil?
        Chef::Log.info "im_repo_user not provided. Please make sure your IM repo is not secured. If your IM repo is secured you must provide im_repo_user and configure your chef vault for password"
      else
        generate_storage_file
      end
      security_params = define_security_params

      long_offering_version = im_isavailable?(im_install_dir, im_repo, security_params, new_resource.offering_id + '_' + new_resource.offering_version, user).last.to_s
      long_java_offering_version = if new_resource.install_java == "true"
                                     im_isavailable?(im_install_dir, im_repo, security_params, new_resource.java_offering_id + '_' + new_resource.java_offering_version, user).last.to_s
                                   end
      silent_install_file="#{im_install_dir}/#{new_resource.offering_id}_#{new_resource.response_file}"
      template silent_install_file do
        source new_resource.response_file + '.erb'
        variables(
          :REPO_LOCATION => im_repo,
          :FEATURE_LIST => new_resource.feature_list,
          :INSTALL_LOCATION => new_resource.install_dir,
          :OFFERING_ID => new_resource.offering_id,
          :OFFERING_VERSION => long_offering_version,
          :PROFILE_ID => new_resource.profile_id,
          :IMSHARED => im_shared_dir,
          :INSTALL_JAVA => new_resource.install_java,
          :JAVA_OFFERING_ID => new_resource.java_offering_id,
          :JAVA_OFFERING_VERSION => long_java_offering_version,
          :JAVA_FEATURE_LIST => new_resource.java_feature_list,
          :IM_REPO_NONSECUREMODE => new_resource.im_repo_nonsecureMode
        )
      end

      install_command = "./imcl input #{silent_install_file} #{security_params} -showProgress -accessRights #{new_resource.im_install_mode} -acceptLicense -log #{new_resource.log_dir}/#{new_resource.offering_id}.install.log"

      execute "install #{new_resource.name}" do
        user user
        group group
        cwd im_install_dir + '/eclipse/tools'
        command install_command
        not_if { ibm_installed?(new_resource.install_dir, new_resource.offering_id, new_resource.offering_version, user) }
      end

      ["/tmp/master_password_file.txt", "/tmp/credential.store"].each do |dir|
        file dir do
          action :delete
        end
      end
    end
  else
    user = define_user
    Chef::Log.fatal "Installation manager is not installed for user #{user}. Please use :install_im and :upgrade_im actions to install and upgrade IM"
    raise "Installation manager is not installed for user #{user}. Please use :install_im and :upgrade_im actions to install and upgrade IM"
  end
end


#Create Action install
action :install_im do
  if @current_resource.im_installed
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Install #{@new_resource}") do
      check_install_mode_value
      environment_check
      im_install_dir = define_im_install_dir
      im_data_dir = define_im_data_dir
      im_shared_dir = define_im_shared_dir
      im_folder_permission = define_im_folder_permission
      user = define_user
      group = define_group

      im_log_dir = node['ibm']['log_dir'] + '/im'
      im_evidence_dir = node['ibm']['evidence_path']
      im_expand_area = node['im']['expand_area']
      im_archive_names = node['im']['archive_names']
      sw_repo = node['ibm']['sw_repo']
      sw_repo_path = node['im']['sw_repo_path']
      repo_paths = sw_repo + sw_repo_path
      evidence_tar = node['ibm']['evidence_zip']
      evidence_log = "#{cookbook_name}-#{node['hostname']}.log"

      # Validation Test Cases

      case @new_resource.im_install_mode
      when 'admin'
        if user != 'root'
          Chef::Log.fatal "Admin Verification 1: Installation Manager Admin role must be executed as root"
          raise "Admin Verification 1: Installation Manager Admin role must be executed as root"
        end
      when 'nonAdmin'
        if user == 'root'
          Chef::Log.fatal "Non-Admin Verification 1: Installation Manager Non-Admin role must NOT be executed as root"
          raise "Non-Admin Verification 1: Installation Manager Non-Admin role must NOT be executed as root"
        end
        unless im_install_dir.include? "/home/#{user}"
          Chef::Log.fatal "Non-Admin Verification 2: Installation Manager Non-Admin role must installed under the /home directory"
          raise "Non-Admin Verification 2: Installation Manager Non-Admin role must installed under the /home directory"
        end
      when 'group'
        if user == 'root'
          Chef::Log.fatal "Group Verification 1: Installation Manager Group role must NOT be executed as root"
          raise "Group Verification 1: Installation Manager Group role must NOT be executed as root"
        end
        unless im_install_dir.include? "/home/#{user}"
          Chef::Log.fatal "Group Verification 2: Installation Manager Group role must installed under the /home directory"
          raise "Group Verification 2: Installation Manager Group role must installed under the /home directory"
        end
      else
        Chef::Log.fatal "Install Mode Verification 1: Installation Manager role must be admin / nonAdmin or group"
        raise "Install Mode Verification 1: Installation Manager role must be admin / nonAdmin or group"
      end

      # Create the folders needed
      [im_log_dir, im_evidence_dir].each do |dir|
        directory dir do
          recursive true
          action :create
          mode im_folder_permission
          owner user
          group group
        end
      end

      # Download and extract binaries
      case node['platform_family']
      when 'debian'
        apt_update 'update' do
          action :update
        end
      end
      package 'unzip'

      raise "Package for IM version #{new_resource.version} not included in ['im']['archive_names'] hash in internal.rb file" unless im_archive_names.keys.find { |k| k.include? new_resource.version }

      im_archive_names.each_pair do |p, v|
        next if p.to_s != new_resource.version
        filename = v['filename']
        sha256 = v['sha256']
        Chef::Log.info("Unpacking #{filename}...")

        ibm_cloud_utils_unpack "unpack-#{filename}" do
          source "#{repo_paths}/#{filename}"
          target_dir im_expand_area
          mode im_folder_permission
          checksum sha256
          owner user
          group group
          mode im_folder_permission
          remove_local true
          secure_repo new_resource.secure_repo
          vault_name node['im']['vault']['name']
          vault_item node['im']['vault']['encrypted_id']
          repo_self_signed_cert new_resource.repo_nonsecureMode
          not_if { im_installed?(im_install_dir, new_resource.version, user) }
        end
      end

      # Run the install - With im_shared_dir set (Above V1.8)
      execute "installim_#{new_resource.name}" do
        cwd "#{im_expand_area}/tools"
        command %( ./imcl install com.ibm.cic.agent -repositories #{im_expand_area} -installationDirectory #{im_install_dir}/eclipse -accessRights #{new_resource.im_install_mode} -acceptLicense -dataLocation #{im_data_dir} -sharedResourcesDirectory #{im_shared_dir} -log #{im_log_dir}/IM.install.log)
        user user
        group group
        not_if { im_installed?(im_install_dir, new_resource.version, user) }
      end

      if new_resource.im_repo_nonsecureMode == "true" && new_resource.im_install_mode == "group"
        import_self_signed_certificate
      end

      # Run validation script
      execute 'Verify IM installation' do
        user user
        group group
        command "#{im_install_dir}/eclipse/tools/imcl version >> #{im_log_dir}/#{evidence_log}"
        only_if { Dir.glob("#{im_evidence_dir}/#{cookbook_name}*.tar").empty? }
      end

      # Tar logs
      ibm_cloud_utils_tar "Create_#{evidence_tar}" do
        source "#{im_log_dir}/#{evidence_log}"
        target_tar evidence_tar
        only_if { Dir.glob("#{im_evidence_dir}/#{cookbook_name}*.tar").empty? }
      end

      # Cleanup expand area
      Chef::Log.info("Cleanup #{im_expand_area} \n")
      directory im_expand_area do
        recursive true
        action :delete
      end
    end
  end
end

#Create Action upgrade
action :upgrade_im do
  if @current_resource.fp_installed
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  else
    converge_by("Install #{@new_resource}") do
      check_install_mode_value
      im_install_dir = define_im_install_dir
      user = define_user
      group = define_group
      if new_resource.im_repo_user.nil?
        Chef::Log.info "im_repo_user not provided. Please make sure your IM repo is not secured. If your IM repo is secured you must provide im_repo_user and configure your chef vault for password"
      else
        generate_storage_file
      end
      security_params = define_security_params
      im_log_dir = node['ibm']['log_dir'] + '/im'
      im_fixpack_offering_id = node['im']['fixpack_offering_id']
      im_repo = define_im_repo
      preferences = if security_params == ''
                      "-preferences offering.service.repositories.areUsed=false"
                    else
                      "#{security_params},offering.service.repositories.areUsed=false"
                    end
      execute "installim_fixpack_#{new_resource.name}" do # Install the latest available fixpack from the IMRepo. Installing a specific version of IM fixpack is not supported by imcl tool.
        cwd "#{im_install_dir}/eclipse/tools"
        command %( ./imcl install #{im_fixpack_offering_id} -repositories #{im_repo} #{preferences} -log #{im_log_dir}/IM.Fixpack.install.log)
        user user
        group group
        not_if { im_fixpack_installed?(im_install_dir, im_repo, security_params, im_fixpack_offering_id, user) }
      end
      ["/tmp/master_password_file.txt", "/tmp/credential.store"].each do |dir|
        file dir do
          action :delete
        end
      end
    end
  end
end

#Override Load Current Resource
def load_current_resource
  Chef.event_handler do
    on :run_failed do
      HandlerSensitiveFiles::Helper.new.remove_sensitive_files_on_run_failure
    end
  end
  im_install_dir = define_im_install_dir
  im_repo = define_im_repo
  user = define_user
  if new_resource.im_repo_user.nil?
    Chef::Log.info "im_repo_user not provided. Please make sure your IM repo is not secured.If your IM repo is secured you must provide im_repo_user and configure your chef vault for password"
  elsif im_installed?(im_install_dir, @new_resource.version, user)
    generate_storage_file
  end
  security_params = define_security_params

  @current_resource = Chef::Resource::ImInstall.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.user(user)
  @current_resource.version(@new_resource.version)
  @current_resource.im_install_dir(im_install_dir)
  @current_resource.offering_id(@new_resource.offering_id)
  @current_resource.offering_version(@new_resource.offering_version)

  #Get current state
  @current_resource.im_installed = im_installed?(im_install_dir, @new_resource.version, user)
  @current_resource.fp_installed = im_fixpack_installed?(im_install_dir, im_repo, security_params, node['im']['fixpack_offering_id'] + '_' + @new_resource.version, user)
  @current_resource.installed = ibm_installed?(im_install_dir, @new_resource.offering_id, @new_resource.offering_version, user)
  remove_storage_file
end

def check_install_mode_value
  if new_resource.im_install_mode == 'admin' || new_resource.im_install_mode == 'nonAdmin' || new_resource.im_install_mode == 'group'
    Chef::Log.info("install_mode attribute has an allowed value. Install mode is #{new_resource.im_install_mode}")
  else
    Chef::Log.fatal "Please make sure you have the right value for im_install_mode attribute. It should be admin, nonAdmin or group!!"
    raise "Please make sure you have the right value for im_install_mode attribute. It should be admin, nonAdmin or group!!"
  end
end

def define_im_install_dir
  user = define_user
  case new_resource.im_install_mode
  when 'admin'
    im_install_dir = if new_resource.im_install_dir.nil?
                       '/opt/IBM/InstallationManager'
                     else
                       new_resource.im_install_dir
                     end
    im_install_dir
  when 'nonAdmin'
    im_install_dir = if new_resource.im_install_dir.nil?
                       '/home/' + user + '/IBM/InstallationManager'
                     else
                       new_resource.im_install_dir
                     end
    im_install_dir
  when 'group'
    im_install_dir = if new_resource.im_install_dir.nil?
                       '/home/' + user + '/IBM/InstallationManager_Group'
                     else
                       new_resource.im_install_dir
                     end
    im_install_dir
  end
end

def define_im_data_dir
  user = define_user
  case new_resource.im_install_mode
  when 'admin'
    im_data_dir = if new_resource.im_data_dir.nil?
                    '/var/ibm/InstallationManager'
                  else
                    new_resource.im_data_dir
                  end
    im_data_dir
  when 'nonAdmin'
    im_data_dir = if new_resource.im_data_dir.nil?
                    '/home/' + user + '/var/ibm/InstallationManager'
                  else
                    new_resource.im_data_dir
                  end
    im_data_dir
  when 'group'
    im_data_dir = if new_resource.im_data_dir.nil?
                    '/home/' + user + '/var/ibm/InstallationManager_Group'
                  else
                    new_resource.im_data_dir
                  end
    im_data_dir
  end
end

def define_im_shared_dir
  user = define_user
  case new_resource.im_install_mode
  when 'admin'
    im_shared_dir = if new_resource.im_shared_dir.nil?
                      '/opt/IBM/IMShared'
                    else
                      new_resource.im_shared_dir
                    end
    im_shared_dir
  when 'nonAdmin', 'group'
    im_shared_dir = if new_resource.im_shared_dir.nil?
                      '/home/' + user + '/opt/IBM/IMShared'
                    else
                      new_resource.im_shared_dir
                    end
    im_shared_dir
  end
end

def define_im_folder_permission
  case new_resource.im_install_mode
  when 'admin'
    im_folder_permission = '755'
    im_folder_permission
  when 'nonAdmin', 'group'
    im_folder_permission = '775'
    im_folder_permission
  end
end

def define_user
  case new_resource.im_install_mode
  when 'admin'
    user = if new_resource.user.nil?
             'root'
           else
             new_resource.user
           end
    user
  when 'nonAdmin', 'group'
    user = if new_resource.user.nil?
             Chef::Log.fatal "User Name not provided! Please provide the user that should be used to install your product"
             raise "User Name not provided! Please provide the user that should be used to install your product"
           else
             unless im_user_exists_unix?(new_resource.user)
               Chef::Log.fatal "User Name provided #{new_resource.user}, does not exist"
               raise "User Verification 1: User Name provided #{new_resource.user}, does not exist"
             end
             new_resource.user
           end
    user
  end
end

def define_group
  case new_resource.im_install_mode
  when 'admin'
    group = if new_resource.group.nil?
              node['root_group']
            else
              new_resource.group
            end
    group
  when 'nonAdmin', 'group'
    group = if new_resource.group.nil?
              Chef::Log.fatal "Group not provided! Please provide the group that should be used to install your product"
              raise "Group not provided! Please provide the group that should be used to install your product"
            else
              new_resource.group
            end
    group
  end
end

def define_im_repo
  if new_resource.im_repo_nonsecureMode == "true" && new_resource.im_install_mode == "group"
    require 'net/http'
    uri = URI.parse(new_resource.repositories)
    download_self_signed_certificate
    new_host = self_signed_certificate_name
    im_repo = new_resource.repositories.gsub(uri.host, new_host.chomp)
  else
    im_repo = new_resource.repositories
  end
  im_repo
end

def define_security_params
  security_params = if new_resource.im_repo_user.nil?
                      ''
                    else
                      "-secureStorageFile /tmp/credential.store -masterPasswordFile /tmp/master_password_file.txt -preferences com.ibm.cic.common.core.preferences.ssl.nonsecureMode=#{new_resource.im_repo_nonsecureMode}"
                    end
  security_params
end

def define_im_repo_password
  im_repo_password = ''
  encrypted_id = node['im']['vault']['encrypted_id']
  chef_vault = node['im']['vault']['name']
  unless chef_vault.empty?
    require 'chef-vault'
    im_repo_password = chef_vault_item(chef_vault, encrypted_id)['ibm']['im_repo_password']
    raise "No password found for IM repo user in chef vault \'#{chef_vault}\'" if im_repo_password.empty?
    Chef::Log.info "Found a password for IM repo user in chef vault \'#{chef_vault}\'"
  end
  im_repo_password
end

def generate_storage_file
  im_repo = define_im_repo
  require 'securerandom'
  im_install_dir = define_im_install_dir
  user = define_user
  group = define_group
  im_repo_password = define_im_repo_password
  if ::File.exist?('/tmp/master_password_file.txt')
    Chef::Log.info("/tmp/master_password_file.txt exists. It will not be modified")
  else
    master_password_file = open('/tmp/master_password_file.txt', 'w')
    FileUtils.chown user, group, '/tmp/master_password_file.txt'
    master_password_file.write(SecureRandom.hex)
    master_password_file.close
  end
  if ::File.exist?('/tmp/credential.store')
    Chef::Log.info("/tmp/credential.store exists. It will not be modified")
  else
    cmd = "#{im_install_dir}/eclipse/tools/imutilsc saveCredential -url #{im_repo}/repository.xml -userName #{new_resource.im_repo_user} -userPassword \'#{im_repo_password}\' -secureStorageFile /tmp/credential.store -masterPasswordFile /tmp/master_password_file.txt -preferences com.ibm.cic.common.core.preferences.ssl.nonsecureMode=#{new_resource.im_repo_nonsecureMode} || true"
    cmd_out = run_shell_cmd(cmd, user)
    cmd_out.stderr.empty? && (cmd_out.stdout =~ /^Successfully saved the credential to the secure storage file./)
  end
end

def remove_storage_file
  FileUtils.rm("/tmp/master_password_file.txt") if ::File.exist?('/tmp/master_password_file.txt')
  FileUtils.rm("/tmp/credential.store") if ::File.exist?('/tmp/credential.store')
end

def environment_check
  im_install_dir = define_im_install_dir
  dirs = { '/' => 500,
           '/tmp' => 10,
           im_install_dir => 500,
           node['ibm']['temp_dir'] => 500 }
  dirs.each_pair do |dir, size|
    ibm_cloud_utils_freespace "check-freespace-for-#{dir}-directory" do
      path dir
      required_space size
      continue true
      action :check
      error_message "Please make sure you have at least #{size}MB free space under #{dir}"
    end
  end
end

def import_self_signed_certificate
  Chef::Resource::RubyBlock.send(:include, IM::Helper)
  im_install_dir = define_im_install_dir
  user = define_user
  ruby_block "import_self_signed_certificate_#{new_resource}" do
    block do
      download_self_signed_certificate
      imutilsc = open(im_install_dir + '/eclipse/tools/imutilsc.ini', 'r')
      java_path = imutilsc.find { |line| line =~ /java/ }
      jre_bin_path = java_path.match("/java").pre_match
      shell_out!("cd #{jre_bin_path}; ./keytool -import -trustcacerts -keystore ../lib/security/cacerts -storepass changeit -noprompt -alias securerepo -file /tmp/secure-repo.pem || true")
    end
    only_if { im_installed?(im_install_dir, new_resource.version, user) }
  end
end

def download_self_signed_certificate
  require 'net/http'
  require 'socket'
  require 'openssl'
  if ::File.exist?('/tmp/secure-repo.pem')
    Chef::Log.info("/tmp/secure-repo.pem exists. It will not be downloaded again")
  else
    uri = URI.parse(new_resource.repositories)
    tcp_client = TCPSocket.new(uri.host, uri.port)
    ssl_client = OpenSSL::SSL::SSLSocket.new(tcp_client)
    ssl_client.connect
    cert = OpenSSL::X509::Certificate.new(ssl_client.peer_cert)
    cert_file = open('/tmp/secure-repo.pem', 'w+')
    if cert_file.include? cert.to_pem
      Chef::Log.info "Self signed cert found in #{cert_file}"
    else
      cert_file.write(cert)
    end
    cert_file.close
  end
end

def self_signed_certificate_name
  require 'net/http'
  require 'socket'
  require 'openssl'
  uri = URI.parse(new_resource.repositories)
  tcp_client = TCPSocket.new(uri.host, uri.port)
  ssl_client = OpenSSL::SSL::SSLSocket.new(tcp_client)
  ssl_client.connect
  cert = OpenSSL::X509::Certificate.new(ssl_client.peer_cert)
  cert_name = cert.subject.to_a.find { |name, _, _| name == 'CN' }[1]
  etc_hosts = open('/etc/hosts', 'a+')
  if etc_hosts.include? "#{uri.host} #{cert_name}"
    Chef::Log.info "line #{uri.host} #{cert_name} found in /etc/hosts"
  else
    etc_hosts.write("#{uri.host} #{cert_name}")
  end
  etc_hosts.close
  cert_name
end
