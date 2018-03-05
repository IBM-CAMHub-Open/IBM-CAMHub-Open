###########################################################
#          Copyright IBM Corp. 2017, 2017
###########################################################
include Chef::Mixin::ShellOut

use_inline_resources

def whyrun_supported?
  true
end

def create_swapfile(file, size)
  Chef::Log.info("creating #{file}")
  ::File.open(file, 'w') do |f|
    contents = "0" * (1024*1024)
    size.to_i.times { f.write(contents) }
    f.chmod(0o600)
  end
end

def format_swapfile(file, label)
  execute "format #{file} swap" do
    command "mkswap -L #{label} #{file}"
  end
end

def sync
  execute "syncing disks" do
    command "sync"
  end
end

def enable_swapfile(file)
  execute "enable #{file} swap" do
    command "swapon #{file}"
    not_if { shell_out('swapon -s').stdout.include?file }
  end
end

def disable_swapfile(file)
  execute "disable #{file} swap" do
    command "swapoff #{file}"
  end
end

def remove_swapfile(file)
  execute "remove #{file} swap" do
    command "rm #{file}"
    not_if { shell_out('swapon -s').stdout.include?file }
  end
end

action :create do
  if node['os'] == 'linux'
    unless ::File.exist?(new_resource.swapfile)
      Chef::Log.info("#{new_resource.swapfile} doesn't exist, creating...")
      create_swapfile(new_resource.swapfile, new_resource.size)
    end
    unless shell_out('swapon -s').stdout.include?new_resource.swapfile
      if (::File.blockdev?(new_resource.swapfile) && new_resource.force) || ::File.file?(new_resource.swapfile)
        Chef::Log.info("#{new_resource.swapfile} formatting...")
        format_swapfile(new_resource.swapfile, new_resource.label)
        sync
        enable_swapfile(new_resource.swapfile)
        new_resource.updated_by_last_action(true)
      else
        Chef::Log.info("#{new_resource.swapfile} is a block device but force is not set...")
        Chef::Application.fatal!("#{new_resource.swapfile} is a block device but force is not set...", 666)
      end
    end
  end
end

action :remove do
  if node['os'] == 'linux'
    Chef::Log.info("disabling #{new_resource.swapfile} ...")
    disable_swapfile(new_resource.swapfile)
    unless ::File.blockdev?(new_resource.swapfile)
      remove_swapfile(new_resource.swapfile)
    end
  end
end

action :enable do
  if node['os'] == 'linux'
    run_action(:create)
    mount new_resource.label do
      action :enable
      device new_resource.swapfile
      fstype 'swap'
    end
    new_resource.updated_by_last_action(true)
  end
end

action :disable do
  if node['os'] == 'linux'
    run_action(:remove)
    mount new_resource.label do
      action :disable
      device new_resource.swapfile
      fstype 'swap'
    end
    new_resource.updated_by_last_action(true)
  end
end
