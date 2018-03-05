# Cookbook Name:: db2
# Library:: db2_helper
#
# Copyright IBM Corp. 2017, 2017
#
# <> library: DB2 helper
# <> Library Functions for the DB2 Cookbook
include Chef::Mixin::ShellOut

module DB2
  # Helper module
  module Pwd
    def instance_password(instance_key, instance)
      chef_vault = node['db2']['vault']['name']
      encrypted_id = node['db2']['vault']['encrypted_id']
      instance_password = ''
      unless chef_vault.empty?
        require 'chef-vault'
        begin
          instance_password = chef_vault_item(chef_vault, encrypted_id)['db2']['instances'][instance_key]['instance_password']
        rescue NoMethodError
          raise "No password found for instance #{instance_key}, user #{instance} in chef vault \'#{chef_vault}\'"
        end
        raise "No password found for instance #{instance_key}, user #{instance} in chef vault \'#{chef_vault}\'" if instance_password.empty?
        Chef::Log.info "Found a password for instance #{instance_key}, user #{instance} in chef vault \'#{chef_vault}\'"
      end
      instance_password
    end

    def fenced_password(instance_key, fenced_user)
      chef_vault = node['db2']['vault']['name']
      encrypted_id = node['db2']['vault']['encrypted_id']
      fenced_password = ''
      unless chef_vault.empty?
        require 'chef-vault'
        begin
          fenced_password = chef_vault_item(chef_vault, encrypted_id)['db2']['instances'][instance_key]['fenced_password']
        rescue NoMethodError
          raise "No password found for fenced user #{fenced_user} in chef vault \'#{chef_vault}\'"
        end
        raise "No password found for fenced user #{fenced_user} in chef vault \'#{chef_vault}\'" if fenced_password.empty?
        Chef::Log.info "Found a password for fenced user #{fenced_user} in chef vault \'#{chef_vault}\'"
      end
      fenced_password
    end

    def chef_vault_item(bag, id)
      if ChefVault::Item.vault?(bag, id)
        ChefVault::Item.load(bag, id)
      elsif node['chef-vault']['databag_fallback']
        Chef::DataBagItem.load(bag, id)
      else
        raise "Trying to load a regular data bag item #{id} from #{bag}, and databag_fallback is disabled"
      end
    end
  end
end

Chef::Recipe.send(:include, DB2::Pwd)
Chef::Resource.send(:include, DB2::Pwd)
