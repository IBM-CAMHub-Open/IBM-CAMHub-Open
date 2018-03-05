#
# Cookbook Name::linux
# Recipe:: create_lvm
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create a series of physical volumes, volume groups and logical volumes

::Chef::Recipe.send(:include, LNXHelper)

###############################################################################
# Install LVM Libraries
###############################################################################

node['linux']['prereqs']['lvm'].each do |p|
  package p do
    action :upgrade
  end
end

###############################################################################
# CREATE FILE SYSTEMS
###############################################################################

node['linux']['physicalvolumes'].each do |pv_name, pv_details|
  next if pv_name.match('INDEX') && node['linux']['skip_indexes']
  size = pv_details['size']

  device = pv_details['device']
  # raise "Incorrect entry for device #{pv_name}: #{pv_details['device']}" unless /^\/dev\//.match(device).length == 1 && device.split('/').length == 3
  devsize = pv_details['size'].to_i * 2 * 1024**2 # size in number of 512B sectors

  # At first run we might get another device than expected
  if device.nil? || device.empty? || # no device specified
     # or specified device not present
     node['block_device'][device.split('/').last].nil? ||
     # or device exists but is of different size
     node['block_device'][device.split('/').last]['size'].to_i != devsize
    device = ''
    node['block_device'].each_pair do |disk, params|
      # match on device of expected size
      next unless params['size'].to_i == devsize
      # unless it already has a filesystem
      next unless raw_volume?(disk)
      device = '/dev/' + disk
      break
    end

    # ... so update attributes with the found device, or fail if none
    if device.to_s.empty?
      Chef::Application.fatal!("No device available for filesystem #{pv_name}, size #{size}", 1)
    else
      ruby_block "Save_Device_Details_#{pv_name}" do
        block do
          node.normal['linux']['physicalvolumes'][pv_name]['device'] = device
          node.save
        end
      end
    end
  end

  # Create volume group
  ibm_cloud_utils_lvm_physical_volume "Creating Physical Device on #{device} with a size #{size}" do
    disk device.gsub('/dev/', '')
    action :create
  end

  ibm_cloud_utils_lvm_volume_group "Creating Volume Group #{pv_details['vg_name']} on #{device}" do
    pv_name device
    vg_name pv_details['vg_name']
    action :create
  end

  pv_details['logicalvolumes'].each do |lv_name, lv_details|
    next if lv_name.match('INDEX') && node['linux']['skip_indexes']

    lv_name = lv_details['lv_name']
    ibm_cloud_utils_lvm_logical_volume "Creating logical volume #{lv_name} on #{pv_details['vg_name']}" do
      vg_name pv_details['vg_name']
      mountpoint lv_details['mountpoint']
      lv_name lv_details['lv_name']
      filesystem lv_details['filesystem']
      lv_size lv_details['lv_size']
      options lv_details['options']
      action :create
    end
  end
end
