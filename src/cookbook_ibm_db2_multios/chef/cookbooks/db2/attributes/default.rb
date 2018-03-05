#
# Cookbook Name:: db2
# attributes :: default
#
# Copyright IBM Corp. 2017, 2017

# <> DB2 base package version
# <md>attribute 'db2/base_version',
# <md>          :displayname => 'DB2 base version',
# <md>          :description => 'The base version of DB2 to install. Set to none if installing from fix package.',
# <md>          :choice => [ '10.5.0.3', '10.5.0.8', '11.1.0.0', 'none' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'none',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['db2']['base_version'] = '10.5.0.8'

# <> DB2 fixpack version
# <md>attribute 'db2/fp_version',
# <md>          :displayname => 'DB2 fix pack version',
# <md>          :description => 'The version of DB2 fix pack to install. If no fix pack is required, set this value the same as DB2 base version.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11.1.2.2',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['db2']['fp_version'] = node['db2']['base_version']

# <> The DB2 installation directory
# <md>attribute 'db2/install_dir',
# <md>          :displayname => 'DB2 installation directory',
# <md>          :description => 'The directory to install DB2. Recommended: /opt/ibm/db2/V<db2_version>',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/ibm/db2/V11.1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['db2']['install_dir'] = '/opt/ibm/db2/V' + node['db2']['fp_version'].split('.')[0, 2].join('.')

## das server
# <> DB2 Administration Server (DAS) username
# <md>attribute 'db2/das_username',
# <md>          :displayname => 'DB2 DAS username',
# <md>          :description => 'DB2 Administration Server (DAS) username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'dasadm1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
# <md>          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['db2']['das_username'] = 'dasadm1'

# <> DB2 Administration Server (DAS) password
# <md>attribute 'db2/das_password',
# <md>          :displayname => 'DB2 DAS user password',
# <md>          :description => 'DB2 Administration Server (DAS) password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'
default['db2']['das_password'] = ''

# <> DB2 instance attribute
# <md>attribute '$dynamicmaps/db2/instances'
# <md>          :$count => '0',
# <md>          :$displayname => 'DB2 instances',
# <md>          :$key => 'instance',
# <md>          :$max => '4'
# <md>attribute '$dynamicmaps/db2/instances/instance($INDEX)/$dynamicmaps/databases'
# <md>          :$count => '0',
# <md>          :$displayname => 'DB2 databases',
# <md>          :$key => 'database',
# <md>          :$max => '4'
# <md>attribute '$dynamicmaps/db2/instances/instance($INDEX)/$dynamicmaps/databases/database($INDEX)/$dynamicmaps/database_users'
# <md>          :$count => '0',
# <md>          :$displayname => 'DB2 database users',
# <md>          :$key => 'db_user',
# <md>          :$max => '4'

# <md>attribute 'db2/instances/instance($INDEX)/instance_prefix',
# <md>          :displayname => 'DB2 instance prefix',
# <md>          :description => 'Specifies the DB2 instance prefix',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'INST1',
# <md>          :regex => '^(?!([sS][yY][sS]|[iI][bB][mM]|[dD][bB][mM]))[A-Za-z][0-9A-Za-z]{0,7}$',
# <md>          :regexdesc => 'Allow 1 to 8 alphanumeric characters starting withnot a number or the letter sequences SYS, DBM, or IBM.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_type',
# <md>          :displayname => 'DB2 instance type',
# <md>          :description => 'The type of DB2 instance to create.',
# <md>          :choice => [ 'ESE','DSF','WSE','STANDALONE','CLIENT' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ESE',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_username',
# <md>          :displayname => 'DB2 instance username',
# <md>          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
# <md>          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_groupname',
# <md>          :displayname => 'DB2 instance group name',
# <md>          :description => 'The group name for the DB2 instance user.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2iadm1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,27}|(admins|guests|public)[0-9a-z_]{1,26})|(?!(ibm|sys|sql))[a-z_][0-9a-z_]{0,31})$',
# <md>          :regexdesc => 'Allow 1 to 32 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, and sql.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_password',
# <md>          :displayname => 'DB2 instance user password',
# <md>          :description => 'The password for the DB2 instance username.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/instance_dir',
# <md>          :displayname => 'DB2 instance directory',
# <md>          :description => 'The DB2 instance directory stores all information that pertains to a database instance.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :regex => '^/[ -~]*$',
# <md>          :regexdesc => 'Allow default or a string that starts with slash.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/port',
# <md>          :displayname => 'DB2 connection port',
# <md>          :description => 'The port to connect to the DB2 instance.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '50000',
# <md>          :regex => '^5[0-9]{4}$',
# <md>          :regexdesc => 'Allow a number between 50000 and 59999.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_username',
# <md>          :displayname => 'DB2 fenced username',
# <md>          :description => 'The fenced user is used to run user defined functions and stored procedures outside of the address space used by the DB2 database.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
# <md>          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_groupname',
# <md>          :displayname => 'DB2 fenced group name',
# <md>          :description => 'The group name for the DB2 fenced user.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,27}|(admins|guests|public)[0-9a-z_]{1,26})|(?!(ibm|sys|sql))[a-z_][0-9a-z_]{0,31})$',
# <md>          :regexdesc => 'Allow 1 to 32 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, and sql.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_password',
# <md>          :displayname => 'DB2 fenced user password',
# <md>          :description => 'The password for the DB2 fenced username.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/fcm_port',
# <md>          :displayname => 'DB2 FCM port',
# <md>          :description => 'The port for the DB2 Fast Communications Manager (FCM).',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '60000',
# <md>          :regex => '^6[0-9]{3}[0-8]$',
# <md>          :regexdesc => 'Allow a number between 60000 and 69998.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <> DB2 Database
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_name',
# <md>          :displayname => 'DB2 database name',
# <md>          :description => 'The name of the database to be created.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db01',
# <md>          :regex => '^(?!([sS][yY][sS]|[iI][bB][mM]|[dD][bB][mM]))[A-Za-z][0-9A-Za-z]{0,7}$',
# <md>          :regexdesc => 'Allow 1 to 8 alphanumeric characters starting withnot a number or the letter sequences SYS, DBM, or IBM.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_data_path',
# <md>          :displayname => 'DB2 database data path',
# <md>          :description => 'Specifies the DB2 database data path.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :regex => '^/[ -~]*$',
# <md>          :regexdesc => 'Allow a string that starts with slash.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_path',
# <md>          :displayname => 'DB2 database path',
# <md>          :description => 'Specifies the DB2 database path.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :regex => '^/[ -~]*$',
# <md>          :regexdesc => 'Allow a string that starts with slash.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/instance_username',
# <md>          :displayname => 'DB2 instance username',
# <md>          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/pagesize',
# <md>          :displayname => 'DB2 page size',
# <md>          :description => 'Specifies the page size in bytes.',
# <md>          :choice => [ '4096','8192','16384','32768' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4096',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/territory',
# <md>          :displayname => 'DB2 territory',
# <md>          :description => 'Territory is used by the database manager when processing data that is territory sensitive.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'US',
# <md>          :regex => '^[A-Z]{2}$|^Lat$',
# <md>          :regexdesc => 'Allow two upper-case letters and a special case (Lat) as defined in https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.admin.nls.doc/doc/r0004565.html.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/codeset',
# <md>          :displayname => 'DB2 codeset',
# <md>          :description => 'Codeset is used by the database manager to determine codepage parameter values.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'UTF-8',
# <md>          :regex => '^IBM-([0-9]{2,4}|euc(CN|JP|KR|TW))$|^(ISO[-]?8859-|iso8859)(1|2|5|6|7|8|9|15)$|^(UTF-8|roman8|125[0-8]|737|5601|1363|KOI8(-R|-U|-RU)?|GB(K|18030)|gb2312|hp15CN|euc(CN|JP|KR|TW)|EUC-(JP|KR)|BIG5|big5|Big5-HKSCS|SJIS|cns11643|TIS620-1|tis620)$',
# <md>          :regexdesc => 'Allow codesets defined in https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.admin.nls.doc/doc/r0004565.html.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_collate',
# <md>          :displayname => 'DB2 collate',
# <md>          :description => 'Collate determines ordering for a set of characters.',
# <md>          :choice => [ 'SYSTEM','NLSCHAR','COMPATIBILITY','IDENTITY','IDENTITY_16BIT' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'SYSTEM',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# Database parameters to be set by an UPDATE command
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/NEWLOGPATH',
# <md>          :displayname => 'DB2 database log path',
# <md>          :description => 'The path to be used for database logging.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :regex => '^(default|\/[ -~]*)$',
# <md>          :regexdesc => 'Allow default or a string that starts with slash.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/FAILARCHPATH',
# <md>          :displayname => 'DB2 failover log archive path',
# <md>          :description => 'The path to be used for archiving log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :regex => '^(default|\/[ -~]*)$',
# <md>          :regexdesc => 'Allow default or a string that starts with slash.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGARCHMETH1',
# <md>          :displayname => 'DB2 primary log archive method',
# <md>          :description => 'Specifies the media type of the primary destination for logs that are archived.',
# <md>          :choice => [ 'default','LOGRETAIN','USEREXIT','DISK','TSM','VENDOR','OFF' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGFILSIZ',
# <md>          :displayname => 'DB2 log file size',
# <md>          :description => 'Specifies the size of log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :regex => '^([4-9]|[1-9][0-9]{1,6}|1[0-5][0-9]{6}|16[0-6][0-9]{5}|167[0-6][0-9]{4}|1677[0-6][0-9]{3}|167770[0-9]{2}|167771[0-4][0-9]|1677715[0-2]|default)$',
# <md>          :regexdesc => 'Allow a number between 4 and 16777152 or using default.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGSECOND',
# <md>          :displayname => 'DB2 secondary log files',
# <md>          :description => 'Specifies the number of secondary log files that are created and used for recovery log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :regex => '^(-1|[0-9]|1[0-9]{1,2}|2[0-4][0-9]|25[0-4]|default)$',
# <md>          :regexdesc => 'Allow a number between -1 and 254 or using default.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# Users to be granted access to the database (user_access = none -> user is created but no access is granted)
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_name',
# <md>          :displayname => 'DB2 database user name',
# <md>          :description => 'The user name to be granted database access.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'dbuser1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,3}|(admins|guests|public)[0-9a-z_]{1,2})|(?!(ibm|sys|sql|dbm))[a-z_][0-9a-z_]{0,7})$',
# <md>          :regexdesc => 'Allow 1 to 8 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, sql and dbm.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_gid',
# <md>          :displayname => 'DB2 database user group name',
# <md>          :description => 'Specifies the name of the operating system group for database users.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'dbgroup1',
# <md>          :regex => '^(?(?=(users|admins|guests|public|local))((users|local)[0-9a-z_]{1,27}|(admins|guests|public)[0-9a-z_]{1,26})|(?!(ibm|sys|sql))[a-z_][0-9a-z_]{0,31})$',
# <md>          :regexdesc => 'Allow 1 to 32 lower-case letters, digits and _(underscore) for names (1) not same as users, admins, guests, public, local and any SQL reserved words; (2) not starting with digits and special words as ibm, sys, and sql.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_password',
# <md>          :displayname => 'DB2 database user password',
# <md>          :description => 'The password for the database user name.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_home',
# <md>          :displayname => 'DB2 database user home directory',
# <md>          :description => 'The DB2 database user home directory.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/ldap_user',
# <md>          :displayname => 'DB2 database user LDAP',
# <md>          :description => 'This parameter indicates whether the database user is stored in LDAP. If the value set to true, the user is not created on the operating system.',
# <md>          :choice => [ 'true','false' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_access',
# <md>          :displayname => 'DB2 database user access',
# <md>          :description => 'The database access granted to the user. Example: DBADM WITH DATAACCESS WITHOUT ACCESSCTRL',
# <md>          :choice => [ 'DBADM','SECADM','SQLADM','WLMADM','EXPLAIN','ACCESSCTRL','DATAACCESS','none' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'none',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

default['db2']['instances'] = {}
# Sample instance attribute. This will be set in role file
#default['db2']['instances'] = {
#  'inst1' => {
#    'instance_prefix' => 'DB2_INS1',
#    'instance_type' => 'ESE',
#    'instance_username' => 'db2inst1',
#    'instance_groupname' => 'db2iadm1',
#    'instance_password' => 'passw0rd',
#    'instance_dir' => '/home/db2inst1',
#    'port' => '50000',
#    'fenced_username' => 'db2fenc1',
#    'fenced_groupname' => 'db2fadm1',
#    'fenced_password' => 'passw0rd',
#    'fcm_port' => '60000',
#    'databases' => {
#      'db11' => {
#        'db_name' => 'db11',
#        'db_data_path' => '/home/db2inst1',
#        'db_path' => '/home/db2inst1',
#        'pagesize' => '4096',
#        'territory' => 'US',
#        'codeset' => 'UTF-8',
#        'db_collate' => 'SYSTEM'
#      }
#    }
#  }
#}
