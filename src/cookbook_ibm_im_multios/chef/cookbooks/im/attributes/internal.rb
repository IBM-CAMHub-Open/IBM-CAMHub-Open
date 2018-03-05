# encoding: UTF-8
########################################################
#	  Copyright IBM Corp. 2012, 2017
########################################################
#
# <> Installation Manager Version Number to be installed. Supported versions: 1.8.5
default['im']['version'] = '1.8.6'
# <> Installation Manager Mode, Admin / NonAdmin / Group
default['im']['install_mode'] = ''

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''

# <> The user that should be used to authenticate on software repository
default['ibm']['sw_repo_user'] = ''

# <> The password of sw_repo_user
default['ibm']['sw_repo_password'] = ''

# <> the URL to the root directory of the local IM repository (http://<hostname/IP>:<port>/IMRepo)
default['ibm']['im_repo'] = ''

# <> The user that should be used to authenticate on IM repository
default['ibm']['im_repo_user'] = ''

# <> The password of im_repo_user
default['ibm']['im_repo_password'] = ''
# <> The path to the directory where the software installation packages are located
force_override['im']['sw_repo_path'] = '/im/v1x/base'
# <> Installation Manager Fixpack ID.
default['im']['fixpack_offering_id'] = 'com.ibm.cic.agent'


force_override['im']['supported_versions'] = ['1.8.5', '1.8.6']

Chef::Log.info("Checking supported IM version")
raise "IM version #{node['im']['version']} not supported" unless node['im']['supported_versions'].include? node['im']['version']
Chef::Log.info("PASS: IM Version is: #{node['im']['version']}")

force_override['im']['supported_versions'] = ['1.8.5', '1.8.6']

Chef::Log.info("Checking supported IM version")
raise "IM version #{node['im']['version']} not supported" unless node['im']['supported_versions'].include? node['im']['version']
Chef::Log.info("PASS: IM Version is: #{node['im']['version']}")

case node['platform_family']
when 'rhel', 'debian'
  case node['kernel']['machine']
  when 'x86_64'
    default['im']['arch'] = 'x86_64'
    # <> Installation Manager Version 1.8.5, 1.8.6
    force_override['im']['archive_names'] =
      { '1.8.5' => { 'filename' => 'agent.installer.linux.gtk.' + node['im']['arch'] + '_1.8.5000.20160506_1125.zip',
                     'sha256' => '76190adf69f6e4a6a8d7432983f5aebe68d56545a3a13b3ecd6b25c12d433b04' },
        '1.8.6' => { 'filename' => 'agent.installer.linux.gtk.' + node['im']['arch'] + '_1.8.6000.20161118_1611.zip',
                     'sha256' => 'b253a06bccace5934b108632487182f6a6f659082fea69372242b9865a64e4f3' } }
  end
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> An absolute path to a directory that will be used to store the evidence file created as part of the automation
  default['ibm']['evidence_path'] = node['ibm']['log_dir'] + '/evidence'
  # <> An absolute path to a file that will be used to store the evidence artifacts created as part of the automation
  default['ibm']['evidence_zip'] = "#{node['ibm']['evidence_path']}/im-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"
  # <> A temporary directory used for the extraction of installation files
  force_override['im']['expand_area'] = node['ibm']['expand_area'] + '/im'

when 'windows'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = 'C:\\temp\\ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = 'C:\\temp\\ibm_cloud\\log'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '\\expand_area'
  # <> An absolute path to a directory that will be used to store the evidence file created as part of the automation
  default['ibm']['evidence_path']= node['ibm']['log_dir'] + '\\evidence'
  # <> An absolute path to a file that will be used to store the evidence artifacts created as part of the automation
  default['ibm']['evidence_zip'] = "#{node['ibm']['evidence_path']}/im-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.zip"
  # <> A temporary directory used for the extraction of installation files
  force_override['im']['expand_area'] = node['ibm']['expand_area'] + '\\im'
end

# This will be used only for standalone installation for tests
case node['im']['install_mode']
when 'nonAdmin'
  default['im']['os_users']['im_user']['name'] = 'imuser'
  default['im']['os_users']['im_user']['gid'] = 'imgroup'
  default['im']['os_users']['im_user']['ldap_user'] = 'false'
  default['im']['os_users']['im_user']['comment'] = 'IM Non-Admin mode user'
  default['im']['os_users']['im_user']['home'] = '/home/imuser'
  default['im']['os_users']['im_user']['shell'] = '/bin/bash'

when 'group'
  default['im']['os_users']['im_user']['name'] = 'imuser'
  default['im']['os_users']['im_user']['gid'] = 'imgroup'
  default['im']['os_users']['im_user']['ldap_user'] = 'false'
  default['im']['os_users']['im_user']['comment'] = 'IM Group mode'
  default['im']['os_users']['im_user']['home'] = '/home/imuser'
  default['im']['os_users']['im_user']['shell'] = '/bin/bash'

when 'admin'
  default['im']['os_users']['im_user']['name'] = 'root'
  default['im']['os_users']['im_user']['gid'] = node['root_group']
  default['im']['os_users']['im_user']['ldap_user'] = 'false'
  default['im']['os_users']['im_user']['comment'] = 'IM Admin mode'
  default['im']['os_users']['im_user']['home'] = '/root'
  default['im']['os_users']['im_user']['shell'] = '/bin/bash'

end

#-------------------------------------------------------------------------------
# Landscaper compatibility attributes
#-------------------------------------------------------------------------------

# <>  The stack id
default['ibm_internal']['stack_id'] = ''

# <>  The stack name
default['ibm_internal']['stack_name'] = ''

# <>  List of roles on the node
default['ibm_internal']['roles'] = ''

# <>  The vault name for this stack
default['ibm_internal']['vault']['name'] = ''

# <>  The vault item which will contain the secrets
default['ibm_internal']['vault']['item'] = ''

# <>  The vault name for this cookbook
default['im']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['im']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']
