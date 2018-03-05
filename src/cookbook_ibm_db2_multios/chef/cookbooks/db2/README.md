Db2 Cookbook
============

## DESCRIPTION

The DB2 cookbook contains features and functions to support the installation, configuration, and management of IBM DB2.

## Platforms Support

* RHEL 6.x
* RHEL 7.x
* Ubuntu Server 14.04 or greater

## Versions

* IBM DB2 Enterprise Server Edition 10.5 (except on Ubuntu 16+)
* IBM DB2 Enterprise Server Edition 11.1

## Use Cases

* Single installation with no configuration
* Single installation with 1..n instances defined
* Single installation with 1..n instances defined and 1..n databases defined for each instance

## Platform Pre-Requisites

* Linux YUM Repository - An onsite linux YUM Repsoitory is required.

## Software Repository

SW_REPO_ROOT -> Stored in the ['ibm']['sw_repo'] attribute.

Relative to the software repository, the installation files must be stored in the following location.

* BASE FILES   -> /db2/[v105|v111]/base
* FIXPACK FILES -> /db2/[v105|v111]/maint

The following is a description of files needed on the REPO Server depending on version and architecture.

```python
case node['platform_family']
when 'rhel'
  case node['kernel']['machine']
  when 'x86_64'
    default['db2']['arch'] = 'x86-64'
    # <> DB2 Version 10.5.0.3, 10.5.0.8
    force_override['db2']['archive_names'] = {
      '10.5.0.3' => { 'filename' => 'DB2_Svr_' + node['db2']['base_version'] + '.' + node['db2']['included_modpack'] + '.'+ node['db2']['included_fixpack'] + '_Linux_' + node['db2']['arch'] + '.tar.gz',
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
end
```


Requirements
------------

### Platform:

*No platforms defined*

### Cookbooks:

* ibm_cloud_utils
* linux

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['db2']['base_version']</code></td>
    <td>The base version of DB2 to install. Set to none if installing from fix package.</td>
    <td><code>none</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['das_password']</code></td>
    <td>DB2 Administration Server (DAS) password</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['db2']['das_username']</code></td>
    <td>DB2 Administration Server (DAS) username</td>
    <td><code>dasadm1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['fp_version']</code></td>
    <td>The version of DB2 fix pack to install. If no fix pack is required, set this value the same as DB2 base version.</td>
    <td><code>11.1.2.2</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['install_dir']</code></td>
    <td>The directory to install DB2. Recommended: /opt/ibm/db2/V<db2_version></td>
    <td><code>/opt/ibm/db2/V11.1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['codeset']</code></td>
    <td>Codeset is used by the database manager to determine codepage parameter values.</td>
    <td><code>UTF-8</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_update']['FAILARCHPATH']</code></td>
    <td>The path to be used for archiving log files.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_update']['LOGARCHMETH1']</code></td>
    <td>Specifies the media type of the primary destination for logs that are archived.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_update']['LOGFILSIZ']</code></td>
    <td>Specifies the size of log files.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_update']['LOGSECOND']</code></td>
    <td>Specifies the number of secondary log files that are created and used for recovery log files.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_update']['NEWLOGPATH']</code></td>
    <td>The path to be used for database logging.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_users']['db_user($INDEX)']['ldap_user']</code></td>
    <td>This parameter indicates whether the database user is stored in LDAP. If the value set to true, the user is not created on the operating system.</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_users']['db_user($INDEX)']['user_access']</code></td>
    <td>The database access granted to the user. Example: DBADM WITH DATAACCESS WITHOUT ACCESSCTRL</td>
    <td><code>none</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_users']['db_user($INDEX)']['user_gid']</code></td>
    <td>Specifies the name of the operating system group for database users.</td>
    <td><code>dbgroup1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_users']['db_user($INDEX)']['user_home']</code></td>
    <td>The DB2 database user home directory.</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_users']['db_user($INDEX)']['user_name']</code></td>
    <td>The user name to be granted database access.</td>
    <td><code>dbuser1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['database_users']['db_user($INDEX)']['user_password']</code></td>
    <td>The password for the database user name.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['db_collate']</code></td>
    <td>Collate determines ordering for a set of characters.</td>
    <td><code>SYSTEM</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['db_data_path']</code></td>
    <td>Specifies the DB2 database data path.</td>
    <td><code>/home/db2inst1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['db_name']</code></td>
    <td>The name of the database to be created.</td>
    <td><code>db01</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['db_path']</code></td>
    <td>Specifies the DB2 database path.</td>
    <td><code>/home/db2inst1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['instance_username']</code></td>
    <td>The DB2 instance username controls all DB2 processes and owns all filesystems and devices.</td>
    <td><code>db2inst1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['pagesize']</code></td>
    <td>Specifies the page size in bytes.</td>
    <td><code>4096</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['databases']['database($INDEX)']['territory']</code></td>
    <td>Territory is used by the database manager when processing data that is territory sensitive.</td>
    <td><code>US</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['fcm_port']</code></td>
    <td>The port for the DB2 Fast Communications Manager (FCM).</td>
    <td><code>60000</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['fenced_groupname']</code></td>
    <td>The group name for the DB2 fenced user.</td>
    <td><code>db2fenc1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['fenced_password']</code></td>
    <td>The password for the DB2 fenced username.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['fenced_username']</code></td>
    <td>The fenced user is used to run user defined functions and stored procedures outside of the address space used by the DB2 database.</td>
    <td><code>db2fenc1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['instance_dir']</code></td>
    <td>The DB2 instance directory stores all information that pertains to a database instance.</td>
    <td><code>/home/db2inst1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['instance_groupname']</code></td>
    <td>The group name for the DB2 instance user.</td>
    <td><code>db2iadm1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['instance_password']</code></td>
    <td>The password for the DB2 instance username.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['instance_prefix']</code></td>
    <td>Specifies the DB2 instance prefix</td>
    <td><code>INST1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['instance_type']</code></td>
    <td>The type of DB2 instance to create.</td>
    <td><code>ESE</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['instance_username']</code></td>
    <td>The DB2 instance username controls all DB2 processes and owns all filesystems and devices.</td>
    <td><code>db2inst1</code></td>
  </tr>
  <tr>
    <td><code>node['db2']['instances']['instance($INDEX)']['port']</code></td>
    <td>The port to connect to the DB2 instance.</td>
    <td><code>50000</code></td>
  </tr>
</table>

Recipes
-------

### db2::cleanup.rb


Cleanup recipe (cleanup.rb)
This recipe will remove any temporary installation files created as part of the automation.


### db2::create_db.rb


Create database recipe (create_db.rb)
This recipe will create instances and databases as specified in attributes.


### db2::default.rb


Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.


### db2::fixpack.rb


Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.


### db2::gather_evidence.rb


Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.


### db2::harden.rb


Product hardening recipe (harden.rb)
This recipe performs security hardening tasks.


### db2::install.rb


Installation recipe (install.rb)
This recipe performs the product installation.


### db2::license.rb


License recipe (license.rb)
This recipe will apply the license file from a repo server, in case a base package cannot be installed.


### db2::prereq.rb


Prerequisite recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.


### db2::prereq_check.rb


Prerequisites check recipe (prereq_check.rb)
Recipe to ensure that pre-requisites are in place for a cookbook to run.



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2017, 2017

