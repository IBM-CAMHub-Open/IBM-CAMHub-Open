#
# Cookbook Name::linux
# Recipe:: create_fs
#
# Copyright IBM Corp. 2016, 2017
#
# <> Create 1..n disks and mount based on the ibm_cloud_fs resource

::Chef::Recipe.send(:include, LNXHelper)

###############################################################################
# CREATE FILE SYSTEMS
###############################################################################

fs_to_process = {}
disks_allocated = []

# First get devices whose attributes are valid
node['linux']['filesystems'].each_pair do |fs_name, fs_details|
  next if fs_name.match('INDEX') && node['linux']['skip_indexes']

  device = fs_details['device']
  devsize = fs_details['size'].to_i * 2 * 1024**2 # size in number of 512B sectors

  next if device.nil? || device.empty?
  next if node['block_device'][device.split('/').last].nil?
  next if node['block_device'][device.split('/').last]['size'].to_i != devsize
  fs_to_process[fs_name] = fs_details
  Chef::Log.debug("From attributes: #{fs_name}: #{fs_details['device']} (#{fs_details['size']}): #{fs_details['mountpoint']}")
  disks_allocated.push(device)
end

# If any left, get devices by size
node['linux']['filesystems'].each_pair do |fs_name, fs_details|
  next if fs_name.match('INDEX') && node['linux']['skip_indexes']
  next if fs_to_process.keys.include?(fs_name)

  size = fs_details['size']
  device = fs_details['device']
  devsize = fs_details['size'].to_i * 2 * 1024**2 # size in number of 512B sectors

  if device.nil? || device.empty? || # no device specified
     # or specified device not present
     node['block_device'][device.split('/').last].nil? ||
     # or device exists but of different size
     node['block_device'][device.split('/').last]['size'].to_i != devsize ||
     # or device was allocated in a previous loop
     disks_allocated.include?(device)
    device = ''
    node['block_device'].each_pair do |disk, params|
      # match on device of expected size
      next unless params['size'].to_i == devsize
      # unless it already has a filesystem
      next unless raw_volume?(disk)
      # and wasn't allocated in a previous loop
      next if disks_allocated.include?('/dev/' + disk)
      device = '/dev/' + disk
      break
    end
    disks_allocated.push(device)
    Chef::Log.debug("Found: #{fs_name}: #{device} (#{fs_details['size']}): #{fs_details['mountpoint']} (was #{fs_details['device']})")

    # ... so update attributes with the found device, or fail if none
    if device.to_s.empty?
      raise "No device available for filesystem #{fs_name}, size #{size}"
    else
      ruby_block "Save_Device_Details_#{fs_name} - #{device}:#{fs_details['mountpoint']}" do
        block do
          node.normal['linux']['filesystems'][fs_name]['device'] = device
          node.save
        end
      end
    end
  end

  fs_to_process[fs_name] = {}
  fs_details.each_pair do |k, v|
    fs_to_process[fs_name][k] = v unless k == 'device'
  end
  fs_to_process[fs_name]['device'] = device
end

# ...and process results
fs_to_process.each_pair do |_fs_name, fs_details|
  # create mountpoint
  directory fs_details['mountpoint'] do
    owner fs_details['user'] unless fs_details['user'].casecmp('default') == 0
    group fs_details['group'] unless fs_details['group'].casecmp('default') == 0
    mode fs_details['perms'] unless fs_details['perms'].casecmp('default') == 0
    action :create
    recursive true
  end

  # ...and mount
  ibm_cloud_utils_ibm_cloud_fs fs_details['label'] do
    action :enable
    device fs_details['device']
    mountpoint fs_details['mountpoint']
    label fs_details['label']
    fstype fs_details['fstype']
    force true
  end
end
