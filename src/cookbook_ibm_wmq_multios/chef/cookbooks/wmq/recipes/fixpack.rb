#
# Cookbook Name:: wmq
# Recipe:: fixpack
#
# Copyright IBM Corp. 2016, 2017
#
# <> Installation recipe (fixpack.rb)
# <> This recipe performs the fixpack installation for the product


# Determine if Fixpack is to be run
# ------------------------------------------------------------------------------


upgrade_fixpack = if wmq_installed?
                    true
                  else
                    false
                  end

# Determine Installation Packages
# ------------------------------------------------------------------------------

Chef::Log.info("Setting Install Packages")
case node['wmq']['advanced']
when 'false'
  packages = node['wmq']['fixpackpackages']
when 'true'
  packages = "#{node['wmq']['fixpackpackages']} #{node['wmq']['advancedfixpack']}"
end

# Extract packages from archives
# ------------------------------------------------------------------------------

if node['wmq']['fixpack'] == "0"
  Chef::Log.info("#{node['wmq']['fixpack']}.to_s")
  Chef::Log.info("No Fixpack being applied.")
else

  if platform?('redhat') || platform?('ubuntu')
    Chef::Log.info("########## #{node['wmq']['fixpack']}")
    node['wmq']['fixpack_names'].each do |type, package|
      next if type != 'fixpack'
      filename = package['filename']
      pkg_url = node['ibm']['sw_repo'] + node['wmq']['sw_repo_path'] + '/' + 'maint' + '/' + filename

      Chef::Log.info("Unpacking #{filename} from #{pkg_url}")
      ibm_cloud_utils_unpack "Fetch and unpack :#{filename}" do
        source pkg_url
        target_dir node['wmq']['expand_area'] + '/fixpack/'
        owner 'root'
        group 'root'
        mode node['wmq']['perms']
        remove_local true
        only_if { wmq_upgrade_fixpack? }
        vault_name node['wmq']['vault']['name']
        vault_item node['wmq']['vault']['encrypted_id']
        repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
        not_if { ::File.exist?("#{node['wmq']['expand_area']}/fixpack/readme_en_US") }
      end
    end

    # Stop all queue managers
    # -------------------------------------------------------------------------------

    node['wmq']['qmgr'].each do |_qmgr, qmgrobject|
      if upgrade_fixpack
        execute_stop_qmgr(qmgrobject)
      end
    end


    # Upgrade WebSphere Message Queue (RPM Packages Installation)
    # -------------------------------------------------------------------------------

    Chef::Log.info("Installing Fixpack Packages #{node['wmq']['fixpackpackages']}")
    execute 'pkgs_installation_fixpack_packages' do
      case node['platform_family']
      when 'rhel'
        command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{packages}"
      when 'debian'
        command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{packages} --force-debian"
      end
      cwd node['wmq']['expand_area'] + '/fixpack'
      only_if { wmq_upgrade_fixpack? }
    end

    Chef::Log.info("Installing GSK Fixpack Packages #{node['wmq']['fixpackgsk']}")
    execute 'pkgs_installation_fixpack_gsk' do
      case node['platform_family']
      when 'rhel'
        command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{node['wmq']['fixpackgsk']}"
      when 'debian'
        command "rpm --prefix #{node['wmq']['install_dir']} -ivh #{node['wmq']['fixpackgsk']} --force-debian"
      end
      cwd node['wmq']['expand_area'] + '/fixpack'
      only_if { wmq_upgrade_fixpack? }
    end

    # Start all queue managers
    # -------------------------------------------------------------------------------

    node['wmq']['qmgr'].each do |_qmgr, qmgrobject|
      unless upgrade_fixpack
        execute_start_qmgr(qmgrobject)
      end
    end

  end

  if platform?('aix')
    cookbook_file "#{node['ibm']['temp_dir']}/wmqResponse-fixpack.txt" do
      mode 0775
    end

    remote_file fixpackfile do
      source fixpackfile
      path "#{node['wmq']['expand_area']}/fixpack/#{File.basename(fixpackfile)}"
      mode 0755
      action :create
    end

    execute "unpack_package_#{File.basename(fixpackfile)}" do
      command "zcat #{File.basename(fixpackfile)} | tar xvf -"
      cwd setup_fixpack
    end

    execute 'permission_setupmaint' do
      command "chown -R #{mqusr}:#{mqgrp} #{setup_fixpack}"
      action :run
    end

    execute 'maint_pkg_installation' do
      command "/usr/lib/instl/sm_inst installp_cmd -a -l -c -N -g -X -Y -d #{setup_fixpack} -f #{node['ibm']['temp_dir']}/wmqResponse-fixpack.txt > #{evidence_path_unix}/wmq_upgrade.log"
      action :run
    end
  end
end
