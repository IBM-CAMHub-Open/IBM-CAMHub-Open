name             'db2'
maintainer       'IBM Corp'
maintainer_email ''
license          'Copyright IBM Corp. 2017, 2017'
depends          'ibm_cloud_utils'
depends          'linux'
version '1.0.2'
description <<-EOH
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
EOH
attribute 'db2/base_version',
          :choice => ['10.5.0.3', '10.5.0.8', '11.1.0.0', 'none'],
          :default => 'none',
          :description => 'The base version of DB2 to install. Set to none if installing from fix package.',
          :displayname => 'DB2 base version',
          :hidden => 'true',
          :options => ['10.5.0.3', '10.5.0.8', '11.1.0.0', 'none'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/das_password',
          :default => '',
          :description => 'DB2 Administration Server (DAS) password',
          :displayname => 'DB2 DAS user password',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^[!-~]{8,32}$',
          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/das_username',
          :default => 'dasadm1',
          :description => 'DB2 Administration Server (DAS) username',
          :displayname => 'DB2 DAS username',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/fp_version',
          :default => '11.1.2.2',
          :description => 'The version of DB2 fix pack to install. If no fix pack is required, set this value the same as DB2 base version.',
          :displayname => 'DB2 fix pack version',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/install_dir',
          :default => '/opt/ibm/db2/V11.1',
          :description => 'The directory to install DB2. Recommended: /opt/ibm/db2/V<db2_version>',
          :displayname => 'DB2 installation directory',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/codeset',
          :default => 'UTF-8',
          :description => 'Codeset is used by the database manager to determine codepage parameter values.',
          :displayname => 'DB2 codeset',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^IBM-([0-9]{2,4}|euc(CN|JP|KR|TW))$|^(ISO[-]?8859-|iso8859)(1|2|5|6|7|8|9|15)$|^(UTF-8|roman8|125[0-8]|737|5601|1363|KOI8(-R|-U|-RU)?|GB(K|18030)|gb2312|hp15CN|euc(CN|JP|KR|TW)|EUC-(JP|KR)|BIG5|big5|Big5-HKSCS|SJIS|cns11643|TIS620-1|tis620)$',
          :regexdesc => 'Allow codesets defined in https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.admin.nls.doc/doc/r0004565.html.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/FAILARCHPATH',
          :default => 'default',
          :description => 'The path to be used for archiving log files.',
          :displayname => 'DB2 failover log archive path',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(default|\/[ -~]*)$',
          :regexdesc => 'Allow default or a string that starts with slash.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGARCHMETH1',
          :choice => ['default', 'LOGRETAIN', 'USEREXIT', 'DISK', 'TSM', 'VENDOR', 'OFF'],
          :default => 'default',
          :description => 'Specifies the media type of the primary destination for logs that are archived.',
          :displayname => 'DB2 primary log archive method',
          :hidden => 'true',
          :options => ['default', 'LOGRETAIN', 'USEREXIT', 'DISK', 'TSM', 'VENDOR', 'OFF'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGFILSIZ',
          :default => 'default',
          :description => 'Specifies the size of log files.',
          :displayname => 'DB2 log file size',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^([4-9]|[1-9][0-9]{1,6}|1[0-5][0-9]{6}|16[0-6][0-9]{5}|167[0-6][0-9]{4}|1677[0-6][0-9]{3}|167770[0-9]{2}|167771[0-4][0-9]|1677715[0-2]|default)$',
          :regexdesc => 'Allow a number between 4 and 16777152 or using default.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGSECOND',
          :default => 'default',
          :description => 'Specifies the number of secondary log files that are created and used for recovery log files.',
          :displayname => 'DB2 secondary log files',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(-1|[0-9]|1[0-9]{1,2}|2[0-4][0-9]|25[0-4]|default)$',
          :regexdesc => 'Allow a number between -1 and 254 or using default.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/NEWLOGPATH',
          :default => 'default',
          :description => 'The path to be used for database logging.',
          :displayname => 'DB2 database log path',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(default|\/[ -~]*)$',
          :regexdesc => 'Allow default or a string that starts with slash.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/ldap_user',
          :choice => ['true', 'false'],
          :default => 'false',
          :description => 'This parameter indicates whether the database user is stored in LDAP. If the value set to true, the user is not created on the operating system.',
          :displayname => 'DB2 database user LDAP',
          :hidden => 'true',
          :options => ['true', 'false'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_access',
          :choice => ['DBADM', 'SECADM', 'SQLADM', 'WLMADM', 'EXPLAIN', 'ACCESSCTRL', 'DATAACCESS', 'none'],
          :default => 'none',
          :description => 'The database access granted to the user. Example: DBADM WITH DATAACCESS WITHOUT ACCESSCTRL',
          :displayname => 'DB2 database user access',
          :hidden => 'true',
          :options => ['DBADM', 'SECADM', 'SQLADM', 'WLMADM', 'EXPLAIN', 'ACCESSCTRL', 'DATAACCESS', 'none'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_gid',
          :default => 'dbgroup1',
          :description => 'Specifies the name of the operating system group for database users.',
          :displayname => 'DB2 database user group name',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,27}|(admins|guests|public)[0-9a-z_]{1,26})|(?!(ibm|sys|sql))[a-z_][0-9a-z_]{0,31})$',
          :regexdesc => 'Allow 1 to 32 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, and sql.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_home',
          :default => 'default',
          :description => 'The DB2 database user home directory.',
          :displayname => 'DB2 database user home directory',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_name',
          :default => 'dbuser1',
          :description => 'The user name to be granted database access.',
          :displayname => 'DB2 database user name',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_password',
          :default => '',
          :description => 'The password for the database user name.',
          :displayname => 'DB2 database user password',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^[!-~]{8,32}$',
          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_collate',
          :choice => ['SYSTEM', 'NLSCHAR', 'COMPATIBILITY', 'IDENTITY', 'IDENTITY_16BIT'],
          :default => 'SYSTEM',
          :description => 'Collate determines ordering for a set of characters.',
          :displayname => 'DB2 collate',
          :hidden => 'false',
          :options => ['SYSTEM', 'NLSCHAR', 'COMPATIBILITY', 'IDENTITY', 'IDENTITY_16BIT'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_data_path',
          :default => '/home/db2inst1',
          :description => 'Specifies the DB2 database data path.',
          :displayname => 'DB2 database data path',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^/[ -~]*$',
          :regexdesc => 'Allow a string that starts with slash.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_name',
          :default => 'db01',
          :description => 'The name of the database to be created.',
          :displayname => 'DB2 database name',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?!([sS][yY][sS]|[iI][bB][mM]|[dD][bB][mM]))[A-Za-z][0-9A-Za-z]{0,7}$',
          :regexdesc => 'Allow 1 to 8 alphanumeric characters starting withnot a number or the letter sequences SYS, DBM, or IBM.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_path',
          :default => '/home/db2inst1',
          :description => 'Specifies the DB2 database path.',
          :displayname => 'DB2 database path',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^/[ -~]*$',
          :regexdesc => 'Allow a string that starts with slash.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/instance_username',
          :default => 'db2inst1',
          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
          :displayname => 'DB2 instance username',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/pagesize',
          :choice => ['4096', '8192', '16384', '32768'],
          :default => '4096',
          :description => 'Specifies the page size in bytes.',
          :displayname => 'DB2 page size',
          :hidden => 'false',
          :options => ['4096', '8192', '16384', '32768'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/territory',
          :default => 'US',
          :description => 'Territory is used by the database manager when processing data that is territory sensitive.',
          :displayname => 'DB2 territory',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^[A-Z]{2}$|^Lat$',
          :regexdesc => 'Allow two upper-case letters and a special case (Lat) as defined in https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.admin.nls.doc/doc/r0004565.html.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fcm_port',
          :default => '60000',
          :description => 'The port for the DB2 Fast Communications Manager (FCM).',
          :displayname => 'DB2 FCM port',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^6[0-9]{3}[0-8]$',
          :regexdesc => 'Allow a number between 60000 and 69998.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fenced_groupname',
          :default => 'db2fenc1',
          :description => 'The group name for the DB2 fenced user.',
          :displayname => 'DB2 fenced group name',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,27}|(admins|guests|public)[0-9a-z_]{1,26})|(?!(ibm|sys|sql))[a-z_][0-9a-z_]{0,31})$',
          :regexdesc => 'Allow 1 to 32 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, and sql.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fenced_password',
          :default => '',
          :description => 'The password for the DB2 fenced username.',
          :displayname => 'DB2 fenced user password',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^[!-~]{8,32}$',
          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fenced_username',
          :default => 'db2fenc1',
          :description => 'The fenced user is used to run user defined functions and stored procedures outside of the address space used by the DB2 database.',
          :displayname => 'DB2 fenced username',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_dir',
          :default => '/home/db2inst1',
          :description => 'The DB2 instance directory stores all information that pertains to a database instance.',
          :displayname => 'DB2 instance directory',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^/[ -~]*$',
          :regexdesc => 'Allow default or a string that starts with slash.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_groupname',
          :default => 'db2iadm1',
          :description => 'The group name for the DB2 instance user.',
          :displayname => 'DB2 instance group name',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,27}|(admins|guests|public)[0-9a-z_]{1,26})|(?!(ibm|sys|sql))[a-z_][0-9a-z_]{0,31})$',
          :regexdesc => 'Allow 1 to 32 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, and sql.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_password',
          :default => '',
          :description => 'The password for the DB2 instance username.',
          :displayname => 'DB2 instance user password',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^[!-~]{8,32}$',
          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_prefix',
          :default => 'INST1',
          :description => 'Specifies the DB2 instance prefix',
          :displayname => 'DB2 instance prefix',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?!([sS][yY][sS]|[iI][bB][mM]|[dD][bB][mM]))[A-Za-z][0-9A-Za-z]{0,7}$',
          :regexdesc => 'Allow 1 to 8 alphanumeric characters starting withnot a number or the letter sequences SYS, DBM, or IBM.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_type',
          :choice => ['ESE', 'DSF', 'WSE', 'STANDALONE', 'CLIENT'],
          :default => 'ESE',
          :description => 'The type of DB2 instance to create.',
          :displayname => 'DB2 instance type',
          :hidden => 'true',
          :options => ['ESE', 'DSF', 'WSE', 'STANDALONE', 'CLIENT'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_username',
          :default => 'db2inst1',
          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
          :displayname => 'DB2 instance username',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/port',
          :default => '50000',
          :description => 'The port to connect to the DB2 instance.',
          :displayname => 'DB2 connection port',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :regex => '^5[0-9]{4}$',
          :regexdesc => 'Allow a number between 50000 and 59999.',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
recipe 'db2::cleanup.rb', '
Cleanup recipe (cleanup.rb)
This recipe will remove any temporary installation files created as part of the automation.
'
recipe 'db2::create_db.rb', '
Create database recipe (create_db.rb)
This recipe will create instances and databases as specified in attributes.
'
recipe 'db2::default.rb', '
Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.
'
recipe 'db2::fixpack.rb', '
Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.
'
recipe 'db2::gather_evidence.rb', '
Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.
'
recipe 'db2::harden.rb', '
Product hardening recipe (harden.rb)
This recipe performs security hardening tasks.
'
recipe 'db2::install.rb', '
Installation recipe (install.rb)
This recipe performs the product installation.
'
recipe 'db2::license.rb', '
License recipe (license.rb)
This recipe will apply the license file from a repo server, in case a base package cannot be installed.
'
recipe 'db2::prereq.rb', '
Prerequisite recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.
'
recipe 'db2::prereq_check.rb', '
Prerequisites check recipe (prereq_check.rb)
Recipe to ensure that pre-requisites are in place for a cookbook to run.
'
