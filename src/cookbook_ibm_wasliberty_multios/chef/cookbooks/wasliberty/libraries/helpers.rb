########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
# <> Module (helpers.rb)
# <> Module with helper functions to compute various liberty editions/settings
#
#########################################################################

# Cookbook Name  - wasliberty
#----------------------------------------------------------------------------------------------------------------------------------------------

# Module with helper functions to compute various liberty editions/settings
module Helpers
  require 'base64'
  def self.sdk_edition(node)
    sdk_editions = node['was_liberty']['sdk'].select { |_, props| props['enable'] == 'true' }

    # Eg:
    # {
    #   'common_ibm_sdk_v8'  => {
    #     'enable' => "true",
    #     'offering_id' => "com.ibm.java.jdk.v8",
    #     'feature' => "com.ibm.sdk.8"
    #   }
    # }

    if sdk_editions.length > 1
      raise "Please select either common IBM Java SDKs or IBM Websphere Java SDKs, but only one version can be set to true"
    end

    sdk_name = sdk_editions.keys.first # in prereq, we made sure there is only one key
    sdk_offering_id = sdk_editions[sdk_name]['offering_id']
    sdk_features = sdk_editions[sdk_name]['feature']

    [sdk_name, sdk_offering_id, sdk_features]
  end

  # def self.liberty_edition(node)
  #   liberty_editions = node['was_liberty']['editions'].select { |_, enabled| enabled == 'true' }
  #
  #   if liberty_editions.length != 1
  #     raise "Only select one edition to be installed"
  #   end
  #
  #   liberty_editions.keys.first
  # end

  def self.liberty_edition(node)
    unless [ 'core', 'base', 'nd' ].include?(node['was_liberty']['edition'])
      raise "Unknown liberty edition: #{node['was_liberty']['edition']}"
    end
    node['was_liberty']['edition']
  end

  def self.liberty_features(node)
    feature_list = node['was_liberty']['features'].select { |_, enabled| enabled == 'true' }.keys.join(',')

    unless feature_list.include?("liberty")
      raise "'liberty' must be selected"
    end

    feature_list
  end

  def self.pwd_encode(enc_mode, pwd)
    if RUBY_PLATFORM =~ /linux/
      enc_str = if enc_mode == 'xor'
                  Base64.encode64(pwd.bytes.map { |ascii| (ascii ^ 95).chr }.join).chomp
                end
      '{' + enc_mode + '}' + enc_str
    end
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

  Chef::Recipe.send(:include, Helpers)
  Chef::Resource.send(:include, Helpers)
end
