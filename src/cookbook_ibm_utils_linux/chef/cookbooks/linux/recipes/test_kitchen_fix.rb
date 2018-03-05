# Cookbook Name:: linux
# Recipe:: test_kitchen_fix
#
# Copyright IBM Corp. 2016, 2017
#
#
# <> Install net-tools for inspec testing of port numbers.

#  https://access.redhat.com/solutions/3134931

execute 'fix-nspr' do
  command "yum install glibc.i686 nspr -y"
  only_if { node['platform_family'] == 'rhel' }
end

# required by newer Linux versions in order to pass InSpec tests
package 'net-tools' do
  action :install
end

# Vault gem install for inspec
chef_gem 'chef-vault' do
  version "2.9.0"
  action :install
  compile_time true
end
