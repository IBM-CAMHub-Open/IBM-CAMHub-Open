# Cookbook Name:: was
# Library:: was_profiles
#
# Copyright IBM Corp. 2016, 2017
#
# <> library: WAS Profiles
# <> Library Functions for the WAS Cookbook
module WASProfiles
  # Helper functions for WAS cookbook
  include Chef::Mixin::ShellOut

  def encrypt_soap_client_props(profile_name, admin_user_pwd)
    expand_area = node['was']['expand_area']
    validatestring = "xor"
    #prepare template for creating XORed WAS passwords
    template "#{expand_area}/was_xor_pwd.sh" do
        source "was_xor_pwd.sh.erb"
        mode '0770'
        variables(
        :INSTALL_LOCATION => (node['was']['install_dir']).to_s
        )
    end

    #encrypt WAS admin user password
    execute "xor_db_pwd" do
        cwd expand_area
        sensitive true
        command %Q[ ./was_xor_pwd.sh '#{admin_user_pwd}' > #{expand_area}/adminpwd.pwd ]
        not_if { File.readlines("#{node['was']['profile_dir']}/#{profile_name}/properties/soap.client.props").grep(/#{validatestring}/).any? }
    end
    # creates "#{node['ibm']['expand_area']}/adminpwd.pwd"
    modify_soap_client_props(profile_name, expand_area)

    file "#{expand_area}/adminpwd.pwd" do
      action :delete
      only_if { File.exist?("#{expand_area}/adminpwd.pwd") }
    end
  end

  #Chef::Util::FileEdit.new("#{node['was']['profile_dir']}/#{node['was']['profiles']['dmgr']['profile']}/properties/soap.client.props")

  def modify_soap_client_props(profile_name, expand_area)
    #add credentials to soap.client.props and enable soap security
    ruby_block "modify_soap.client.props" do
      block do
        file = Chef::Util::FileEdit.new("#{node['was']['profile_dir']}/#{profile_name}/properties/soap.client.props")
        file.search_file_replace_line(/^com.ibm.SOAP.securityEnabled=false/, "com.ibm.SOAP.securityEnabled=true")
        file.search_file_replace_line(/^com.ibm.SOAP.loginUserid=$/, "com.ibm.SOAP.loginUserid=#{node['was']['security']['admin_user']}")
        file.search_file_replace_line(/^com.ibm.SOAP.loginPassword=$/, "com.ibm.SOAP.loginPassword=" + File.open("#{expand_area}/adminpwd.pwd").readlines.join.chomp) # ~password_checker
        file.write_file
      end
      only_if { File.exist?("#{expand_area}/adminpwd.pwd") }
      only_if { File.exist?("#{node['was']['profile_dir']}/#{profile_name}/properties/soap.client.props") }
    end
  end

  def execute_manage_profile(response_file, profile_name)
    cmd = "./manageprofiles.sh -response #{response_file}"
    # Chef 12+ problem with OS detection. Replacing C.UTF-8 with en_US"
    cmd = "export LANG=en_US; export LANGUAGE=en_US\:; export LC_ALL=en_US; ./manageprofiles.sh -response #{response_file}" if (node['platform_family'] == "debian") && (response_file.include? "dmgr.rsp")
    execute "create_profile" do
      cwd "#{node['was']['install_dir']}/bin"
      command cmd
      user node['was']['os_users']['was']['name']
      group node['was']['os_users']['was']['gid']
      not_if { File.exist?("#{node['was']['profile_dir']}/#{profile_name}") }
    end
  end

  def create_server_init(profile_name, service_name, server_name)
    template "/etc/init.d/#{service_name}_was.init" do
        source "server.init.erb"
        mode '0770'
        owner 'root'
        group 'root'
        variables(
        :SERVERNAME => server_name,
        :PROFILEPATH => "#{node['was']['profile_dir']}/#{profile_name}",
        :INSTALL_LOCATION => (node['was']['install_dir']).to_s,
        :SERVICENAME => service_name,
        :USERNAME => (node['was']['os_users']['was']['name']).to_s
        )
    end
  end
end
Chef::Recipe.send(:include, WASProfiles)
Chef::Resource.send(:include, WASProfiles)
