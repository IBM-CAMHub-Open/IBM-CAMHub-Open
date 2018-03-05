########################################################
#	  Copyright IBM Corp. 2012, 2016 
########################################################
# 

use_inline_resources
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

action :create do
  # This works on linux only
  if RUBY_PLATFORM.downcase.include?'linux'
    package 'lvm2'
    Chef::Log.info("Checking if physical volume #{new_resource.pv_name} is created")
    errormessage ||= "Make sure physical volume #{new_resource.pv_name} is created"
    pv = shell_out!("pvs | grep #{new_resource.pv_name}")
    if pv.exitstatus != 0
      Chef::Log.debug("#{new_resource.pv_name} physical volume is missing. Please create it and try again")
      Chef::Application.fatal!(errormessage, 13)
    else
      execute "Create VG #{new_resource.vg_name}" do
        command "vgcreate #{new_resource.vg_name} #{new_resource.pv_name}"
        not_if "vgs | grep #{new_resource.vg_name}"
      end
      Chef::Log.info("VG #{new_resource.vg_name} created")
    end
  end
  new_resource.updated_by_last_action(true)
end
