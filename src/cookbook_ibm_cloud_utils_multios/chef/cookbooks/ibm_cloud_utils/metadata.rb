name             'ibm_cloud_utils'
maintainer       'IBM Corp'
maintainer_email ''
license          'Copyright IBM Corp. 2016, 2017'
description      'LWRPs repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
provides         'ibm_cloud_utils'
supports         'linux'
supports         'windows'
description <<-EOH


## DESCRIPTION
Cookbook that keeps the common utilities.

## Platform Pre-Requisites
* Linux YUM Repository - An onsite linux YUM Repsoitory is required.

# Resources

* [ibm_cloud_utils_cpuno](#ibm_cloud_utils_cpuno) - Check available number of CPUs.
* [ibm_cloud_utils_freespace](#ibm_cloud_utils_freespace) - Check free space under a path.
* [ibm_cloud_utils_supported_os_check](#ibm_cloud_utils_supported_os_check) - Verify whether pattern is supported on the operating system of the vm.
* [ibm_cloud_utils_ibm_cloud_yum](#ibm_cloud_utils_ibm_cloud_yum) - Install both 32-bit and 64-bit versions of a package in one yum command.
* [ibm_cloud_utils_im_repo](#ibm_cloud_utils_im_repo) - Check if a package exists in IM repository
* [ibm_cloud_utils_increasepagefilesize](#ibm_cloud_utils_increasepagefilesize) - Increase the Pagefile size in MB by value passed as an argument
* [ibm_cloud_utils_lvm_logical_volume](#ibm_cloud_utils_lvm_logical_volume) - Create a logical volume if the VG has enough free space.
* [ibm_cloud_utils_lvm_physical_volume](#ibm_cloud_utils_lvm_physical_volume) - Create a physical volume assuming that the specified disk is available on the VM.
* [ibm_cloud_utils_lvm_volume_group](#ibm_cloud_utils_lvm_volume_group) - Create a volume group using an existing physical volume
* [ibm_cloud_utils_ram](#ibm_cloud_utils_ram) - Check available RAM in MBs.
* [ibm_cloud_utils_selinux](#ibm_cloud_utils_selinux) - Enables or disabled SELinux.
* [ibm_cloud_utils_ssh_util](#ibm_cloud_utils_ssh_util) - Resource for either executing a command over SSH or copying a TEXT!!!!1111 file over SSH
* [ibm_cloud_utils_sw_repo](#ibm_cloud_utils_sw_repo) - Check if a package exists in software repository
* [ibm_cloud_utils_tar](#ibm_cloud_utils_tar) - Create tar archive
* [ibm_cloud_utils_unpack](#ibm_cloud_utils_unpack) - Get a packed file (zip, tar, tar.gz, tar.bz2, tgz, Z) over HTTP, FTP or local file system and unpacks it into the **target_dir**.
* [ibm_cloud_utils_webdav](#ibm_cloud_utils_webdav) - Used to upload/download files to/from WeDAV server
* [ibm_cloud_utils_zip](#ibm_cloud_utils_zip) - Create zip archive on Windows
* [ibm_cloud_utils_ibm_cloud_sysctl](#ibm_cloud_utils_ibm_cloud_sysctl) - Apply or remove sysctl parameter on linux
* [ibm_cloud_utils_hostsfile_update](#ibm_cloud_utils_hostsfile_update) - Update the etc/hosts file of the vm.


## ibm_cloud_utils_cpuno

Check available number of CPUs. If lower then **required** chef-client will exit with **error_message**.
If **continue** is set to true the chef will continue to run.

### Actions

- check: used to check available number of CPUs.

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>required</code></td>
    <td>Required number of CPUs</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>error_message</code></td>
    <td>The error message used if the available number of CPUs is lower then required</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>continue</code></td>
    <td>If **continue** is set to true the chef will continue to run.</td>
    <td><code>false</code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_cpuno 'check-number-of-cpus' do
  required 2
  continue true
  action :check
  error_message 'Please make sure you have at least 2 CPUs available'
end
```


## ibm_cloud_utils_freespace

Check free space under a path. If space is lower then **required_space** chef-client will exit with **error_message**.
If **continue** is set to true the chef will continue to run.

### Actions

- check: used to check free space under a path.

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>path</code></td>
    <td></td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>required_space</code></td>
    <td>Required free space</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>error_message</code></td>
    <td>The error message used if the free space is lower then required</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>continue</code></td>
    <td>If **continue** is set to true the chef will continue to run.</td>
    <td><code>false</code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_freespace 'check-tmp-freespace' do
  path '/tmp'
  required_space 2048
  continue true
  action :check
  error_message 'Please make sure you have at least 2GB free space under /tmp'
end
```

## ibm_cloud_utils_hostsfile_update

Update the /etc/hosts file with hosts file information.

### Actions

- updateshosts: Update the /etc/hosts file with hosts file information..

### Usage

```
ibm_cloud_utils_hostsfile_update 'update_the_etc_hosts_file' do
  action :updateshosts
end
```

## ibm_cloud_utils_supported_os_check

Validate whether pattern is supprted on the operating system of the vm as a Pre-Requisites check before install.

### Actions

- check: used to opearting system support.

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>supported_os_list</code></td>
    <td></td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>error_message</code></td>
    <td>The error message used if the free space is lower then required</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_supported_os_check 'check-supported-opeartingsystem-for-pattern' do
  supported_os_list node['wasnd']['OS_supported']
  action :check
  error_message "Pattern is not supported on this opearting system"
end
```


## ibm_cloud_utils_ibm_cloud_yum

Install both 32-bit and 64-bit versions of a package in one yum command.

### Actions

- install: Default. Install packages.
- upgrade: Install packages and/or ensure that packages are the latest version.
- purge: Remove packages from your system

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>package_name</code></td>
    <td>The name of the package</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>version</code></td>
    <td>The version of the package</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>options</code></td>
    <td>One (or more) additional options that are passed to the command.</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_ibm_cloud_yum 'install package' do
  package_name 'netpbm'
  version '10.35.58-8.el5'
  action :install
end
```

## ibm_cloud_utils_im_repo

Check if a package exists in IM repository. It will automatically detect the type of IM repository: simple or composite.

### Actions

- check_package: Default. Used to check if a package is included in Im repository

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>repository</code></td>
    <td>The URL of the IM repository</td>
    <td><code>node['ibm']['im_repo']</code></td>
  </tr>
  <tr>
    <td><code>im_repo_self_signed_cert</code></td>
    <td>If the IM repo is secured but it uses a self signed SSL certificate this should be set to "true"</td>
    <td><code>node['ibm']['im_repo_self_signed_cert']</code></td>
  </tr>
  <tr>
    <td><code>im_repo_user</code></td>
    <td>User used to access IM repo if this repo is secured and authentication is required This is not required if IM repo is not secured.</td>
    <td><code>node['ibm']['im_repo_user']</code></td>
  </tr>
  <tr>
    <td><code>secure_repo</code></td>
    <td>If the IM repo is public this should be set to "false"</td>
    <td><code>'true'</code></td>
  </tr>
  <tr>
    <td><code>offering_id</code></td>
    <td>Offering ID of the package. This is a mandatory attribute</td>
    <td><code>'true'</code></td>
  </tr>
  <tr>
    <td><code>offering_version</code></td>
    <td>Offering version of the package. If this is not provided this resource will try to find at least one package with the provided offering id.</td>
    <td><code>nil</code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_im_repo 'com.ibm.websphere.IHS.v85'
```
```
ibm_cloud_utils_im_repo 'Check package' do
  offering_id 'com.ibm.websphere.IHS.v85'
  action :check_package
end
```
```
ibm_cloud_utils_im_repo 'Check package' do
  im_repo_self_signed_cert 'true'
  offering_id 'com.ibm.websphere.IHS.v85'
  offering_version '8.5.5000.20130514_1044'
  action :check_package
end
```


## ibm_cloud_utils_increasepagefilesize

Increase the Pagefile size in MB by value passed as an argument

### Actions

- run: used to increase the Pagefile size

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>increment_size</code></td>
    <td>Pagefile size that will be added to the existing size</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_increasepagefilesize "Increment-Pagefile-Size" do
  increment_size 256
  action :run
end
```


## ibm_cloud_utils_lvm_logical_volume

Create a logical volume if the VG has enough free space. lv_size must be specified in this format <size><sufix>. (e.g. 2G or 512M).
The following values are supported for <suffix>: k|K|m|M|g|G|t|T.

### Actions

- create: used to create a logical volume

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>lv_name</code></td>
    <td>The name for the new logical volume.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>vg_name</code></td>
    <td>The name for the volume group.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>lv_size</code></td>
    <td>Gives the size to allocate for the new logical volume.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>filesystem</code></td>
    <td>Specify the type of filesystem to be built.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>mountpoint</code></td>
    <td>The directory (or path) in which the device is to be mounted.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>options</code></td>
    <td>An array or string that contains mount options.</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_lvm_logical_volume 'Creating logical volume' do
  vg_name 'vgname'
  mountpoint '/path/to/directory'
  lv_name 'lvname'
  filesystem 'ext4'
  lv_size '1g'
  options 'rw'
  action :create
end
```

## ibm_cloud_utils_lvm_physical_volume

Create a physical volume assuming that the specified disk is available on the VM.

### Actions

- create: used to create a physical volume

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>disk</code></td>
    <td>The name of the disk.</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_lvm_physical_volume 'Creating physical volume' do
  disk 'sdb'
  action :create
end
``````

## ibm_cloud_utils_lvm_volume_group

Create a volume group using an existing physical volume

### Actions

- create: used to create a volume group

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>pv_name</code></td>
    <td>The name for the physical volume</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>vg_name</code></td>
    <td>The name for the volume group.</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_lvm_volume_group 'Creating volume group' do
  pv_name '/dev/sdb'
  vg_name 'vgname'
  action :create
end
```

## ibm_cloud_utils_ram

Check available RAM in MBs. If lower then **required** chef-client will exit with **error_message**.
If **continue** is set to true the chef will continue to run.

### Actions

- check: used to check available RAM in MBs.

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>required</code></td>
    <td>Required RAM size in MBs</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>error_message</code></td>
    <td>The error message used if the available RAM in MBs is lower then required</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>continue</code></td>
    <td>If **continue** is set to true the chef will continue to run.</td>
    <td><code>false</code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_ram 'check-available-RAM' do
  required 2048
  continue true
  action :check
  error_message 'Please make sure you have at least 2048 MBs available'
end
```

## ibm_cloud_utils_selinux

Enables or disables SELinux.

### Actions

- enforcing: Set selinux to enforcing
- enabled: used to enable selinux (it will be set to enforcing)
- permissive: Set selinux to permissive
- disabled: used to disable selinux

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>status</code></td>
    <td>This is currenlty not used!</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_selinux 'SELinux enabled' do
  action: enforcing
end
```

```
ibm_cloud_utils_selinux 'SELinux disabled' do
  action: disabled
end
```

## ibm_cloud_utils_ssh_util

Resource for either executing a command over SSH or copying a TEXT!!!!1111 file over SSH (No external net/scp required).
Since only the included gems in chef client are used, this should be fairly portable and should work from Windows clients as well.

### Actions

- copy: Default. Used to copy a file
- exec: Used to execute a command with conditions

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>server</code></td>
    <td>remote server</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>user</code></td>
    <td>login user</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>password</code></td>
    <td>the password to use to login</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>source</code></td>
    <td>source file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>target</code></td>
    <td>target file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>command</code></td>
    <td>the command that will be executed on the remote host</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>only_if_check</code></td>
    <td>only if condition</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>not_if_check</code></td>
    <td>not if condition</td>
    <td><code>nil</code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_ssh_util "Copy a file" do
  server 'some_server'
  user   'root'
  password 'passw0rd'
  source '/tmp/some_local_file'
  target '/tmp/some_remote_file'
  action :copy
end
```

```
ibm_cloud_utils_ssh_util "Executing some command with conditions" do
  server 'some_server'
  user   'root'
  password 'passw0rd'
  command "touch /tmp/some_file"
  only_if_check "ps -ef | grep -i java | grep -v grep"
  not_if_check "ps -ef | grep -i whatever| grep -v grep"
  action :exec
end
```

## ibm_cloud_utils_sw_repo

Check if a package exists in software repository.

### Actions

- check_package: Default. Used to check if a package is included in software repository

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>repository</code></td>
    <td>The URL of the software repository</td>
    <td><code>node['ibm']['sw_repo']</code></td>
  </tr>
  <tr>
    <td><code>sw_repo_self_signed_cert</code></td>
    <td>If the software repo is secured but it uses a self signed SSL certificate this should be set to "true"</td>
    <td><code>node['ibm']['sw_repo_self_signed_cert']</code></td>
  </tr>
  <tr>
    <td><code>sw_repo_user</code></td>
    <td>User used to access software repo if this repo is secured and authentication is required. This is not required if software repo is not secured.</td>
    <td><code>node['ibm']['sw_repo_user']</code></td>
  </tr>
  <tr>
    <td><code>secure_repo</code></td>
    <td>If the software repo is public this should be set to "false"</td>
    <td><code>'true'</code></td>
  </tr>
  <tr>
    <td><code>sw_repo_path</code></td>
    <td>The repository path where the package should be located</td>
    <td><code>'/'</code></td>
  </tr>
  <tr>
    <td><code>package</code></td>
    <td>The name of the package</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_sw_repo "DB2_Svr_10.5.0.8_Linux_x86-64.tar.gz" do
  sw_repo_self_signed_cert 'true'
  sw_repo_path '/db2/v105/base'
end
```
```
ibm_cloud_utils_sw_repo "check_package" do
  package 'DB2_Svr_10.5.0.8_Linux_x86-64.tar.gz'
  sw_repo_self_signed_cert 'true'
  sw_repo_path '/db2/v105/base'
  action :check_package
end
```


## ibm_cloud_utils_tar

Resource for creating a tar archive

### Actions

- tar: Default. Used to create a tar archive


### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>source</code></td>
    <td>Source file</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>target_tar</code></td>
    <td>Target tar</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_tar "Create_tar_file" do
  source "/opt/product/log/install.log"
  target_tar "/tmp/archive.tar"
end
```

## ibm_cloud_utils_unpack

Get a packed file (zip, tar, tar.gz, tar.bz2, tgz, Z) over HTTP, FTP or local file system and unpacks it into the **target_dir**.
**remove_local** if set to true deletes the packed file from **target_dir** after unpacking.
**checksum** is optional, but highly recommended for HTTP & FTP.

### Actions

- unpack: Default. Used to download and unpack an archive.


### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>source</code></td>
    <td>URL of the source file</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>target_dir</code></td>
    <td>Target dirctory where the archive will be unpacked</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>target_file</code></td>
    <td>Name of the target file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>checksum</code></td>
    <td>The checksum of the source file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>owner</code></td>
    <td>The user that owns of the target file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>group</code></td>
    <td>The group that owns the target file</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>mode</code></td>
    <td>permissions for the target file</td>
    <td><code>0o755</code></td>
  </tr>
  <tr>
    <td><code>remove_local</code></td>
    <td>Set this to true if you want to remove the archive from the local machine after unpack</td>
    <td><code>'false'</code></td>
  </tr>
  <tr>
    <td><code>secure_repo</code></td>
    <td>Flag for secure repository. If a public non-secure repository is used this should be set to 'false'</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>repo_self_signed_cert</code></td>
    <td>If the software repostory uses a self signed SSL certificate this should be set to 'true'</td>
    <td><code>'false'</code></td>
  </tr>
  <tr>
    <td><code>vault_name</code></td>
    <td>Vault name. This vault should include the password of sw_repo_user</td>
    <td><code>node['ibm_internal']['vault']['name']</code></td>
  </tr>
  <tr>
    <td><code>vault_item</code></td>
    <td>Vault item name</td>
    <td><code>node['ibm_internal']['vault']['item']</code></td>
  </tr>
  <tr>
    <td><code>sw_repo_user</code></td>
    <td>User to be used to login to software repository</td>
    <td><code>node['ibm']['sw_repo_user']</code></td>
  </tr>
</table>

### Usage

```ruby
  ibm_cloud_utils_unpack 'unpack-sccm-installer' do
    source 'file://installersource'
    target_dir expanddir
    owner 'root'
    group 'root'
    mode '0755'
    checksum node['ibm']['sccm']['installer_checksum']
    remove_local true
  end
```

## ibm_cloud_utils_webdav

Used to upload/download files to/from WebDAV server and to create or delete collections

### Actions

- upload: Default. Used to upload a file to WebDAV server
- download: Used to download a file from WebDAV server
- delete: Used to delete a file from WebDAV server
- create_collection: Used to create a collection on the WebDAV server
- delete_collection: Used to delete a collection from the WebDAV server

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>webdav_server</code></td>
    <td>URL for WebDAV server</td>
    <td><code>node['ibm']['sw_repo'] + '/sharedStorage'</code></td>
  </tr>
  <tr>
    <td><code>sw_repo_self_signed_cert</code></td>
    <td>If the WebDAV server is secured but it uses a self signed SSL certificate this should be set to "true"</td>
    <td><code>node['ibm']['sw_repo_self_signed_cert']</code></td>
  </tr>
  <tr>
    <td><code>sw_repo_user</code></td>
    <td>User used to access WebDAV server if this server is secured and authentication is required. This is not required if WebDAV server is not secured.</td>
    <td><code>node['ibm']['sw_repo_user']</code></td>
  </tr>
  <tr>
    <td><code>secure_repo</code></td>
    <td>If the WebDAV server is public this should be set to "false"</td>
    <td><code>'true'</code></td>
  </tr>
  <tr>
    <td><code>file</code></td>
    <td>The name of the file that will be uploaded/deleted to/from WebDAV server</td>
    <td><code>''</code></td>
  </tr>
  <tr>
    <td><code>download_path</code></td>
    <td>This is the local path where the file will be downloaded from WebDAV server</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>source_path</code></td>
    <td>This is the local path of the file that will be uploaded to WebDAV server</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>collection</code></td>
    <td>Collection that will be used to store the files on the WebDAV server</td>
    <td><code>nil</code></td>
  </tr>
</table>

### Usage
```
ibm_cloud_utils_webdav "create_collection_and_upload_file" do
  file 'upload.txt'
  source_path '/tmp'
  collection 'stack1234'
  sw_repo_self_signed_cert 'true'
  secure_repo 'true'
  action [:create_collection, :upload]
end
```
```
ibm_cloud_utils_webdav "new_collection" do
  collection 'stack1234'
  sw_repo_self_signed_cert 'true'
  secure_repo 'true'
  action :create_collection
end
```
```
ibm_cloud_utils_webdav "upload_file" do
  file 'upload.txt'
  collection 'stack1234'
  source_path '/tmp'
  sw_repo_self_signed_cert 'true'
  secure_repo 'true'
  webdav_server 'https://<hostname>:<port>/sharedStorage/'
  action :upload
end
```
```
ibm_cloud_utils_webdav "download_file" do
  file 'upload.txt'
  collection 'stack1234'
  download_path '/tmp'
  sw_repo_self_signed_cert 'true'
  secure_repo 'true'
  action :download
end
```
```
ibm_cloud_utils_webdav "delete_file" do
  file 'upload.txt'
  collection 'stack1234'
  source_path '/tmp'
  sw_repo_self_signed_cert 'true'
  secure_repo 'true'
  action :delete
end
```
```
ibm_cloud_utils_webdav "delete_collection" do
  collection 'stack1234'
  sw_repo_self_signed_cert 'true'
  secure_repo 'true'
  action :delete_collection
end
```

## ibm_cloud_utils_zip

Resource for creating a zip archive on Windows

### Actions

- zip: Default. Used to create a zip archive on Windows


### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>source</code></td>
    <td>Source file</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>target_zip</code></td>
    <td>Target zip</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_zip "Create_zip_file" do
  source "C:\\product\\log\\install.log"
  target_tar "C:\\Temp\\archive.zip"
end
```

# Methods

* [IBM::IBMHelper.check_free_space](#IBM::IBMHelper.check_free_space) - Check free space under a path.
* [IBM::IBMHelper.get_vault_secret](#IBM::IBMHelper.get_vault_secret) - Get a sensitive data (password) from a Vault server, using an expiring session token
* [Vault::Helper.chef_vault_item](#Vault::Helper.chef_vault_item) - Get a sensitive data (password) from a vault created on the chef server

## IBM::IBMHelper.check_free_space

Check free space under a path. If space is lower then **required_space** chef-client will exit with **error_message**.
If **continue** is set to true the chef will continue to run.


### Usage

```
ruby_block 'check-var-freespace' do
  block do
    IBM::IBMHelper.check_free_space(node, '/var', 1024)
  end
end
```


## IBM::IBMHelper.get_vault_secret

Get a sensitive data (password) from a Vault server, using an expiring session token

### Usage

```
user_password = IBM::IBMHelper.get_vault_secret('https://repo01.company.com:8200', '3d642e21-57f7-ccb1-5ebd-12169ac3f90b', 'dev/node1/admin')
template 'some_template' do
  source 'some_template.erb'
  variables(
    UserPassword: user_password,
    UserName: node['ms']['ftp_server']['name']
  )
end
```

## Vault::Helper.chef_vault_item

Get a sensitive data (password) from a vault created on the chef server

### Usage

```
chef_vault = node['db2']['vault']['name']
encrypted_id = node['db2']['vault']['encrypted_id']

instance_password = chef_vault_item(chef_vault, encrypted_id)['db2']['instance']['instance']['instance_password']
```

```
chef_vault = node['db2']['vault']['name']
encrypted_id = node['db2']['vault']['encrypted_id']

instance_password = Vault::Helper.chef_vault_item(chef_vault, encrypted_id)['db2']['instance']['instance']['instance_password']
```

## ibm_cloud_utils_ibm_cloud_sysctl

Apply or remove a sysctl parameter on Linux

### Actions

- apply: Apply a sysctl parameter
- remove: Remove a sysctl parameter (should be applied after the system is rebooted)

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>key</code></td>
    <td>The sysctl key</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>value</code></td>
    <td>The sysctl value (doesn't apply for remove action)</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>sysctl_file</code></td>
    <td>The sysctl configuration file to use (defaults to /etc/sysctl.d/99-ibm_cloud_sysctl.conf)</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_ibm_cloud_sysctl "apply" do
  key "net.core.rmem_default"
  value "262144"
end

ibm_cloud_utils_ibm_cloud_sysctl "remove" do
  action :remove
  key "net.core.rmem_default"
end

```
## ibm_cloud_utils_ibm_cloud_swap

Apply or remove a swap (file or device) on Linux

### Actions

- create: Create a swap (file or device) to the currently used ones
- enable: Create a swap (file or device) and add it to fstab so it is used permanently
- remove: Remove a swap (file or device) from the currently used ones
- disable: Remove a swap (file or device) from the currently used ones and delete the fstab definition

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>swapfile</code></td>
    <td>The file to use for swap (a regular file or a block device file)</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>size</code></td>
    <td>The size of the swapfile to create (doesn't apply to block devices)</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>label</code></td>
    <td>The swap (file or device) label</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>force</code></td>
    <td>Force the formatting of a block device (defaults to false)</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_ibm_cloud_swap "swap01" do
  action :enable
  swapfile "/swapfile01"
  size "1024"
  label "swap01"
end
ibm_cloud_utils_ibm_cloud_swap "swap01" do
  action :disable
  swapfile "/swapfile01"
  size "1024"
  label "swap01"
end
ibm_cloud_utils_ibm_cloud_swap "swap02" do
  action :create
  swapfile "/dev/loop0"
  label "swap02"
  force true
end
ibm_cloud_utils_ibm_cloud_swap "swap02" do
  action :remove
  swapfile "/dev/loop0"
  label "swap02"
end
```
## ibm_cloud_utils_ibm_cloud_fs

Manipulate a block device on Linux

### Actions

- create: Creates a filesystem on a block device (no partitioning) and mounts it
- enable: Creates a filesystem on a block device, mounts it and sets it up in /etc/fstab
- remove: Unmounts a filesystem
- disable: Unmounts a filesystem and removes it's entry from /etc/fstab

### Attribute Parameters

<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>device</code></td>
    <td>The block device that should be used</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>fstype</code></td>
    <td>The filesystem type (ext2/3/4, xfs)</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>label</code></td>
    <td>The filesystem label</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>mountpoint</code></td>
    <td>The mountpoint directory</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>options</code></td>
    <td>Nonstandard mounting options (defaults to 'defaults')</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>force</code></td>
    <td>Force the formatting of a block device (defaults to false)</td>
    <td><code></code></td>
  </tr>
</table>

### Usage

```
ibm_cloud_utils_ibm_cloud_fs "oradata" do
  action :create
  device "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-1"
  mountpoint "/oradata"
  label "oradata"
  fstype "ext4"
  force true
end
ibm_cloud_utils_ibm_cloud_fs "oradata" do
  action :enable
  device "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-1"
  mountpoint "/oradata"
  label "oradata"
  fstype "ext4"
  force true
end
ibm_cloud_utils_ibm_cloud_fs "db2data" do
  action :enable
  device "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-2"
  mountpoint "/db2data"
  label "db2data"
  fstype "xfs"
  force true
end
ibm_cloud_utils_ibm_cloud_fs "db2data" do
  action :disable
  device "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-2"
  mountpoint "/db2data"
  label "db2data"
  fstype "xfs"
  force true
end
```

EOH

version '1.0.2'

attribute 'ibm/im_repo',
          :default => '',
          :description => 'IBM Software  Installation Manager Repository URL (https://<hostname/IP>:<port>/IMRepo) ',
          :displayname => 'IBM Software Installation Manager Repository',
          :parm_type => 'pattern',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/im_repo_password',
          :default => '',
          :description => 'IBM Software  Installation Manager Repository Password',
          :displayname => 'IBM Software Installation Manager Repository Password',
          :parm_type => 'none',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :type => 'string'
attribute 'ibm/im_repo_self_signed_cert',
          :default => 'false',
          :description => 'IBM Software  Installation Manager Repository Self Signed Certificate (True/False)',
          :displayname => 'IBM Software Installation Manager Repository Self Signed Certificate (True/False)',
          :parm_type => 'none',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/im_repo_user',
          :default => 'repouser',
          :description => 'IBM Software  Installation Manager Repository username',
          :displayname => 'IBM Software Installation Manager Repository Username',
          :parm_type => 'pattern',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/sw_repo',
          :default => '',
          :description => 'IBM Software Repo Root (https://<hostname>:<port>)',
          :displayname => 'IBM Software Repo Root',
          :parm_type => 'pattern',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/sw_repo_auth',
          :default => 'true',
          :description => 'IBM Software  Software Manager  Authentication Enabled',
          :displayname => 'IBM Software Software Repository Authentication Enabled',
          :parm_type => 'none',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/sw_repo_password',
          :default => '',
          :description => 'IBM Software Repo Password',
          :displayname => 'IBM Software Repo Password',
          :parm_type => 'none',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/sw_repo_self_signed_cert',
          :default => 'false',
          :description => 'IBM Software  Software Manager Repository Self Signed Certificate (True/False)',
          :displayname => 'IBM Software Software Repository Self Signed Certificate (True/False)',
          :parm_type => 'none',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ibm/sw_repo_user',
          :default => 'repouser',
          :description => 'IBM Software Repo Username',
          :displayname => 'IBM Software Repo Username',
          :parm_type => 'pattern',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
recipe 'ibm_cloud_utils::default.rb', '
Default recipe (default.rb)
Perform minimal product installation
'
recipe 'ibm_cloud_utils::gather_evidence.rb', '
Default recipe (gather_evidence.rb)
Perform product verification steps
'
recipe 'ibm_cloud_utils::install.rb', '
Default recipe (install.rb)
Perform product installation steps
'
recipe 'ibm_cloud_utils::prereq.rb', '
Default recipe (prereq.rb)
Perform  product prerequisite steps
'
