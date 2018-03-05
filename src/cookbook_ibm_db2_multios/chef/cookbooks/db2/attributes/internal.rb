#
# Cookbook Name:: db2
# attributes :: internal
#
# Copyright IBM Corp. 2017, 2017

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
default['ibm']['sw_repo_self_signed_cert'] = "false"

# <> If a secure Software repo is used and basic authentication is required you should set this to "true"
default['ibm']['sw_repo_auth'] = "true"

# <> Skip indexes
force_override['db2']['skip_indexes'] = true

normal['db2']['base_version'] = '0.0.0.0' if node['db2']['base_version'].casecmp('none').zero?

# <> Wrap base/fp versions to internal versioning
force_override['db2']['version'] = if node['db2']['base_version'] == '0.0.0.0'
                                     node['db2']['fp_version'].split('.')[0, 2].join('.')
                                   else
                                     node['db2']['base_version'].split('.')[0, 2].join('.')
                                   end
force_override['db2']['included_modpack'] = node['db2']['base_version'].split('.')[2]
force_override['db2']['included_fixpack'] = node['db2']['base_version'].split('.')[3]
force_override['db2']['modpack'] = node['db2']['fp_version'].split('.')[2]

case node['platform_family']
when 'rhel'
  force_override['db2']['fixpack'] = if node['db2']['fp_version'] == node['db2']['base_version']
                                       '0'
                                     else
                                       node['db2']['fp_version'].split('.')[3]
                                     end
when 'debian'
  force_override['db2']['fixpack'] = node['db2']['fp_version'].split('.')[3]
end

# <> Supported DB2 versions
force_override['db2']['supported_versions'] = ['10.5', '11.1']

# <> Base package repo path
force_override['db2']['sw_repo_path'] = '/db2/v' + node['db2']['version'].delete('.') + '/base'

# <> Fixpack package repo path
force_override['db2']['fp_repo_path'] = '/db2/v' + node['db2']['version'].delete('.') + '/maint'

# <> License package repo path
force_override['db2']['sw_license_path'] = '/db2/v' + node['db2']['version'].delete('.') + '/license'

# <> License zip package file name
force_default['db2']['license_package'] = "DB2_ESE_AUSI_Activation_11.1.zip"

case node['os']
when 'linux'
  case node['kernel']['machine']
  when 'x86_64'
    default['db2']['arch'] = 'x86-64'
    # <> DB2 Version 10.5.0.3, 10.5.0.8
    force_override['db2']['archive_names'] = {
      '10.5.0.3' => { 'filename' => 'DB2_Svr_' + node['db2']['version'] + '.' + node['db2']['included_modpack'] + '.'+ node['db2']['included_fixpack'] + '_Linux_' + node['db2']['arch'] + '.tar.gz',
                      'sha256' => 'd5844d395c66470f39db13ba2491b2036c2d6b50e89c06d46f3d83f4b6f093a7' },
      '10.5.0.8' => { 'filename' => 'DB2_Svr_' + node['db2']['version'] + '.' + node['db2']['included_modpack'] + '.'+ node['db2']['included_fixpack'] + '_Linux_' + node['db2']['arch'] + '.tar.gz',
                      'sha256' => '79233751b83a0acde01b84bbd506b8fe917a29a4ed08852ae821090ce2fc0256' },
      '11.1.0.0' => { 'filename' => 'DB2_Svr_' + node['db2']['version'] + '_Linux_' + node['db2']['arch'] + '.tar.gz', #~ip_checker
                      'sha256' => '635f1b64eb48ecfd83aface91bc4b99871f12b7d5c41e7aa8f8b3d275bcb7f04' }
    }
    # <> DB2 Fixpack package
    force_override['db2']['fixpack_names'] = {
      '10.5'  => { 'filename' => 'v' + node['db2']['version'] + 'fp' + node['db2']['fixpack'] + '_linuxx64_server_t.tar.gz' },
      '11.1'  => { 'filename' => 'v' + node['db2']['version']+ '.' + node['db2']['modpack'] + 'fp' + node['db2']['fixpack'] + '_linuxx64_server_t.tar.gz' }
    }
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
  default['ibm']['evidence_zip'] = "#{node['ibm']['evidence_path']}/db2-#{node['hostname']}.tar"
  # <> A temporary directory used for the extraction of installation files
  force_override['db2']['expand_area'] = node['ibm']['expand_area'] + '/db2'

  case node['platform_family']
  when 'rhel'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['db2']['os_libraries'] = %w(cpp compat-libstdc++-33 compat-libstdc++-33.i686 pam.i686 gcc gcc-c++ libaio libstdc++.i686 libstdc++ kernel-devel ksh nfs-utils openssh openssh-server pam redhat-lsb sg3_utils)
    end
  when 'debian'
    # <> Override base version (installing directly from fixpack)
    force_override['db2']['base_version'] = "0.0.0.0"
    case node['kernel']['machine']
    when 'x86_64'
      force_default['db2']['os_libraries'] = %w(cpp gcc ksh openssh-server rpm unzip binutils libaio1 libnuma1 libpam0g:i386 libx32stdc++6)
    end
  end
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
  default['ibm']['evidence_zip'] = "#{node['ibm']['evidence_path']}/db2-#{node['hostname']}.zip"
  # <> A temporary directory used for the extraction of installation files
  force_override['db2']['expand_area'] = node['ibm']['expand_area'] + '\\db2'
end

# <> Directory where the installation script can be found after the base package is extracted
default['db2']['base_dir'] = node['db2']['expand_area'] + '/server'

# <> Directory where the fixpack installation script can be found after the fixpack package is extracted
default['db2']['fp_dir'] = node['db2']['expand_area'] + '/server_t'

# <> kernel max semaphores per array
default['db2']['kernel_sem_SEMMSL'] = '250'

# <> kernel max number of arrays
default['db2']['kernel_sem_SEMMNI'] = 256 * node['memory']['total'].sub(/kb/i, '').to_i / 1024 / 1024

# <> kernel max semaphores system wide
default['db2']['kernel_sem_SEMMNS'] = '256000'

# <> kernel max ops per semop call
default['db2']['kernel_sem_SEMOPM'] = '32'

# <> Linux kernel parameters (enforced minimum settings)
default['db2']['kernel'] = {
  'kernel.msgmni' => node['memory']['total'].sub(/kb/i, '').to_i / 1024,
  'kernel.msgmax' => '65536',
  'kernel.msgmnb' => '65536',
  'kernel.shmmni' => 256 * node['memory']['total'].sub(/kb/i, '').to_i / 1024 / 1024,
  'kernel.shmall' => 2 * shell_out!("getconf PAGESIZE").stdout.to_i * 1024,
  'kernel.shmmax' => node['memory']['total'].sub(/kb/i, '').to_i * 1024,
  'kernel.sem' => node['db2']['kernel_sem_SEMMSL'].to_s + ' ' + node['db2']['kernel_sem_SEMMNS'].to_s + ' ' + node['db2']['kernel_sem_SEMOPM'].to_s + ' ' + node['db2']['kernel_sem_SEMMNI'].to_s
}

# <> ulimit recommended values
force_override['db2']['ulimit'] = {
  'data' => 'unlimited',
  'nofile' => '65536',
  'fsize' => 'unlimited'
}

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


default['db2']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['db2']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']
