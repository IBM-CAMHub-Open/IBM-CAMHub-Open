########################################################
#
# Cookbook Name:: oracledb
# Recipe:: prereq
#
# Copyright IBM Corp. 2016, 2017
#
########################################################
#
# <> Installation recipe (prereq.rb)
# <> This recipe configures the operating prerequisites for the product.

# This will only work if the VM has access to rubygems.org
# Otherwise the gem should be installed during bootstrap
chef_gem 'chef-vault' do
  action :install
  version '2.9.0'
  compile_time true
end

################################################################################
# PACKAGES INSTALLATION
################################################################################
ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end

ibm_cloud_utils_enable_awsyumrepo 'enable_aws_extra_yumrepo' do
  action :enable
end

# upgrade OS packages
node['oracledb']['os_libraries'].each do |dep|
  package dep do
    action :upgrade
  end
end

################################################################################
# Create users and groups
################################################################################
# create group + user and assign user to group
node['oracledb']['os_users'].each_pair do |_k, user|

  next if user['ldap_user'] == 'true' || user['name'].nil?

  group user['gid'] do
    action :create
    not_if { user['gid'].nil? }
  end

  next if user['name'] == 'root'

  user user['name'] do
    manage_home true
    comment user['comment']
    gid user['gid']
    home user['home']
    shell user['shell']
    action :create
  end

end

###############################################################################
# ORACLE/GRID GROUPS CREATION
###############################################################################
# create additional groups and assign user to additional groups
node['oracledb']['groups'].each do |grp|
  group grp do
    action :create
    members node['oracledb']['os_users']['oracle']['name']
    append true
  end
end


# File permission are specified in oracle documentation :: https://docs.oracle.com/database/121/LADBI/pre_install.htm#LADBI7645
directory node['oracledb']['data_mount'] + '/app' do
    owner node['oracledb']['os_users']['oracle']['name']
    group node['oracledb']['install_group']
    mode '0775'
    recursive true
end


directory node['oracledb']['oracle_base'] do
    owner node['oracledb']['os_users']['oracle']['name']
    group node['oracledb']['install_group']
    mode '0775'
    recursive true
end



# create user profile
template "#{node['oracledb']['os_users']['oracle']['home']}/.profile" do
  source 'ora_profile.erb'
  owner node['oracledb']['os_users']['oracle']['name']
  group node['oracledb']['install_group']
  variables(
    ORABASE: node['oracledb']['oracle_base'],
    ORAHOME: node['oracledb']['oracle_home'],
    ORASID:  node['oracledb']['SID']
  )
end

################################################################################
# HUGEPAGE SETTINGS
################################################################################

case node['platform_family']
when "rhel"

    cookbook_file '/usr/local/bin/hugepage_settings.sh' do
        source 'hugepage_settings.sh'
        owner 'root'
        group 'root'
        mode '0755'
    end


    # set kernel parms
    bash 'sysctl_reload' do
        code 'source /etc/init.d/functions && apply_sysctl'
        action :nothing
    end

    # create directory if doesnt exist, specially for rhel 6.x
    directory '/etc/sysctl.d' do
        mode '0755'
        recursive true
        action :create
    end

    # run bash sysctl_reload immediately
    cookbook_file '/etc/sysctl.d/ora_params' do
        mode '0644'
        notifies :run, 'bash[sysctl_reload]', :immediately
    end


    ################################################################################
    # SWAP CREATION
    ################################################################################
    # create a regular swap file

    swap_file_size_mb = node['oracledb']['swap_file_size_mb']
    swap_file_name = node['oracledb']['swap_file']

    if swap_file_size_mb == '-1'
        system_memory_kb = node['memory']['total']
        system_memory_mb = system_memory_kb.gsub("kB", "").to_i/1024 # Need to check the Size of Hugepages
        swap_file_size_mb = if system_memory_mb < 16*1024
                                system_memory_mb
                            else
                                16*1024
                            end
    end

    execute 'creating swapfile' do
        command "/bin/dd if=/dev/zero of=#{swap_file_name} bs=1M count=#{swap_file_size_mb}"
        creates swap_file_name
    end

    # format the regular swap file, already created in previous step
    execute 'formatting swapfile' do
        command "/sbin/mkswap -L local #{swap_file_name}"
        only_if { File.exist? swap_file_name }
        not_if  { IO.popen("swapon -s | grep #{swap_file_name}").readlines.join.include? swap_file_name }
    end

    # mount the swap file
    mount 'mount the swap file' do
        device swap_file_name
        mount_point 'none'
        fstype 'swap'
        options 'sw'
        dump 0
        pass 0
        action :enable
        only_if { File.exist? swap_file_name }
    end

    execute 'swap activation' do
        command '/sbin/swapon -a'
        action :run
        only_if { File.exist? swap_file_name }
    end


    # Configure Shell Limits and System Configuration Parameters

    cookbook_file node['oracledb']['user_limits_conf_file_path'] do
        source 'oracle.conf'
        owner 'root'
        group 'root'
        mode '0644'
    end

    template '/etc/profile.d/oracle-hostname.sh' do
        owner 'root'
        group 'root'
        mode '0755'
        source 'oracle-hostname.sh.erb'
        variables(
            fqdn: node['fqdn']
        )
    end

end


# At least 1 GB RAM for Oracle Database installations. 2 GB RAM recommended.
# At least 8 GB RAM for Oracle Grid Infrastructure installations.
# Disable Transparent HugePages
# At least 1 GB of space in the /tmp directory.
# Swap size
# Between 1 GB and 2 GB: 1.5 times the size of the RAM
# Between 2 GB and 16 GB: Equal to the size of the RAM
# More than 16 GB: 16 GB
# For upgrades, Oracle Universal Installer (OUI) detects an existing oraInventory directory from the /etc/oraInst.loc file, and uses the existing oraInventory.
#
