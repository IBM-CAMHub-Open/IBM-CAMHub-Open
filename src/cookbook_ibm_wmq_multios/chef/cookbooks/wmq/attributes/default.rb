###############################################################################################
#
# Cookbook Name:: wmq
# Recipe:: default
#
# Copyright IBM Corp. 2016, 2017
#################################################################################################


#-------------------------------------------------------------------------------
# Installation Versions
#-------------------------------------------------------------------------------

# <> Version of IBM MQ to install
# <md> attribute 'wmq/version',
# <md>          :displayname => 'IBM MQ Version',
# <md>          :description => 'The Version of IBM MQ to install, eg, 8.0',
# <md>          :choice => [ '8.0',
# <md>                       '9.0' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9.0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'

default['wmq']['version'] = "9.0"


# <> Advanced Installation
# <md> attribute 'wmq/advanced',
# <md>          :displayname => 'IBM MQ Advanced Components',
# <md>          :description => 'Install IBM MQ Advanced components: File Transfer, IBM MQ Telemetry, and Advanced Message Security.',
# <md>          :choice => [ 'true',
# <md>                       'false' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'

default['wmq']['advanced'] = "false"

# <> Version of IBM MQ to install
# <md>attribute 'wmq/fixpack',
# <md>          :displayname => 'IBM MQ Fixpack',
# <md>          :description => 'The fixpack of IBM MQ to install.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :min => '1',
# <md>          :secret => 'false',
# <md>          :max => '20'

default['wmq']['fixpack'] = "1"

#-------------------------------------------------------------------------------
# Installation Directories
#-------------------------------------------------------------------------------

# <> Base Installation Directory
# <md>attribute 'wmq/install_dir',
# <md>          :displayname => 'IBM MQ Installation Directory',
# <md>          :description => 'The directory to install IBM MQ Binaries, recommended /opt/mqm',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/mqm',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'

default['wmq']['install_dir'] = '/opt/mqm'

# <> Base Data Installation Directory
# <md>attribute 'wmq/data_dir',
# <md>          :displayname => 'IBM MQ Data Directory',
# <md>          :description => 'The directory to install IBM MQ Data files, recommended /var/mqm',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/mqm',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'

default['wmq']['data_dir'] = '/var/mqm'

# <> WebSphere MQ Server Queue Manager Directory
# <md>attribute 'wmq/qmgr_dir',
# <md>          :displayname => 'IBM MQ Queue Manager Directory',
# <md>          :description => 'The directory to install IBM MQ Queue Manager Directory, recommended node[wmq][data_dir]/qmgrs',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/mqm/qmgrs',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'

default['wmq']['qmgr_dir'] = node['wmq']['data_dir'] + '/qmgrs'

# <> WebSphere MQ Server Log directory
# <md>attribute 'wmq/log_dir',
# <md>          :displayname => 'IBM MQ Log Directory',
# <md>          :description => 'The directory to install IBM MQ Log Directory, recommended -> node[wmq][data_dir]/log',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/mqm/log',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'

default['wmq']['log_dir'] = node['wmq']['data_dir'] + '/log'

#-------------------------------------------------------------------------------
# Pre-Requisites
#-------------------------------------------------------------------------------

# <md>attribute 'wmq/os_users/mqm/name',
# <md>          :displayname => 'IBM MQ OS Username',
# <md>          :description => 'Name of the Unix OS User that owns and controls IBM MQ',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'mqm',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'
# <md>attribute 'wmq/os_users/mqm/gid',
# <md>          :displayname => 'IBM MQ OS Group ID',
# <md>          :description => 'Group ID of the Unix OS User for IBM MQ',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'mqm',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'
# <md>attribute 'wmq/os_users/mqm/ldap_user',
# <md>          :displayname => 'IBM MQ Use LDAP for Authentication',
# <md>          :description => 'A flag which indicates whether to create the MQ USer locally, or utilise an LDAP based user.',
# <md>          :type => 'boolean',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'
# <md>attribute 'wmq/os_users/mqm/home',
# <md>          :displayname => 'IBM MQ OS User Home Directory',
# <md>          :description => 'Home Directory of Default OS User for IBM MQ User.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/mqm',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'
# <md>attribute 'wmq/os_users/mqm/comment',
# <md>          :displayname => 'IBM MQ OS User Comment',
# <md>          :description => 'Comment associated with the IBM MQ User',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'IBM MQ User',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'
# <md>attribute 'wmq/os_users/mqm/shell',
# <md>          :displayname => 'IBM MQ OS User Shell',
# <md>          :description => 'Location of the IBM MQ User Shell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/bin/bash',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'component'

# <> WebSphere MQ OS users
default['wmq']['os_users'] = {
  'mqm' => {
    'name' => 'mqm',
    'gid' => 'mqm',
    'ldap_user' => 'false',
    'home' => "/home/mqm",
    'comment' => 'IBM MQ User',
    'shell' => '/bin/bash'
  }
}


#-------------------------------------------------------------------------------
# Linux Kernel Configuration
#-------------------------------------------------------------------------------

# <> default file/directory parameters
# <md>attribute 'wmq/perms',
# <md>          :displayname => 'IBM MQ OS Permissions',
# <md>          :description => 'Default permissions for IBM MQ files on Unix',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '775',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['perms'] = '775'

# <> swap size in mega bytes
# <md>attribute 'wmq/swap_file_size',
# <md>          :displayname => 'IBM MQ Unix swap file size',
# <md>          :description => 'UNIX Swap size in megabytes',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '512',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['swap_file_size'] = '512'

# <> swap file name
# <md>attribute 'wmq/swap_file',
# <md>          :displayname => 'Swap Filename',
# <md>          :description => 'Swap file name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/swapfile',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['swap_file'] = '/swapfile'

# <> WebSphere MQ Server Kernel Configuration net_core_rmem_default
# <md>attribute 'wmq/net_core_rmem_default',
# <md>          :displayname => 'IBM MQ Kernel net_core_rmem_default',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_core_rmem_default',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '262144',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_core_rmem_default'] = '262144'

# <> WebSphere MQ Server Kernel Configuration net_core_rmem_max
# <md>attribute 'wmq/net_core_rmem_max',
# <md>          :displayname => 'IBM MQ Kernel net_core_rmem_max',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_core_rmem_max',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4194304',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_core_rmem_max'] = '4194304'

# <> WebSphere MQ Server Kernel Configuration net_core_wmem_default
# <md>attribute 'wmq/net_core_wmem_default',
# <md>          :displayname => 'IBM MQ Kernel net_core_wmem_default',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_core_wmem_default',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '262144',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_core_wmem_default'] = '262144'

# <> WebSphere MQ Server Kernel Configuration net_core_wmem_max
# <md>attribute 'wmq/net_core_wmem_max',
# <md>          :displayname => 'IBM MQ Kernel net_core_wmem_max',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_core_wmem_max',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1048576',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_core_wmem_max'] = '1048576'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_rmem
# <md>attribute 'wmq/net_ipv4_tcp_rmem',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_rmem',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_rmem',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4096    87380   4194304',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_rmem'] = '4096    87380   4194304'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_wmem
# <md>attribute 'wmq/net_ipv4_tcp_wmem',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_wmem',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_wmem',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4096    87380   4194304',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_wmem'] = '4096    87380   4194304'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_sack
# <md>attribute 'wmq/net_ipv4_tcp_sack',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_sack',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_sack',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_sack'] = '1'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_timestamps
# <md>attribute 'wmq/net_ipv4_tcp_timestamps',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_timestamps',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_timestamps',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_timestamps'] = '1'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_window_scaling
# <md>attribute 'wmq/net_ipv4_tcp_window_scaling',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_window_scaling',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_window_scaling',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_window_scaling'] = '1'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_time
# <md>attribute 'wmq/net_ipv4_tcp_keepalive_time',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_keepalive_time',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_time',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7200',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_keepalive_time'] = '7200'

# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_intvl
# <md>attribute 'wmq/net_ipv4_tcp_keepalive_intvl',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_keepalive_intvl',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_intvl',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '75',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_keepalive_intvl'] = '75'


# <> WebSphere MQ Server Kernel Configuration net_ipv4_tcp_fin_timeout
# <md>attribute 'wmq/net_ipv4_tcp_fin_timeout',
# <md>          :displayname => 'IBM MQ Kernel net_ipv4_tcp_fin_timeout',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration net_ipv4_tcp_fin_timeout',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '60',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['net_ipv4_tcp_fin_timeout'] = '60'

# <> WebSphere MQ Server Kernel Configuration vm_swappiness
# <md>attribute 'wmq/vm_swappiness',
# <md>          :displayname => 'IBM MQ Kernel vm_swappiness',
# <md>          :description => 'WebSphere MQ Server Kernel Configuration vm_swappiness',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['vm_swappiness'] = '0'

# <> WebSphere MQ Server Ulimit Nofile Value
# <md>attribute 'wmq/nofile_value',
# <md>          :displayname => 'IBM MQ Kernel Ulimit nofile_value',
# <md>          :description => 'WebSphere MQ Server Ulimit Nofile Value',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10240',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['nofile_value'] = '10240'

#-------------------------------------------------------------------------------
# Queue Manager Definition
#-------------------------------------------------------------------------------

# <md>attribute '$dynamicmaps/wmq/qmgr',
# <md>          :$displayname =>  'IBM MQ Queue Managers',
# <md>          :$key => 'qmgr',
# <md>          :$max => '4',
# <md>          :$count => '0'

# <> Definition of an IBM MQ Queue Manager on a single machine
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/name',
# <md>          :displayname => 'IBM MQ Queue Manager Name',
# <md>          :description => 'Name of the Queue Manager to Create',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'qmgr1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/description',
# <md>          :displayname => 'IBM MQ Queue Manager Description',
# <md>          :description => 'Description of the Queue Manager',
# <md>         :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Queue Manager 1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/listener_port',
# <md>          :displayname => 'IBM MQ Queue Manager Listener Port',
# <md>          :description => 'Port the Queue Manager listens on.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1414',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false',
# <md>          :min => '1025',
# <md>          :max => '50000'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/loggingtype',
# <md>          :displayname => 'IBM MQ Queue Manager Logging',
# <md>          :description => 'Type of logging to use ll(Linear), lc(Circular)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'lc',
# <md>          :choice => [ 'll',
# <md>                       'lc' ],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/primarylogs',
# <md>         :displayname => 'IBM MQ Queue Manager Primary Logs',
# <md>          :description => 'Number of primary logs to create.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',\
# <md>          :parm_type => 'node'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/secondarylogs',
# <md>          :displayname => 'IBM MQ Queue Manager Secondary Logs',
# <md>          :description => 'Number of Secondary Logs',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '20',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/logsize',
# <md>         :displayname => 'IBM MQ Queue Manager Log Size',
# <md>          :description => 'Size of the IBM MQ Logs',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '16384',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
# <md>attribute 'wmq/qmgr/qmgr($INDEX)/dlq',
# <md>          :displayname => 'IBM MQ Queue Manager dead letter queue',
# <md>          :description => 'Queue Manager dead letter queue',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'SYSTEM.DEAD.LETTER.QUEUE',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['qmgr'] = {
  'qmgr($INDEX)' => {
    'name' => 'QMGR1',
    'description' => 'QUEUE MANAGER 1',
    'listener_port'  => '1414',
    'loggingtype'    => 'lc',
    'primarylogs'    => '10',
    'secondarylogs'  => '20',
    'logsize'        => '16384',
    'dlq'            => 'SYSTEM.DEAD.LETTER.QUEUE'
  }
}

# <> WebSphere MQ Service name
# <md>attribute 'wmq/service_name',
# <md>          :displayname => 'IBM MQ Service Name',
# <md>          :description => 'WebSphere MQ service name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'mq',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['service_name'] = 'mq'

# <> WebSphere MQ Global Service Control
# <md>attribute 'wmq/global_mq_service',
# <md>          :displayname => 'IBM MQ Global Service control',
# <md>          :description => 'Option to defined service for all IBM MQ Queue Manager's',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :secret => 'false',
# <md>          :parm_type => 'node'
default['wmq']['global_mq_service'] = 'true'
