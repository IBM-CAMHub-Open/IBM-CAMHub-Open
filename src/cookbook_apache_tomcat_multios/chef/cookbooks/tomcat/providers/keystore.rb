#
# Cookbook Name:: tomcat
# Provider:: keystore.rb
#
# Copyright IBM Corp. 2016, 2017
#

use_inline_resources

def run_cmd(cmd)
  Mixlib::ShellOut.new(cmd).run_command.exitstatus == 0
end

action :create do
  java_vendor = new_resource.java_vendor
  java_home = new_resource.java_home
  owner = new_resource.owner
  group = new_resource.group
  keystore_pass = new_resource.keystore_pass
  keystore = new_resource.keystore
  keystore_type = new_resource.keystore_type
  keystore_alg = new_resource.keystore_alg
  cert = new_resource.cert_data
  cn = if cert['cn'] == 'default'
         node['fqdn']
       else
         cert['cn']
       end
  keytool = if java_vendor == 'openjdk'
              ::File.dirname(::File.dirname(::File.realpath('/usr/bin/java'))) + '/bin/keytool'
            else
              java_home + '/bin/keytool'
            end

  raise "keytool utility #{keytool} could not be found." unless ::File.exist?(keytool)
  if Mixlib::ShellOut.new("#{keytool} -list -keystore #{keystore} -storepass #{keystore_pass}").run_command.exitstatus == 0
    Chef::Log.info "#{keystore} is up to date."
  else
    ::File.delete(keystore) if ::File.exist?(keystore)
    cmd = "#{keytool} -genkeypair \
            -dname \"CN=#{cn}, OU=#{cert['ou']}, O=#{cert['o']}, L=#{cert['l']}, S=#{cert['s']}, C=#{cert['c']}\" \
            -keyalg  #{keystore_alg} \
            -validity #{cert['validity']} \
            -alias #{cert['alias']} \
            -storetype #{keystore_type} \
            -keystore #{keystore} \
            -keypass \'#{keystore_pass}\' \
            -storepass \'#{keystore_pass}\'"
    result = Mixlib::ShellOut.new(cmd).run_command
    raise "Keystore generation failed:\n  stdout:\n#{result.stdout}\n  stderr:\n#{result.stderr}" unless result.exitstatus == 0
    new_resource.updated_by_last_action(true) 
    file keystore do
      mode '0640'
      owner owner
      group group
    end
  end
end
