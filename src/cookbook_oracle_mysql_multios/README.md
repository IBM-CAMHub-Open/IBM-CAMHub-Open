Oracle_mysql Cookbook
=====================

Installs/Configure Oracle MySQL

Requirements
------------

### Platform:

* Ubuntu (>= 14.04)
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
    <td><code>node['mysql']['config']['data_dir']</code></td>
    <td>Directory to store information managed by MySQL server</td>
    <td><code>/var/lib/mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['databases']['database_1']['database_name']</code></td>
    <td>Create a sample database in MySQL</td>
    <td><code>MyDB</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['databases']['database_1']['users']['user_1']['name']</code></td>
    <td>Name of the first user which is created and allowed to access the created sample database </td>
    <td><code>defaultUser</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['databases']['database_1']['users']['user_1']['password']</code></td>
    <td>Name of the second user which is created and allowed to access the created sample database</td>
    <td><code>defaultUser2</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['databases']['database_1']['users']['user_2']['password']</code></td>
    <td>Password of the second user</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['engine']</code></td>
    <td>MySQL database engine</td>
    <td><code>InnoDB</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['key_buffer_size']</code></td>
    <td>Mysql key buffer size</td>
    <td><code>16M</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['log_file']</code></td>
    <td>Log file configured in MySQL</td>
    <td><code>/var/log/mysqld.log</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['max_allowed_packet']</code></td>
    <td>Mysql key buffer size</td>
    <td><code>8M</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['pid']</code></td>
    <td>MySQL pid file</td>
    <td><code>/var/run/mysqld/mysqld.pid</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['port']</code></td>
    <td>Listen port to be configured in MySQL</td>
    <td><code>3306</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['config']['socket']</code></td>
    <td>MySQL socket</td>
    <td><code>/var/run/mysqld/mysql.sock</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['install_from_repo']</code></td>
    <td>Install MySQL from secure repository server or yum repo</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['os_users']['daemon']['comment']</code></td>
    <td>Comment associated with the MySQL OS user</td>
    <td><code>MySQL instance owner</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['os_users']['daemon']['gid']</code></td>
    <td>Group ID of the default OS user to be used to configure MySQL</td>
    <td><code>mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['os_users']['daemon']['home']</code></td>
    <td>Home directory of the default OS user to be used to configure MySQL</td>
    <td><code>/home/mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['os_users']['daemon']['ldap_user']</code></td>
    <td>A flag which indicates whether to create the MQ USer locally, or utilise an LDAP based user.</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['os_users']['daemon']['name']</code></td>
    <td>User Name of the default OS user to be used to configure MySQL</td>
    <td><code>mysql</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['os_users']['daemon']['shell']</code></td>
    <td>Default shell configured on Linux server</td>
    <td><code>/bin/bash</code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['root_password']</code></td>
    <td>The password for the MySQL root user</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['mysql']['version']</code></td>
    <td>MySQL Version to be installed</td>
    <td><code>5.7.17</code></td>
  </tr>
</table>

Recipes
-------

### oracle_mysql::cleanup.rb


Cleanup recipe (cleanup.rb)
This recipe will remove any temporary installation files created as part of the automation.


### oracle_mysql::config_mysql.rb


Installation recipe (install.rb)
This recipe performs the product installation.


### oracle_mysql::default.rb


Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.


### oracle_mysql::fixpack.rb


Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.


### oracle_mysql::gather_evidence.rb


Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.


### oracle_mysql::harden.rb


Product hardening recipe (harden.rb)
This recipe performs security hardening tasks.
This custom resource changes the default MySQL root password


### oracle_mysql::install.rb


Installation recipe (install.rb)
This recipe performs the product installation.


### oracle_mysql::prereq.rb


Prerequisite recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.
Archive names for RHEL6/7 and version separation


### oracle_mysql::service.rb


Service control recipe (service.rb)
Enable and start the MySQL service



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2016, 2017

