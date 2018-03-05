###########################################################
#          Copyright IBM Corp. 2012, 2016
###########################################################
#
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

use_inline_resources

def whyrun_supported?
  true
end
# Defining new Chef Resource

def load_current_resource
  @current_resource = Chef::Resource::IbmCloudUtilsSelinux.new(@new_resource.name)
  cmnd = shell_out('getenforce')
  @current_resource.status(cmnd.stdout.chomp.downcase)
end

def selinux_template(status)
  template "#{status} selinux config" do
    path '/etc/selinux/config'
    source 'sysconfig/selinux.erb'
    cookbook 'ibm_cloud_utils'
    if status == 'permissive'
      not_if "getenforce | grep -qx 'Disabled'"
    end
    variables(
      selinux: status.to_s,
      selinuxtype: 'targeted'
    )
  end
end
# Defining action enforcing
action :enforcing do
  if node['platform_family'] == 'rhel'
    unless @current_resource.status == 'enforcing'
      execute 'selinux-enforcing' do
        not_if "getenforce | grep -qx 'Enforcing'"
        command 'setenforce 1'
      end
      selinux_template('enforcing')
    end
  else
    log 'This OS is not using SElinux'
  end
  new_resource.updated_by_last_action(true)
end
# Defining action disabled
action :disabled do
  if node['platform_family'] == 'rhel'
    unless @current_resource.status == 'disabled'
      execute 'selinux-disabled' do
        only_if 'selinuxenabled'
        command 'setenforce 0'
      end
      selinux_template('disabled')
    end
  end
  new_resource.updated_by_last_action(true)
end
# Defining action permissive
action :permissive do
  if node['platform_family'] != 'rhel'
    unless @current_resource.status == 'permissive' || @current_resource.status == 'disabled'
      execute 'selinux-permissive' do
        not_if "getenforce | egrep -qx 'Permissive|Disabled'"
        command 'setenforce 0'
      end
      selinux_template('permissive')
    end
  end
  new_resource.updated_by_last_action(true)
end
# If action enabled is used it triggers action enforcing
action :enabled do
  run_action(:enforcing)
  new_resource.updated_by_last_action(true)
end
