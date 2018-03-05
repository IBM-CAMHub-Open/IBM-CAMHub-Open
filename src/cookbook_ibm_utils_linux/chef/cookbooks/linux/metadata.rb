name             'linux'
maintainer       'IBM Corp'
maintainer_email ''
license 'Copyright IBM Corp. 2012, 2017'
depends 'ibm_cloud_utils'
version '1.0.2'
supports 'redhat'
description <<-EOH

# Description

The linux cookbook contains features to support the installation and management
of linux virtual machines.



## Operating System Versions Supported

* Redhat Enterprise Linux 7.x
* Redhat Enterprise Linux 6.x

## Use Cases

* Inject host entries into the linux hostfile, based on the nodes deployed.
* Add customer redhat repositories into a deployed image.
* Enable additonal redhat repositories on Amazon AMI's to allow successful deployment of Automation Conent

## Platform Pre-Requisites

* None

## Software Repository

* None

## Customer Repository Example (role contents)
The following is a sample for adding a cusomter repository.

```yaml
"linux": {
  "configure":{
    "yum_repositories": "true"
  },
  "yum_repositories": {
    "repo01": { "description": "Repository Description",
                  "repositoryid": "Name of the Repository",
                  "baseurl": "http://x.x.x.x./redhat/6/",
                  "enabled": true,
                  "gpgkey": "",
                  "gpgcheck": true,
                  "sslverify": true,
                  "sslcacert": ""
                }
  }
}

```
EOH

attribute 'linux/filesystems/filesystem($INDEX)/device',
          :default => '/dev/xvdc',
          :description => 'Device to mount to, leave blank if unknown, the system will search for it.',
          :displayname => 'device',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/force',
          :default => 'true',
          :description => 'Force the mount true or false',
          :displayname => 'force',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/fstype',
          :default => 'ext4',
          :description => 'File System Type',
          :displayname => 'fstype',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/group',
          :default => 'default',
          :description => 'Group owner of the mount point',
          :displayname => 'group',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/label',
          :default => 'filesystem1',
          :description => 'Label of the file system',
          :displayname => 'label',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/mountpoint',
          :default => '/var/filesystem1',
          :description => 'Directory to mount to, directory will be created',
          :displayname => 'mountpoint',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/options',
          :default => 'defaults',
          :description => 'Advanced options for mounting the disk',
          :displayname => 'options',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/perms',
          :default => 'default',
          :description => 'Permissions for the mount point.',
          :displayname => 'perms',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/size',
          :default => 'true',
          :description => 'Size in GB of the disk',
          :displayname => 'size',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/filesystems/filesystem($INDEX)/user',
          :default => 'default',
          :description => 'Owner of the mount point.',
          :displayname => 'user',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/device',
          :default => '',
          :description => 'Name of the physical device, eg, /dev/xdba. Leave assign a free device based on size',
          :displayname => 'device',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/filesystem',
          :default => 'ext4',
          :description => 'The stsandard filesystem type.',
          :displayname => 'filesystem',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/lv_name',
          :default => 'lv_name',
          :description => 'Name of the logical volume.',
          :displayname => 'lv_name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/lv_size',
          :default => '10g',
          :description => 'Size of the filesystem, use standard lvm file size format',
          :displayname => 'lv_size',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/mountpoint',
          :default => '/var/filesystem1',
          :description => 'Mount Point of the file system attached to the Logical Volume',
          :displayname => 'mountpoint',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/logicalvolumes/logicalvolume($INDEX)/options',
          :default => 'rw',
          :description => 'Name of the logical volume.',
          :displayname => 'options',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/size',
          :default => '10',
          :description => 'Size if GB of the device.',
          :displayname => 'size',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/physicalvolumes/physicalvolume($INDEX)/vg_name',
          :default => 'vgname',
          :description => 'Name of the Volume Group to be assigned to the Physical Volume.',
          :displayname => 'vg_name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/baseurl',
          :default => 'https://xx',
          :description => 'URL For accessing YUM Repository',
          :displayname => 'Base YUM URL',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/description',
          :default => 'Yum Repository 1',
          :description => 'Description of the YUM respository',
          :displayname => 'Description',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/enabled',
          :default => 'true',
          :description => 'Enable True/False Flag',
          :displayname => 'Enable YUM Repo',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'boolean'
attribute 'linux/yum_repositories/repo01/gpgcheck',
          :default => 'true',
          :description => 'GPGCheck True/False Flag',
          :displayname => 'Enable GPGCheck Repo',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'boolean'
attribute 'linux/yum_repositories/repo01/gpgkey',
          :default => '',
          :description => 'Location of GPG Key',
          :displayname => 'GPG Key for Repository',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/repositoryid',
          :default => 'CAM Repository',
          :description => 'Repository ID Name',
          :displayname => 'Respository ID',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'linux/yum_repositories/repo01/sslcacert',
          :description => 'Location of  sslcacert ',
          :displayname => 'Location of  sslcacert '
attribute 'linux/yum_repositories/repo01/sslverify',
          :default => 'true',
          :description => 'sslverify True/False Flag',
          :displayname => 'Enable sslverify Repo',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'boolean'
recipe 'linux::cleanup.rb', '
Left Empty on purpose, not used in cookbook.
'
recipe 'linux::create_fs.rb', '
Create 1..n disks and mount based on the ibm_cloud_fs resource
'
recipe 'linux::create_lvm.rb', '
Create a series of physical volumes, volume groups and logical volumes
'
recipe 'linux::default.rb', '
Executes the linux-utils role.
'
recipe 'linux::gather_evidence.rb', '
Left Empty on purpose, not used in cookbook.
'
recipe 'linux::install.rb', '
Left Empty on purpose, not used in cookbook.
'
recipe 'linux::prereq.rb', '
Install prequisite packages on Linux distro
'
recipe 'linux::test_kitchen_fix.rb', '
Install net-tools for inspec testing of port numbers.
'
recipe 'linux::yumrepo.rb', '
Create xxx.repo files on a redhat server
'
