# libraries/matchers.rb
#
# Copyright IBM Corp. 2016, 2017
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
  def create_ihs_htpasswd_db(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:ihs_htpasswd_db, :create, resource_name)
  end

end
