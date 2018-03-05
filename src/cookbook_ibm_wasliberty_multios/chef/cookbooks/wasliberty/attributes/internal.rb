########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################
####################
# GENERAL SETTINGS
####################

# <> Software repo that contains binaries.
default['ibm']['sw_repo'] = ""

# <> Installer work directory
default['ibm']['temp_dir'] = '/tmp/ibm_cloud'

# <> Installer log directory
default['ibm']['log_dir'] = '/var/log/ibm_cloud'

# <> Temporary location of binaries
default['ibm']['expand_area'] = "#{node['ibm']['temp_dir']}/expand_area"

# <> Evidence Path for Pattern Deployment
default['ibm']['evidence_path'] = node['ibm']['log_dir'] + '/evidence'

# <> Evidence TAR File for Pattern Deployment
default['ibm']['evidence_tar'] = "#{node['ibm']['evidence_path']}/--cookbook_name---#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"

# <> IM repository
default['ibm']['im_repo'] = ""

# <> IM repo user
default['ibm']['im_repo_user'] = 'repouser'

# <> IM repo pass
default['ibm']['im_repo_password'] = ''

# <> repo user
default['ibm']['sw_repo_user'] = 'repouser'

# <> repo pass
default['ibm']['sw_repo_password'] = ''

default['was_liberty']['skip_indexes'] = 'true'


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

# <> Liberty vault name
# <md> attribute 'was_liberty/vault/name',
# <md>          :displayname => 'vault_name',
# <md>          :description => 'The chef vault name',

# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['was_liberty']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
# <md> attribute 'was_liberty/vault/encrypted_id',
# <md>          :displayname => 'vault_encrypted_id',
# <md>          :description => 'The chef vault encrypted_id',

# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['was_liberty']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

####################################
# STATIC SETTINGS - DO NOT MODIFY
####################################

# <> Directory to expand installation & fixpack archives
default['was_liberty']['expand_area'] = node['ibm']['expand_area'] + '/' + 'was_liberty'

# <> The user name for the WAS operating system user.
# default['was_liberty']['os_users'] = {
#   'wasadmin'  =>  {
#     'name' => node['was_liberty']['user'],
#     'gid' => 'wasgrp',
#     'comment' => 'WAS administrative user',
#     'home' => "/home/#{node['was_liberty']['user']}",
#     'shell' => '/bin/bash'
#   }
# }

# <> Install mode which you install software with IBM Installation Manager as an administrator(admin), nonadministrator(nonAdmin), or group(group)
# default['was_liberty']['install_mode'] = 'admin'

if node['was_liberty']['install_user'] == 'root'
  # installation mode
  default['was_liberty']['install_mode'] = 'admin'
  # set additional user parameters
  default['was_liberty']['os_users'] = {
    'wasadmin'  =>  {
      'name' => 'root',
      'gid' => 'root',
      'comment' => 'WAS installation user',
      'home' => '/root',
      'shell' => '/bin/bash'
    }
  }
  # <> Installation location of IBM Installation Manager
  default['was_liberty']['im_install_dir'] = '/opt/IBM/InstallationManager'
  # <> WAS installation directory
  default['was_liberty']['install_dir'] = '/opt/IBM/WebSphere/Liberty'
else
  # installation mode
  default['was_liberty']['install_mode'] = 'nonAdmin'
  # set additional user parameters
  default['was_liberty']['os_users'] = {
    'wasadmin'  =>  {
      'name' => node['was_liberty']['install_user'],
      'gid' => node['was_liberty']['install_grp'],
      'comment' => 'WAS installation user',
      'home' => "/home/#{node['was_liberty']['install_user']}",
      'shell' => '/bin/bash'
    }
  }
  # <> Installation location of IBM Installation Manager
  default['was_liberty']['im_install_dir'] = node['was_liberty']['os_users']['wasadmin']['home'] + '/InstallationManager'
  # <> WAS installation directory
  default['was_liberty']['install_dir'] = node['was_liberty']['os_users']['wasadmin']['home'] + '/opt/IBM/WebSphere/Liberty'
end

# <> IBM Installation Manager profile to be used for installation, based on WAS edition
default['was_liberty']['profile_id'] = {
  'core'  => 'WebSphere Liberty Core',
  'base'  => 'WebSphere Liberty',
  'nd'  => 'WebSphere Liberty ND'
}

# <> IBM Installation Manager offering ID to be used for installation, based on WAS edition
default['was_liberty']['offering_id'] = {
  'core'  => 'com.ibm.websphere.liberty.CORE',
  'base'  => 'com.ibm.websphere.liberty.BASE',
  'nd'    => 'com.ibm.websphere.liberty.ND'
}


# <> WAS installation archives for liberty core v9.0 edition
default['was_liberty']['archive_names']['core'] = {
  'file1'  =>  {
    'filename' =>  'was.repo.16002.liberty.core.zip',
    'sha256'   =>  '5247b9e8ba7eaa14c2d7e8f46ee1e869228adb3b1afec847fc2a8a387f2c6c0e'
  }
}

# # <> IBM SDK, Java Technology Edition, Version 8
default['was_liberty']['archive_names']['java8'] = {
  'file1'  =>  { 'filename' =>  'was.repo.9000.java8_part1.zip',
                 'sha256'   =>  '2eaa032ebca7a5ff2abc54bc891c20420a06d66c874edc211a93c1e93961ee8e' },
  'file2'  =>  { 'filename' =>  'was.repo.9000.java8_part2.zip',
                 'sha256'   =>  '8399caef9fe5390370737c718394f546c7d3300bce65cc70876389ffb233ac63' },
  'file3'  =>  { 'filename' =>  'was.repo.9000.java8_part3.zip',
                 'sha256'   =>  '245ade5bc8c1117b6f32968bf8f5dc4296329aa7114f71ac950a0f07e8e1998e' }
}

#NOTE: download instructions for above archives: http://www-01.ibm.com/support/docview.wss?uid=swg27038625

#<> Generic WAS fixpack filenames
default['was_liberty']['fixpack_names'] = {
  'file1'  =>  { 'filename' =>  node['was_liberty']['fixpack'] +'-WS-LIBERTY-CORE-FP.zip',
                 'sha256' => '3533807e14f1984198d29ae5dbc607e6bd87c54c4c290f41a941ab9ed53a1e4d' }
}

# <> Generic Java 8 fixpack filenames
default['was_liberty']['fixpack_names']['java8'] = {
  'file1'  =>  { 'filename' =>  node['was_liberty']['fixpack_java'] +"-JavaSE-SDK-MultiOS-repo-part1.zip" },
  'file2'  =>  { 'filename' =>  node['was_liberty']['fixpack_java'] +"-JavaSE-SDK-MultiOS-repo-part2.zip" },
  'file3'  =>  { 'filename' =>  node['was_liberty']['fixpack_java'] +"-JavaSE-SDK-MultiOS-repo-part3.zip" }
}

#<> WAS Liberty Asset packages
default['was_liberty']['fixpack_names']['feature_repo'] = {
  'filename' =>  'wlp-featureRepo-' + node['was_liberty']['fixpack'] + '.zip',
  'sha256' => '65afa87aad5cc65daf1a93e1004f7ce826e40d888916760404c6afbb10283455'
}
