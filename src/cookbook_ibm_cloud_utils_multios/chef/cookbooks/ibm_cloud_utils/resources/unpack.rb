# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
actions :unpack, :download
default_action :unpack

attribute :source, :kind_of => String
attribute :target_dir, :kind_of => String
attribute :target_file, :kind_of => String, :default => nil
attribute :checksum, :regex => /^[a-zA-Z0-9]{64}$/, :default => nil
attribute :owner, :kind_of => [String, Integer], :default => nil
attribute :group, :kind_of => [String, Integer], :default => nil
attribute :mode, :kind_of => [String, Integer], :default => 0o755
attribute :remove_local, :kind_of => [TrueClass, FalseClass], :default => false
attribute :force_extract, :kind_of => [TrueClass, FalseClass], :default => false
attribute :secure_repo, :kind_of => String, :default => "true"
attribute :repo_self_signed_cert, :kind_of => String, :default => "false"
attribute :vault_name, :kind_of => String, :default => node['ibm_internal']['vault']['name']
attribute :vault_item, :kind_of => String, :default => node['ibm_internal']['vault']['item']
attribute :sw_repo_user, :kind_of => String, :default => node['ibm']['sw_repo_user']

attr_accessor :exists
