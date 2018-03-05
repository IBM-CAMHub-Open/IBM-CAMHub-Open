#
# Cookbook Name:: wmq
# Recipe:: install
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (install.rb)
# <> This recipe performs the product installation.

# Determine Installation Packages
# ------------------------------------------------------------------------------

Chef::Log.info("Setting Install Packages")
case node['wmq']['advanced']
when 'false'
  packages = node['wmq']['packages']
when 'true'
  packages = "#{node['wmq']['packages']} #{node['wmq']['advancedpackages']}"
end

# Extract packages from archives
# ------------------------------------------------------------------------------
if platform?('redhat') || platform?('ubuntu')
  node['wmq']['archive_names'].each do |type, package|
    next if type != 'base'
    filename = package['filename']
    pkg_url = node['ibm']['sw_repo'] + node['wmq']['sw_repo_path'] + '/' + 'base' + '/' + filename

    Chef::Log.info("Unpacking #{filename} from #{pkg_url}")
    ibm_cloud_utils_unpack "Fetch and unpack :#{filename}" do
      source pkg_url
      target_dir node['wmq']['expand_area'] + '/base/'
      owner 'root'
      group 'root'
      mode node['wmq']['perms']
      remove_local true
      vault_name node['wmq']['vault']['name']
      vault_item node['wmq']['vault']['encrypted_id']
      repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
      not_if { wmq_installed? }
      not_if { ::File.exist?("#{node['wmq']['expand_area']}/base/mqlicense.sh") }
    end
  end

  Chef::Log.info("Setting perms on expand area #{node['wmq']['expand_area']}")
  execute 'permission_setup_base' do
    command "chown -R root:root #{node['wmq']['expand_area']}"
    not_if { wmq_installed? }
  end

  # Install WebSphere Message Queue (RPM Packages Installation)
  # ----------------------------------------------------------------------------
  case node['wmq']['version']
  when '8.0'
    install_root = node['wmq']['expand_area'] + '/base'
  when '9.0'
    install_root = node['wmq']['expand_area'] + '/base/MQServer'
  end

  Chef::Log.info("Running mqlicense.sh")
  execute 'license' do
    command './mqlicense.sh -accept'
    cwd install_root
    not_if { wmq_installed? }
  end

  Chef::Log.info("Installing Packages #{node['wmq']['packages']}")
  execute 'pkgs_installation_base_packages' do
    case node['platform_family']
    when 'rhel'
      command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{packages}"
    when 'debian'
      command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{packages} --force-debian"
    end
    cwd install_root
    not_if { wmq_installed? }
  end

  Chef::Log.info("Installing GSK Packages #{node['wmq']['gskpackages']}")
  execute 'pkgs_installation_base_gsk' do
    case node['platform_family']
    when 'rhel'
      command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{node['wmq']['gskpackages']}"
    when 'debian'
      command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{node['wmq']['gskpackages']} --force-debian"
    end
    cwd install_root
    not_if { wmq_installed? }
  end

  Chef::Log.info("Setting environment parameters - #{node['wmq']['install_dir']}/bin/setmqinst -i -p #{node['wmq']['install_dir']}")
  execute 'system set environments parameters' do
    command "#{node['wmq']['install_dir']}/bin/setmqinst -i -p #{node['wmq']['install_dir']}"
    action :run
    not_if { wmq_installed? }
  end

  Chef::Log.info("Setting perms MQSeries Permissions on file systems")
  execute 'permission_setup_base_2' do
    command "chown -R #{node['wmq']['os_users']['mqm']['name']}:#{node['wmq']['os_users']['mqm']['gid']} #{node['wmq']['install_dir']}"
    not_if { wmq_installed? }
  end
  execute 'permission_setup_data' do
    command "chown -R #{node['wmq']['os_users']['mqm']['name']}:#{node['wmq']['os_users']['mqm']['gid']} #{node['wmq']['data_dir']}"
    not_if { wmq_installed? }
  end
  execute 'permission_setup_qmgr' do
    command "chown -R #{node['wmq']['os_users']['mqm']['name']}:#{node['wmq']['os_users']['mqm']['gid']} #{node['wmq']['qmgr_dir']}"
    not_if { wmq_installed? }
  end
  execute 'permission_setup_log' do
    command "chown -R #{node['wmq']['os_users']['mqm']['name']}:#{node['wmq']['os_users']['mqm']['gid']} #{node['wmq']['log_dir']}"
    not_if { wmq_installed? }
  end


end

if platform?('aix')
  Chef::Log.info("Setting response file #{node['ibm']['temp_dir']}/wmqResponse.txt")
  cookbook_file "#{node['ibm']['temp_dir']}/wmqResponse.txt" do
    mode 0775
  end

  Chef::Log.info("Setting permissions on installation files #{node['wmq']['expand_area']}/base/#{File.basename(basefile)}")
  remote_file basefile do
    source basefiles
    path "#{node['wmq']['expand_area']}/base/#{File.basename(basefile)}"
    mode 0755
    action :create
  end

  Chef::Log.info("Unpacking installation packages zcat #{File.basename(basefile)} | tar xvf -")
  execute "unpack_package_#{File.basename(basefile)}" do
    command "zcat #{File.basename(basefile)} | tar xvf -"
    cwd node['wmq']['expand_area'] + '/base'
  end

  Chef::Log.info("Setting ownership of the #{node['wmq']['expand_area']}/base directory to #{node['wmq']['os_users']['mqm']['name']}:#{node['wmq']['os_users']['mqm']['gid']}")
  execute 'permission_setupbase' do
    command "chown -R #{node['wmq']['os_users']['mqm']['name']}:#{node['wmq']['os_users']['mqm']['gid']} #{node['wmq']['expand_area']}/base"
    action :run
  end

  Chef::Log.info("Install base package /usr/lib/instl/sm_inst installp_cmd -a -l -c -N -g -X -Y -d #{node['wmq']['expand_area']}/base -f #{node['ibm']['temp_dir']}/wmqResponse.txt > #{node['ibm']['evidence_path']}/wmq_installation.log")
  execute 'base_pkg_installation' do
    command "/usr/lib/instl/sm_inst installp_cmd -a -l -c -N -g -X -Y -d #{node['wmq']['expand_area']}/base -f #{node['ibm']['temp_dir']}/wmqResponse.txt > #{node['ibm']['evidence_path']}/wmq_installation.log"
    action :run
  end
end
