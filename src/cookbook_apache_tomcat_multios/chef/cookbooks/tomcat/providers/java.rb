#
# Cookbook Name:: tomcat
# Provider:: java.rb
#
# Copyright IBM Corp. 2017, 2017
#

# include TomcatHelper

use_inline_resources

# TODO: Update for IBM and Oracle
supported_vendors = ['openjdk'] # , 'ibm', 'oracle']
# TODO: More platforms
supported_platforms = %w(rhel debian suse)

action :upgrade do
  vendor = new_resource.vendor.downcase
  version = new_resource.version
  install_sdk = if new_resource.sdk.casecmp('true') == 0
                   true
                elsif new_resource.sdk.casecmp('false') == 0
                   false
                end

  # Validate input
  raise "Unsupported version #{version}, expecting 1.8.0 or similar." if /^\d+\.\d+\.\d+$/.match(version).to_s.empty?
  raise "The sdk parameter should be a string containing either 'true' or 'false'" if install_sdk.nil?
  raise "Vendor #{vendor} is not supported" unless supported_vendors.include? vendor
  raise "Supported platforms are RHEL, SUSE and Ubuntu, this machine is #{node['platform']}" unless supported_platforms.include? node['platform_family']

  case vendor
  when 'openjdk'
    case node['platform_family']
    when 'rhel'
      java_package = 'java-' + version + '-openjdk'
      java_package += '-devel' if install_sdk
    when 'suse'
      java_package = 'java-' + version.split('.').join('_') + '-openjdk'
      java_package += '-devel' if install_sdk
    when 'debian'
      java_package = 'openjdk-' + version.split('.')[1]
      java_package += if install_sdk
                         '-jdk'
                      else
                         '-jre'
                      end
      # Ubuntu images age very quickly, sync apt index
      execute 'Running apt-get update' do
        command 'apt-get update'
        cwd '/root'
        not_if { ::File.exist?('/usr/bin/java') } # only at first run; we are not doing OS maintenance here
      end
    end

    package java_package do
      action :upgrade
    end
  when 'ibm'
  when 'oracle'
  end
end
