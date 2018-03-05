Linux Cookbook
==============


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


Requirements
------------

### Platform:

* Redhat

### Cookbooks:

* ibm_cloud_utils

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['device']</code></td>
    <td>Device to mount to, leave blank if unknown, the system will search for it.</td>
    <td><code>/dev/xvdc</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['force']</code></td>
    <td>Force the mount true or false</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['fstype']</code></td>
    <td>File System Type</td>
    <td><code>ext4</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['group']</code></td>
    <td>Group owner of the mount point</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['label']</code></td>
    <td>Label of the file system</td>
    <td><code>filesystem1</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['mountpoint']</code></td>
    <td>Directory to mount to, directory will be created</td>
    <td><code>/var/filesystem1</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['options']</code></td>
    <td>Advanced options for mounting the disk</td>
    <td><code>defaults</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['perms']</code></td>
    <td>Permissions for the mount point.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['size']</code></td>
    <td>Size in GB of the disk</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['filesystems']['filesystem($INDEX)']['user']</code></td>
    <td>Owner of the mount point.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['device']</code></td>
    <td>Name of the physical device, eg, /dev/xdba. Leave assign a free device based on size</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['logicalvolumes']['logicalvolume($INDEX)']['filesystem']</code></td>
    <td>The stsandard filesystem type.</td>
    <td><code>ext4</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['logicalvolumes']['logicalvolume($INDEX)']['lv_name']</code></td>
    <td>Name of the logical volume.</td>
    <td><code>lv_name</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['logicalvolumes']['logicalvolume($INDEX)']['lv_size']</code></td>
    <td>Size of the filesystem, use standard lvm file size format</td>
    <td><code>10g</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['logicalvolumes']['logicalvolume($INDEX)']['mountpoint']</code></td>
    <td>Mount Point of the file system attached to the Logical Volume</td>
    <td><code>/var/filesystem1</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['logicalvolumes']['logicalvolume($INDEX)']['options']</code></td>
    <td>Name of the logical volume.</td>
    <td><code>rw</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['size']</code></td>
    <td>Size if GB of the device.</td>
    <td><code>10</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['physicalvolumes']['physicalvolume($INDEX)']['vg_name']</code></td>
    <td>Name of the Volume Group to be assigned to the Physical Volume.</td>
    <td><code>vgname</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['baseurl']</code></td>
    <td>URL For accessing YUM Repository</td>
    <td><code>https://xx</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['description']</code></td>
    <td>Description of the YUM respository</td>
    <td><code>Yum Repository 1</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['enabled']</code></td>
    <td>Enable True/False Flag</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['gpgcheck']</code></td>
    <td>GPGCheck True/False Flag</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['gpgkey']</code></td>
    <td>Location of GPG Key</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['repositoryid']</code></td>
    <td>Repository ID Name</td>
    <td><code>CAM Repository</code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['sslcacert']</code></td>
    <td>Location of  sslcacert </td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['linux']['yum_repositories']['repo01']['sslverify']</code></td>
    <td>sslverify True/False Flag</td>
    <td><code>true</code></td>
  </tr>
</table>

Recipes
-------

### linux::cleanup.rb


Left Empty on purpose, not used in cookbook.


### linux::create_fs.rb


Create 1..n disks and mount based on the ibm_cloud_fs resource


### linux::create_lvm.rb


Create a series of physical volumes, volume groups and logical volumes


### linux::default.rb


Executes the linux-utils role.


### linux::gather_evidence.rb


Left Empty on purpose, not used in cookbook.


### linux::install.rb


Left Empty on purpose, not used in cookbook.


### linux::prereq.rb


Install prequisite packages on Linux distro


### linux::test_kitchen_fix.rb


Install net-tools for inspec testing of port numbers.


### linux::yumrepo.rb


Create xxx.repo files on a redhat server



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2012, 2017

