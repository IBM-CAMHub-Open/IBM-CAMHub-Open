name             'oracledb'
maintainer       'IBM Corp'
maintainer_email ''
license          'Copyright IBM Corp. 2017, 2017'
description      'Oracle Enterprise Edition DB'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.2'
depends 'ibm_cloud_utils'
supports	'RHEL', '>= 6.5'
supports	'RHEL', '>= 7.0'

attribute 'oracledb/SID',
          :default => 'orcl',
          :description => 'Name to identify a specific instance of a running Oracle database',
          :displayname => 'Oracle System Identifier',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/data_mount',
          :default => '/u01',
          :description => 'Mount point directory for the file system that contains the Oracle software.',
          :displayname => 'User Data Mount',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/install_group',
          :default => 'oinstall',
          :description => 'Oracle OS Inventory Group',
          :displayname => 'Oracle Inventory Group',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/language',
          :default => 'en',
          :description => 'Oracle Install Language',
          :displayname => 'Oracle Install Language',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/os_users/oracle/comment',
          :default => 'Oracle administrative user',
          :description => 'Oracle OS User comment',
          :displayname => 'Oracle OS User comment',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/os_users/oracle/gid',
          :default => 'dba',
          :description => 'Oracle OS User gid',
          :displayname => 'Oracle OS User gid',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/os_users/oracle/home',
          :default => '/home/oracle',
          :description => 'Oracle OS User home',
          :displayname => 'Oracle OS User home',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/os_users/oracle/ldap_user',
          :choice => ['true', 'false'],
          :default => 'false',
          :description => 'Oracle ldap_user',
          :displayname => 'Oracle ldap_user',
          :options => ['true', 'false'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/os_users/oracle/name',
          :default => 'oracle',
          :description => 'Oracle Operating System Username',
          :displayname => 'Oracle Operating System Username',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/os_users/oracle/shell',
          :default => '/bin/bash',
          :description => 'Oracle OS User shell',
          :displayname => 'Oracle OS User shell',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/port',
          :default => '1521',
          :description => 'Listening port to be configured in Oracle',
          :displayname => 'Oracle Listener Port',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/release_patchset',
          :default => '',
          :description => 'Identifier of patch set to apply to Oracle for improvement and bug fix',
          :displayname => 'Oracle Patchset Number',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/security/sys_pw',
          :default => '',
          :description => 'Change the password for SYS user',
          :displayname => 'SYS Schema Password',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :type => 'string'
attribute 'oracledb/security/system_pw',
          :default => '',
          :description => 'Change the password for SYSTEM user',
          :displayname => 'SYSTEM Schema Password',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :type => 'string'
attribute 'oracledb/swap_file_size_mb',
          :default => '-1',
          :description => 'Swap size in MB',
          :displayname => 'Swap size in MB',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
attribute 'oracledb/version',
          :default => 'v12c',
          :description => 'Version of Oracle DB to be installed',
          :displayname => 'Oracle DB Installation Version',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :selectable => 'true',
          :type => 'string'
recipe 'oracledb::cleanup.rb', '
Cleanup recipe (cleanup.rb)
This recipe will remove any temporary installation files created as part of the automation.
'
recipe 'oracledb::config_asm.rb', '
Installation recipe (config_asm.rb)
This recipe preforms the post installation operation of ASM
'
recipe 'oracledb::dbca.rb', '
Create RDBMS recipe (dbca.rb)
This recipe will congire Database.
'
recipe 'oracledb::default.rb', '
Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.
'
recipe 'oracledb::fixpack.rb', '
Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.
'
recipe 'oracledb::gather_evidence.rb', '
Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.
'
recipe 'oracledb::harden.rb', '
Product hardening recipe (harden.rb)
This recipe performs security hardening tasks.
'
recipe 'oracledb::install.rb', '
Installation recipe (install.rb)
This recipe performs the product installation.
'
recipe 'oracledb::install_grid.rb', '
Installation recipe (install_grid.rb)
This recipe performs the Grid product installation.
'
recipe 'oracledb::prereq.rb', '
Installation recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.
'
recipe 'oracledb::prereq_asm_disks.rb', '
Installation recipe (prereq_asm_disks.rb)
This recipe configures the operating prerequisites for the ASM.
'
recipe 'oracledb::services.rb', '
Installation recipe (services.rb)
This recipe creates and starts database services.
'
