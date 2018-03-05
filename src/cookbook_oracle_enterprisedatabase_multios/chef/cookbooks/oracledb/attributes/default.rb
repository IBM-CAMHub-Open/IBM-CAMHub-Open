# Cookbook Name:: oracledb
# Recipe:: attributes/internal
#
# Copyright IBM Corp. 2017, 2017
#


#############################################################################
# General Oracle settings
#############################################################################

# <> Oracle Database version
# <md>attribute 'oracledb/version',
# <md>          :displayname =>  'Oracle DB Installation Version',
# <md>          :description => 'Version of Oracle DB to be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'v12c',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['version'] = 'v12c'


# <> Oracle install language
# <md>attribute 'oracledb/language',
# <md>          :displayname => 'Oracle Install Language',
# <md>          :description => 'Oracle Install Language',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'en',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['language'] = 'en'


# <> Oracle port
# <md>attribute 'oracledb/port',
# <md>          :displayname => 'Oracle Listener Port',
# <md>          :description => 'Listening port to be configured in Oracle',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1521',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['port'] = "1521"


# <> Oracle System Identifier
# <md>attribute 'oracledb/SID',
# <md>          :displayname => 'Oracle System Identifier',
# <md>          :description => 'Name to identify a specific instance of a running Oracle database',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'orcl',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['SID'] = 'orcl'


# <> Oracle Patchset number
# <md>attribute 'oracledb/release_patchset',
# <md>          :displayname => 'Oracle Patchset Number',
# <md>          :description => 'Identifier of patch set to apply to Oracle for improvement and bug fix',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['release_patchset'] = '12.1.0.2.0' # 12.1.0.1.0 12.2.0.1.0 # ~ip_checker


# <> Oracle Install Group
# <md>attribute 'oracledb/install_group',
# <md>          :displayname => 'Oracle Inventory Group',
# <md>          :description => 'Oracle OS Inventory Group',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'oinstall',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['install_group'] = 'oinstall'


# <> User Data Mount
# <md>attribute 'oracledb/data_mount',
# <md>          :displayname => 'User Data Mount',
# <md>          :description => 'Mount point directory for the file system that contains the Oracle software.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/u01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['data_mount'] = '/u01'


# <> SYS Schema Password
# <md>attribute 'oracledb/security/sys_pw',
# <md>          :displayname => 'SYS Schema Password',
# <md>          :description => 'Change the password for SYS user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default =>  '',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'
default['oracledb']['security']['sys_pw'] = ''


# <> SYSTEM Schema Password
# <md>attribute 'oracledb/security/system_pw',
# <md>          :displayname => 'SYSTEM Schema Password',
# <md>          :description => 'Change the password for SYSTEM user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default =>  '',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'
default['oracledb']['security']['system_pw'] = ''


#############################################################################
# Oracle recommended settings
#############################################################################

# <> Swap size in MB
# <md>attribute 'oracledb/swap_file_size_mb',
# <md>          :displayname => 'Swap size in MB',
# <md>          :description => 'Swap size in MB',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '-1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['oracledb']['swap_file_size_mb'] = '-1'

############################################################################################################
# OS Users
############################################################################################################

#<> Oracle Operating System Users To Create

# <md>attribute 'oracledb/os_users/oracle/name',
# <md>          :displayname => 'Oracle Operating System Username',
# <md>          :description => 'Oracle Operating System Username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'oracle',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'

# <md>attribute 'oracledb/os_users/oracle/gid',
# <md>          :displayname => 'Oracle OS User gid',
# <md>          :description => 'Oracle OS User gid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'dba',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'

# <md>attribute 'oracledb/os_users/oracle/comment',
# <md>          :displayname => 'Oracle OS User comment',
# <md>          :description => 'Oracle OS User comment',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Oracle administrative user',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'oracledb/os_users/oracle/home',
# <md>          :displayname => 'Oracle OS User home',
# <md>          :description => 'Oracle OS User home',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/oracle',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'oracledb/os_users/oracle/shell',
# <md>          :displayname => 'Oracle OS User shell',
# <md>          :description => 'Oracle OS User shell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/bin/bash',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'oracledb/os_users/oracle/ldap_user',
# <md>          :displayname => 'Oracle ldap_user',
# <md>          :description => 'Oracle ldap_user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

default['oracledb']['os_users'] = {
  'oracle' => {
    'name' => 'oracle',
    'gid' =>  'oinstall',
    'comment' => 'Oracle Database User Administrator',
    'home' => '/home/oracle',
    'shell' => '/bin/bash',
    'ldap_user' => 'false'
  }
}
