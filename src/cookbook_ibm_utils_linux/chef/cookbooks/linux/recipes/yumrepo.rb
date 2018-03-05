# Cookbook Name:: linux
# Recipe:: yumrepo
#
# Copyright IBM Corp. 2017, 2017
#
#
# <> Create xxx.repo files on a redhat server
#
node['linux']['yum_repositories'].each_pair do |_p, v|
  repo_id = v['repositoryid']
  Chef::Log.info("Creating Repository  #{repo_id}...")

  yum_repository v['repositoryid'] do # ~FC009
    description v['description']
    baseurl v['baseurl']
    enabled v['enabled']
    gpgkey v['gpgkey']
    gpgcheck v['gpgcheck']
    sslverify v['sslverify']
    sslcacert v['sslcacert']
    action :create
    not_if { ::File.exist?("/etc/yum.repos.d/#{v['repositoryid']}.repo") }
  end
end
