# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
module Vault
  # Helper module
  module Helper
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

Chef::Recipe.send(:include, Vault::Helper)
Chef::Resource.send(:include, Vault::Helper)
Chef::Provider.send(:include, Vault::Helper)
