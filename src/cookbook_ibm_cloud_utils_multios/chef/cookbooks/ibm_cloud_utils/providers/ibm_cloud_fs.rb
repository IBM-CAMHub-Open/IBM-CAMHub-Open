###########################################################
#          Copyright IBM Corp. 2017, 2017
###########################################################
include Chef::Mixin::ShellOut

use_inline_resources

def whyrun_supported?
  true
end

def format_device(device, label, fstype)
  case fstype
  when ['ext2', 'ext3', 'ext4']
    package 'e2fsprogs'
  when 'xfs'
    package 'xfsprogs'
  end
  execute "format #{device} device" do
    command "yes | mkfs.#{fstype} -L #{label} #{device}"
  end
end

def mount_device(device, mountpoint, fstype, options)
  execute "mounting #{device} in #{mountpoint}" do
    command "mount -o #{options} #{device} #{mountpoint}"
    only_if { ::File.directory?(mountpoint) }
    not_if { shell_out('mount').stdout.include?mountpoint }
    only_if { shell_out("lsblk -nflo FSTYPE #{device}").stdout.strip == fstype }
  end
end

def unmount_device(device, mountpoint)
  if (node['platform_family'] == 'rhel' && node['platform_version'].to_f >= 7.0) || (node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 16.0)
    package 'psmisc'
  end
  execute "unmounting #{device}" do
    command "umount #{mountpoint}"
    only_if { shell_out('mount').stdout.include?mountpoint }
    only_if { shell_out("fuser -m #{device}").stdout.strip.empty? }
  end
end

action :create do
  if node['os'] == 'linux'
    if shell_out("lsblk -nflo FSTYPE #{new_resource.device}").stdout.strip.empty?
      if ::File.blockdev?(new_resource.device) && new_resource.force
        Chef::Log.info("#{new_resource.device} formatting...")
        format_device(new_resource.device, new_resource.label, new_resource.fstype)
      else
        Chef::Log.info("#{new_resource.device} is a block device but force is not set...")
        Chef::Application.fatal!("#{new_resource.device} is a block device but force is not set...", 666)
      end
    end
    Chef::Log.info("#{new_resource.device} is already formatted, mounting...")
    mount_device(new_resource.device, new_resource.mountpoint, new_resource.fstype, new_resource.options)
    new_resource.updated_by_last_action(true)
  end
end

action :remove do
  if node['os'] == 'linux'
    Chef::Log.info("unmounting #{new_resource.device} ...")
    unmount_device(new_resource.device, new_resource.mountpoint)
  end
end

action :enable do
  if node['os'] == 'linux'
    run_action(:create)
    mount new_resource.mountpoint do  
      action [:mount, :enable]
      device new_resource.device
      fstype new_resource.fstype
      options new_resource.options
    end
    new_resource.updated_by_last_action(true)
  end
end

action :disable do
  if node['os'] == 'linux'
    run_action(:remove)
    mount new_resource.mountpoint do        
      action :disable  
      device new_resource.device
      fstype new_resource.fstype
      options new_resource.options
    end
    new_resource.updated_by_last_action(true)
  end
end
