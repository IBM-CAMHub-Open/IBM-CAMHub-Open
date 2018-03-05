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

  # LWRP  : ibm_cloud_utils_tar
  # action: tar
  def check_ibm_cloud_utils_cpuno(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_cpuno, :check, source)
  end

  def check_ibm_cloud_utils_freespace(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_freespace, :check, source)
  end

  def install_ibm_cloud_utils_ibm_cloud_yum(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_ibm_cloud_yum, :install, source)
  end

  def upgrade_ibm_cloud_utils_ibm_cloud_yum(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_ibm_cloud_yum, :upgrade, source)
  end

  def purge_ibm_cloud_utils_ibm_cloud_yum(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_ibm_cloud_yum, :purge, source)
  end

  def run_ibm_cloud_utils_increasepagesize(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_increasepagesize, :run, source)
  end

  def create_ibm_cloud_utils_lvm_logical_volume(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_lvm_logical_volume, :create, source)
  end

  def create_ibm_cloud_utils_lvm_physical_volume(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_lvm_physical_volume, :create, source)
  end

  def create_ibm_cloud_utils_lvm_volume_group(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_lvm_volume_group, :create, source)
  end

  def check_ibm_cloud_utils_ram(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_ram, :check, source)
  end

  def enforcing_ibm_cloud_utils_selinux(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_selinux, :enforcing, source)
  end

  def disabled_ibm_cloud_utils_selinux(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_selinux, :disabled, source)
  end

  def permissive_ibm_cloud_utils_selinux(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_selinux, :permissive, source)
  end

  def enabled_ibm_cloud_utils_selinux(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_selinux, :enabled, source)
  end

  def copy_ibm_cloud_utils_ssh_util(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_ssh_util, :copy, source)
  end

  def exec_ibm_cloud_utils_ssh_util(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_ssh_util, :exec, source)
  end

  def tar_ibm_cloud_utils_tar(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_tar, :tar, source)
  end

  def unpack_ibm_cloud_utils_unpack(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_unpack, :unpack, source)
  end

  def zip_ibm_cloud_utils_zip(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_zip, :zip, source)
  end

  def ibm_cloud_utils_supported_os_check(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_supported_os_check, :check, source)
  end

  def ibm_cloud_utils_hostsfile_update(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_hostsfile_update, :updateshosts, source)
  end

  def ibm_cloud_utils_enable_awsyumrepo(source)
    ChefSpec::Matchers::ResourceMatcher.new(:ibm_cloud_utils_enable_awsyumrepo, :enable, source)
  end
end
