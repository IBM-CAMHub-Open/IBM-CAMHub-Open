# libraries/matchers.rb
#
# Copyright IBM Corp. 2017, 2017
#
# ChefSpec matchers
# See: Packaging Custom Matchers at: https://github.com/sethvargo/chefspec


if defined?(ChefSpec)

  # Template
  # def <action>_<lwrp>(<resource>)
  #   ChefSpec::Matchers::ResourceMatcher.new(:<lwrp>, :<action>, <resource>)
  # end

  # LWRP  : instance
  # action: create
  def create_db2_instance(source)
    ChefSpec::Matchers::ResourceMatcher.new(:db2_instance, :create, source)
  end

  # LWRP  : database
  # action: create
  def create_db2_database(source)
    ChefSpec::Matchers::ResourceMatcher.new(:db2_database, :create, source)
  end

  # LWRP  : fixpack
  # action: install
  def install_db2_fixpack(source)
    ChefSpec::Matchers::ResourceMatcher.new(:db2_fixpack, :install, source)
  end

end
