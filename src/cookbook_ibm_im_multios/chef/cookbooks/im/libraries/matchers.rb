# libraries/matchers.rb
#
# Copyright IBM Corp. 2016, 2016
#
# ChefSpec matchers
# See: Packaging Custom Matchers at: https://github.com/sethvargo/chefspec


if defined?(ChefSpec)

  # Template
  # def <action>_<lwrp>(<resource>)
  #   ChefSpec::Matchers::ResourceMatcher.new(:<lwrp>, :<action>, <resource>)
  # end

  # LWRP  : ihs_htpasswd_db
  # action: tar
  def install_im_im_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:im_install, :install_im, resource_name)
  end

  def upgrade_im_im_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:im_install, :upgrade_im, resource_name)
  end

  def install_im_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:im_install, :install, resource_name)
  end

end
