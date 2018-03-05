# Cookbook Name:: linux
# Recipe:: attributes/default
#
# Copyright IBM Corp. 2016, 2017
#

############################################################################################################
# STANDARD Environemnt Settings
############################################################################################################

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''

default['ibm']['sw_repo_user'] = ''

default['ibm']['sw_repo_password'] = ''

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
default['ibm']['sw_repo_self_signed_cert'] = 'true'

# <> If a secure Software repo is used and basic authentication is required you should set this to "true"
default['ibm']['sw_repo_auth'] = 'true'

#-------------------------------------------------------------------------------
# Landscaper compatibility attributes
#-------------------------------------------------------------------------------

# <>  The stack id
default['ibm_internal']['stack_id'] = ''
# #<> Stack ID to search on
# force_default['linux']['stack_id'] = node['stack_id']

# <>  The stack name
default['ibm_internal']['stack_name'] = ''

# <>  List of roles on the node
default['ibm_internal']['roles'] = ''

# <>  The vault name for this stack
default['ibm_internal']['vault']['name'] = ''

# <>  The vault item which will contain the secrets
default['ibm_internal']['vault']['item'] = ''

default['linux']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['linux']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

#-------------------------------------------------------------------------------
# <md>attribute 'linux/yum_repositories/repo01/description',
# <md>          :displayname =>  'Description',
# <md>          :description => 'Description of the YUM respository',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Yum Repository 1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/repositoryid',
# <md>          :displayname =>  'Respository ID',
# <md>          :description => 'Repository ID Name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'CAM Repository',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/baseurl',
# <md>          :displayname =>  'Base YUM URL',
# <md>          :description => 'URL For accessing YUM Repository',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'https://xx',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/enabled',
# <md>          :displayname =>  'Enable YUM Repo',
# <md>          :description => 'Enable True/False Flag',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/gpgkey',
# <md>          :displayname =>  'GPG Key for Repository',
# <md>          :description => 'Location of GPG Key',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/gpgcheck',
# <md>          :displayname =>  'Enable GPGCheck Repo',
# <md>          :description => 'GPGCheck True/False Flag',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/sslverify',
# <md>          :displayname =>  'Enable sslverify Repo',
# <md>          :description => 'sslverify True/False Flag',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/yum_repositories/repo01/sslcacert',
# <md>          :displayname =>  'Location of  sslcacert ',
# <md>          :description => 'Location of  sslcacert '',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'

default['linux']['yum_repositories'] = {
  'repo01' => {
    'description' => '',
    'repositoryid' => '',
    'baseurl' => '',
    'enabled' => true,
    'gpgkey' => '',
    'gpgcheck' => true,
    'sslverify' => true,
    'sslcacert' => ''
  }
}

# <md>attribute '$dynamicmaps/linux/filesystems',
# <md>          :$displayname =>  'File Systems',
# <md>          :$key => 'filesystem',
# <md>          :$max => '4',
# <md>          :$count => '0'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/device'
# <md>          :displayname =>  'device',
# <md>          :description => 'Device to mount to, leave blank if unknown, the system will search for it.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/dev/xvdc',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/fstype',
# <md>          :displayname =>  'fstype',
# <md>          :description => 'File System Type',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ext4',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/label',
# <md>          :displayname =>  'label',
# <md>          :description => 'Label of the file system',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'filesystem1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/mountpoint',
# <md>          :displayname =>  'mountpoint',
# <md>          :description => 'Directory to mount to, directory will be created',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/filesystem1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/user',
# <md>          :displayname =>  'user',
# <md>          :description => 'Owner of the mount point.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/group',
# <md>          :displayname =>  'group',
# <md>          :description => 'Group owner of the mount point',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/perms',
# <md>          :displayname =>  'perms',
# <md>          :description => 'Permissions for the mount point.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/options',
# <md>          :displayname =>  'options',
# <md>          :description => 'Advanced options for mounting the disk',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'defaults',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/force',
# <md>          :displayname =>  'force',
# <md>          :description => 'Force the mount true or false',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/filesystems/filesystem($INDEX)/size',
# <md>          :displayname =>  'size',
# <md>          :description => 'Size in GB of the disk',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'

default['linux']['filesystems'] = {
  'filesystem($INDEX)' => {
    'device' => '/dev/xvdc',
    'size' => '10',
    'fstype' => 'ext4',
    'label' => 'filesystem1',
    'mountpoint' => '/var/filesystem1',
    'user' => 'default',
    'group' => 'default',
    'perms' => 'default',
    'options' => 'defaults',
    'force' => 'true'
  }
}

# <md>attribute '$dynamicmaps/linux/physicalvolumes',
# <md>          :$displayname =>  'Physical Volumes',
# <md>          :$key => 'physicalvolume',
# <md>          :$max => '4',
# <md>          :$count => '0'
# <md>attribute '$dynamicmaps/linux/physicalvolumes/physicalvolume($INDEX)/$dynamicmaps/logicalvolumes',
# <md>          :$displayname =>  'Logical Volumes',
# <md>          :$key => 'logicalvolume',
# <md>          :$max => '4',
# <md>          :$count => '0'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/lv_name',
# <md>          :displayname =>  'lv_name',
# <md>          :description => 'Name of the logical volume.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'lv_name',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/filesystem',
# <md>          :displayname =>  'filesystem',
# <md>          :description => 'The stsandard filesystem type.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ext4',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/lv_size',
# <md>          :displayname =>  'lv_size',
# <md>          :description => 'Size of the filesystem, use standard lvm file size format',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10g',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/options',
# <md>          :displayname =>  'options',
# <md>          :description => 'Name of the logical volume.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'rw',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/mountpoint',
# <md>          :displayname =>  'mountpoint',
# <md>          :description => 'Mount Point of the file system attached to the Logical Volume',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/filesystem1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/device',
# <md>          :displayname =>  'device',
# <md>          :description => 'Name of the physical device, eg, /dev/xdba. Leave assign a free device based on size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/vg_name',
# <md>          :displayname =>  'vg_name',
# <md>          :description => 'Name of the Volume Group to be assigned to the Physical Volume.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'vgname',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'linux/physicalvolumes/physicalvolume($INDEX)/size',
# <md>          :displayname =>  'size',
# <md>          :description => 'Size if GB of the device.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'

default['linux']['physicalvolumes'] = {
  'physicalvolume($INDEX)' => {
    'logicalvolumes' => {
      'logicalvolume($INDEX)' => {
        'mountpoint' => '/var/filesystem1',
        'lv_name' => 'lv_name',
        'filesystem' => 'ext4',
        'lv_size' => '49G',
        'options' => 'rw'
      }
    },
    'device' => '',
    'vg_name' => 'vgname',
    'size' => '50'
  }
}
