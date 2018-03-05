Oracledb Cookbook
=================

Oracle Enterprise Edition DB

Requirements
------------

### Platform:

* Rhel (>= 7.0)

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
    <td><code>node['oracledb']['SID']</code></td>
    <td>Name to identify a specific instance of a running Oracle database</td>
    <td><code>orcl</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['data_mount']</code></td>
    <td>Mount point directory for the file system that contains the Oracle software.</td>
    <td><code>/u01</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['install_group']</code></td>
    <td>Oracle OS Inventory Group</td>
    <td><code>oinstall</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['language']</code></td>
    <td>Oracle Install Language</td>
    <td><code>en</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['os_users']['oracle']['comment']</code></td>
    <td>Oracle OS User comment</td>
    <td><code>Oracle administrative user</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['os_users']['oracle']['gid']</code></td>
    <td>Oracle OS User gid</td>
    <td><code>dba</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['os_users']['oracle']['home']</code></td>
    <td>Oracle OS User home</td>
    <td><code>/home/oracle</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['os_users']['oracle']['ldap_user']</code></td>
    <td>Oracle ldap_user</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['os_users']['oracle']['name']</code></td>
    <td>Oracle Operating System Username</td>
    <td><code>oracle</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['os_users']['oracle']['shell']</code></td>
    <td>Oracle OS User shell</td>
    <td><code>/bin/bash</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['port']</code></td>
    <td>Listening port to be configured in Oracle</td>
    <td><code>1521</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['release_patchset']</code></td>
    <td>Identifier of patch set to apply to Oracle for improvement and bug fix</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['security']['sys_pw']</code></td>
    <td>Change the password for SYS user</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['security']['system_pw']</code></td>
    <td>Change the password for SYSTEM user</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['swap_file_size_mb']</code></td>
    <td>Swap size in MB</td>
    <td><code>-1</code></td>
  </tr>
  <tr>
    <td><code>node['oracledb']['version']</code></td>
    <td>Version of Oracle DB to be installed</td>
    <td><code>v12c</code></td>
  </tr>
</table>

Recipes
-------

### oracledb::cleanup.rb


Cleanup recipe (cleanup.rb)
This recipe will remove any temporary installation files created as part of the automation.


### oracledb::config_asm.rb


Installation recipe (config_asm.rb)
This recipe preforms the post installation operation of ASM


### oracledb::dbca.rb


Create RDBMS recipe (dbca.rb)
This recipe will congire Database.


### oracledb::default.rb


Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.


### oracledb::fixpack.rb


Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.


### oracledb::gather_evidence.rb


Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.


### oracledb::harden.rb


Product hardening recipe (harden.rb)
This recipe performs security hardening tasks.


### oracledb::install.rb


Installation recipe (install.rb)
This recipe performs the product installation.


### oracledb::install_grid.rb


Installation recipe (install_grid.rb)
This recipe performs the Grid product installation.


### oracledb::prereq.rb


Installation recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.


### oracledb::prereq_asm_disks.rb


Installation recipe (prereq_asm_disks.rb)
This recipe configures the operating prerequisites for the ASM.


### oracledb::services.rb


Installation recipe (services.rb)
This recipe creates and starts database services.



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2017, 2017

