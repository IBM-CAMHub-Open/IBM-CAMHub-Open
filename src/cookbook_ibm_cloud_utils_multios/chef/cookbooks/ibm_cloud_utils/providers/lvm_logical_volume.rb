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
    Chef::Log.info("Checking if volume group #{new_resource.vg_name} is created")
    errormessage1 ||= "Make sure the volume group #{new_resource.vg_name} is created"
    vg = shell_out!("vgs | grep #{new_resource.vg_name}")
    if vg.exitstatus != 0
      Chef::Log.debug("Volume group #{new_resource.vg_name} is missing. Please create it and try again")
      Chef::Application.fatal!(errormessage1, 10)
    end

    Chef::Log.info("Checking if the volume group #{new_resource.vg_name} has enough free space")
    
    vg_size_free = shell_out!("vgs #{new_resource.vg_name} --noheadings --nosuffix --units b -o vg_free ")
    Chef::Log.info("free space: #{vg_size_free.stdout}")
    
    lv_size_req = case new_resource.lv_size
                  when /^(\d+)(k|K)$/
                    (Regexp.last_match[1].to_i * 1024)
                  when /^(\d+)(m|M)$/
                    (Regexp.last_match[1].to_i * 1_048_576)
                  when /^(\d+)(g|G)$/
                    (Regexp.last_match[1].to_i * 1_073_741_824)
                  when /^(\d+)(t|T)$/
                    (Regexp.last_match[1].to_i * 1_099_511_627_776)
                  when /^(\d+)$/
                     Regexp.last_match[1].to_i
                     Chef::Application.fatal!("Invalid size #{Regexp.last_match[1]} for lv_size. Please add the sufix k|K|m|M|g|G|t|T to this value #{Regexp.last_match[1]}", 2)
                  else
                     Chef::Application.fatal!("Invalid size #{Regexp.last_match[1]} for lv_size", 2)
                  end
    Chef::Log.info("required space: #{lv_size_req}")
 
    Chef::Log.info("Creating logical volume #{new_resource.lv_name}")
    errormessage3 ||= "Logical volume #{new_resource.lv_name} was not created"
    ruby_block "Create LV #{new_resource.lv_name}" do
      block do
        if lv_size_req >= vg_size_free.stdout.to_i
          Chef::Log.debug("Volume group #{new_resource.vg_name} is missing. Please create it and try again")
          Chef::Application.fatal!("Not enough free speace in the volume group #{new_resource.vg_name} to create the new logical volume #{new_resource.lv_name}. Available: #{vg_size_free.stdout}. Required: #{lv_size_req}", 11)
        end
        lv = shell_out!("lvcreate -L #{new_resource.lv_size} -n #{new_resource.lv_name} #{new_resource.vg_name}")
        if lv.exitstatus != 0
          Chef::Log.debug("ERROR: Logical volume #{new_resource.lv_name} was not created")
          Chef::Application.fatal!(errormessage3, 12)
        end
        fs = shell_out!("mkfs -t #{new_resource.filesystem} /dev/#{new_resource.vg_name}/#{new_resource.lv_name}")
        if fs.exitstatus != 0
          Chef::Log.debug("ERROR: Filesystem /dev/#{new_resource.vg_name}/#{new_resource.lv_name} was not created")
          Chef::Application.fatal!("Filesystem /dev/#{new_resource.vg_name}/#{new_resource.lv_name} was not created", 13)
        end
      end
      not_if "lvs | grep #{new_resource.lv_name}"
    end
    Chef::Log.info("Creating directory #{new_resource.mountpoint}")
    directory "Create #{new_resource.mountpoint} directory" do
      path new_resource.mountpoint
      recursive true
      action :create
    end
    Chef::Log.info("Mounting FS")
    mount "Mounting FS" do
      device "/dev/mapper/#{new_resource.vg_name}-#{new_resource.lv_name}"
      mount_point new_resource.mountpoint
      options new_resource.options
      action [:mount, :enable]
    end 
    Chef::Log.info("LV #{new_resource.lv_name} created")
  end
  new_resource.updated_by_last_action(true)
end
