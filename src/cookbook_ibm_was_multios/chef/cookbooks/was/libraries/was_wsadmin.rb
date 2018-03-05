# Cookbook Name:: was
# Library:: was_wsadmin
#
# Copyright IBM Corp. 2016, 2017
#

# <> library: WAS wsadmin
# <> Library Functions for the WAS Cookbook
module WASWsadmin
  # Helper functions for WAS cookbook
  include Chef::Mixin::ShellOut

  def create_wsadmin_library(temp_dir)
    libs = [ 'wsadminlib.py' ]
    libs.each do |p|
      cookbook_file p.to_s do
        cookbook 'was'
        path "#{temp_dir}/#{p}"
        sensitive true
        action :create
      end
    end
  end


  def run_jython(os_user, profile_path, _tmp, dmgr_host, dmgr_soap_port, admin_user, admin_pwd, jython_file)
    security_credentials = if admin_user.nil?
      ""
                           else
      "-user '#{admin_user}' -password '#{admin_pwd}'"
                           end

    dmgr_connection_string = if dmgr_host.nil?
      ""
                             else
      "-conntype SOAP -host '#{dmgr_host}' -port '#{dmgr_soap_port}'"
                             end

    wsadmin_cmd = if RUBY_PLATFORM !~ /win|mingw/
      shell_out!(%Q[ su - #{os_user} -c "#{profile_path}/bin/wsadmin.sh -lang jython -f #{jython_file} #{dmgr_connection_string} #{security_credentials}" ])
                  else
      #TODO test windows wsadmin invocation
      shell_out!(%Q[ #{profile_path}\bin\wsadmin.bat -lang jython -f #{jython_file} #{dmgr_connection_string} #{security_credentials} ])
                  end
    wsadmin_cmd.stdout
  end

  def run_jython_block(os_user, profile_path, admin_user, admin_pwd, jython)
    #add credentials to soap.client.props and enable soap security
    temp_dir= node['ibm']['temp_dir'].to_s
    dmgr_host= node['was']['dmgr_host_name'].to_s
    if dmgr_host == '' || dmgr_host.empty? || dmgr_host.nil?
      dmgr_host = chef_searchhostname(node['was']['dmgr_role_name'])
      Chef::Log.info("#{dmgr_host} dmgr derived from chefsearch")
    end
    dmgr_soap_port= node['was']['profiles']['dmgr']['ports']['SOAP_CONNECTOR_ADDRESS']
    Chef::Log.info("was dmgr port:#{dmgr_soap_port}")
    run_jython(os_user, profile_path, temp_dir, dmgr_host, dmgr_soap_port, admin_user, admin_pwd, "#{temp_dir}/#{jython}")
  end

  def run_jython_block_standalone(os_user, profile_path, admin_user, admin_pwd, jython)
    temp_dir= node['ibm']['temp_dir'].to_s
    standalone_host= was_tags(node['was']['profiles']['standalone_profiles']['standalone1']['host'].to_s)
    standalone_soap_port= node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SOAP_CONNECTOR_ADDRESS']
    Chef::Log.info("WAS standalone port:#{standalone_soap_port}")
    run_jython(os_user, profile_path, temp_dir, standalone_host, standalone_soap_port, admin_user, admin_pwd, "#{temp_dir}/#{jython}")
  end
end

Chef::Recipe.send(:include, WASWsadmin)
Chef::Resource.send(:include, WASWsadmin)
