################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

#-------------------------------------------------------------------------------
# Installer Configuration
#-------------------------------------------------------------------------------

# <> Software repo that contains binaries. Passed from environment/role.
default['ibm']['sw_repo'] = ''

# <> User for secure SW repo
default['ibm']['sw_repo_user'] = ''

# <> Vault password for SW repo user
default['ibm']['sw_repo_password'] = ''

# <> Repo uses self-signed certificate?
default['ibm']['sw_repo_self_signed_cert'] = 'true'

# <> Installer work directory
default['ibm']['expand_area'] = '/tmp/ibm_cloud/expand_area'

# <> Installer log directory
default['ibm']['log_dir'] = '/var/log/ibm_cloud'

# <> Path for evidence
default['ibm']['evidence_path']['unix'] = "#{node['ibm']['log_dir']}/evidence"

# <> Evidence file
default['ibm']['evidence_tar'] = "#{node['ibm']['evidence_path']['unix']}/tomcat-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"

#-------------------------------------------------------------------------------
# Landscaper compatibility attributes
#-------------------------------------------------------------------------------

# <>  The stack id
default['ibm_internal']['stack_id'] = ''

# <>  The stack name
default['ibm_internal']['stack_name'] = ''

# <>  List of roles on the node
default['ibm_internal']['roles'] = ''

# <>  The vault name for this stack
default['ibm_internal']['vault']['name'] = ''

# <>  The vault item which will contain the secrets
default['ibm_internal']['vault']['item'] = 'password'

#-------------------------------------------------------------------------------
# Base Instance Configuration
#-------------------------------------------------------------------------------

# <> Tomcat version
# <md>attribute 'tomcat/version',
# <md>          :displayname =>  'Tomcat install version',
# <md>          :description => 'The version of Tomcat to be installed.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8.0.15',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['version'] = '8.0.15'

# <> Tomcat http port
# <md>attribute 'tomcat/http/port',
# <md>          :displayname =>  'Tomcat HTTP port',
# <md>          :description => 'The Tomcat port to service HTTP requests.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8080',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['http']['port'] = '8080'

# <> Tomcat AJP port
# <md>attribute 'tomcat/ajp/port',
# <md>          :displayname =>  'Tomcat AJP port',
# <md>          :description => 'Specifies the AJP port to be configured in Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8009',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ajp']['port'] = '8009'

# <> Tomcat server port
# <md>attribute 'tomcat/server/port',
# <md>          :displayname =>  'Tomcat server port',
# <md>          :description => 'Specifies the server port to be configured in Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8005',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['server']['port'] = '8005'

# <> Tomcat server shutdown command
# <md>attribute 'tomcat/server/shutdown_cmd',
# <md>          :displayname =>  'Tomcat shutdown command',
# <md>          :description => 'Specifies the command to be used to shutdown Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'SHUTDOWN',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :hidden => 'true',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['server']['shutdown_cmd'] = 'SHUTDOWN'

# <> Manage server.xml
# Set to true to have chef recreate the file at each run, if modified
# Set to false to allow manual unmanaged modifications
# <md>attribute 'tomcat/server/manage',
# <md>          :displayname =>  'Tomcat CHEF managed server.xml',
# <md>          :description => 'Specifies whether the tomcat server.xml is managed by CHEF or allows for manually modifications.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :hidden => 'true',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['server']['manage'] = 'false'

# <> Tomcat installation directory, same as CATALINA_HOME
# <md>attribute 'tomcat/install_dir',
# <md>          :displayname =>  'Tomcat install directory',
# <md>          :description => 'Specifies the directory to install Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['install_dir'] = '/opt/tomcat'

# <> Tomcat configuration directory
# <md>attribute 'tomcat/instance_dirs/conf_dir',
# <md>          :displayname =>  'Tomcat conf directory',
# <md>          :description => 'Specifies the directory for Tomcat configuration data.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat/conf',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['instance_dirs']['conf_dir'] = "#{node['tomcat']['install_dir']}/conf"

# <> Tomcat log directory
# <md>attribute 'tomcat/instance_dirs/log_dir',
# <md>          :displayname =>  'Tomcat logs directory',
# <md>          :description => 'Specifies the directory for Tomcat log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat/logs',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['instance_dirs']['log_dir'] = "#{node['tomcat']['install_dir']}/logs"

# <> Tomcat temp directory
# <md>attribute 'tomcat/instance_dirs/temp_dir',
# <md>          :displayname =>  'Tomcat temp directory',
# <md>          :description => 'Specifies the temporary directory for Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat/temp',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['instance_dirs']['temp_dir'] = "#{node['tomcat']['install_dir']}/temp"

# <> Tomcat webapps directory
# <md>attribute 'tomcat/instance_dirs/webapps_dir',
# <md>          :displayname =>  'Tomcat webapps directory',
# <md>          :description => 'Specifies the Tomcat directory for web applications.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat/webapps',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['instance_dirs']['webapps_dir'] = "#{node['tomcat']['install_dir']}/webapps"

# <> Tomcat work directory
# <md>attribute 'tomcat/instance_dirs/work_dir',
# <md>          :displayname =>  'Tomcat work directory',
# <md>          :description => 'Specifies the Tomcat working directory.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat/work',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['instance_dirs']['work_dir'] = "#{node['tomcat']['install_dir']}/work"

# <> Daemon User Name
# <md>attribute 'tomcat/os_users/daemon/name',
# <md>          :displayname =>  'Tomcat daemon user',
# <md>          :description => 'Specifies the user for the Tomcat daemon.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'tomcat',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['os_users']['daemon']['name'] = 'tomcat'

# <> Daemon User Unix Group
# <md>attribute 'tomcat/os_users/daemon/gid',
# <md>          :displayname =>  'Tomcat daemon user group',
# <md>          :description => 'Specifies the name of the Operating System group for Tomcat daemon users.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'tomcat',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['os_users']['daemon']['gid'] = 'tomcat'

# <> Daemon User from LDAP?
# <md>attribute 'tomcat/os_users/daemon/ldap_user',
# <md>          :displayname =>  'Tomcat daemon user ldap',
# <md>          :description => 'Specifies whether the Tomcat daemon user is stored in LDAP.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['os_users']['daemon']['ldap_user'] = 'false'

# <> Daemon User Comment
# <md>attribute 'tomcat/os_users/daemon/comment',
# <md>          :displayname =>  'Tomcat daemon user comment',
# <md>          :description => 'Specifies a login comment for the Tomcat daemon user.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'tomcat daemon user',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['os_users']['daemon']['comment'] = 'tomcat daemon user'

# <> Daemon User Unix shell
# <md>attribute 'tomcat/os_users/daemon/shell',
# <md>          :displayname =>  'Tomcat daemon shell',
# <md>          :description => 'The Tomcat daemon Unix shell.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/sbin/nologin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['os_users']['daemon']['shell'] = '/sbin/nologin'

# <> Daemon User home directory
# <md>attribute 'tomcat/os_users/daemon/home',
# <md>          :displayname =>  'Tomcat daemon user home directory',
# <md>          :description => 'Specifies the home directory of the Tomcat daemon user.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/tomcat',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['os_users']['daemon']['home'] = '/home/' + node['tomcat']['os_users']['daemon']['name']

#-------------------------------------------------------------------------------
# Service options
#-------------------------------------------------------------------------------

# <> Tomcat service name
# <md>attribute 'tomcat/service/name',
# <md>          :displayname =>  'Tomcat service name',
# <md>          :description => 'Specifies the Tomcat service name.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'tomcat',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['service']['name'] = 'tomcat'

# <> Desired Tomcat service state
# <md>attribute 'tomcat/service/started',
# <md>          :displayname =>  'Tomcat service state',
# <md>          :description => 'Specifies the desired Tomcat service state.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :hidden => 'true',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['service']['started'] = 'true'

# <> Desired Tomcat service post-boot behaviour, will start automatically if setting this to 'true'
# <md>attribute 'tomcat/service/enabled',
# <md>          :displayname =>  'Tomcat service enabled',
# <md>          :description => 'Specifies whether the Tomcat service will be started automatically on server reboot.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :hidden => 'true',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['service']['enabled'] = 'true'

#-------------------------------------------------------------------------------
# Webapp options
#-------------------------------------------------------------------------------

# <> Tomcat webapps to install - ROOT
# <md>attribute 'tomcat/webapps/enabled/ROOT',
# <md>          :displayname =>  'Tomcat webapp ROOT',
# <md>          :description => 'Tomcat webapp ROOT',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['webapps']['enabled']['ROOT'] = 'true'

# <> Tomcat webapps to install - manager
# <md>attribute 'tomcat/webapps/enabled/manager',
# <md>          :displayname =>  'Tomcat webapp manager',
# <md>          :description => 'Specifies whether to install the Tomcat manager webapp.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['webapps']['enabled']['manager'] = 'true'

# <> Tomcat webapps to install - host-manager
# <md>attribute 'tomcat/webapps/enabled/host-manager',
# <md>          :displayname =>  'Tomcat webapp host-manager',
# <md>          :description => 'Specifies whether to install the Tomcat host-manager webapp.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :choice => ['true', 'false'],
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['webapps']['enabled']['host-manager'] = 'true'

# <> Tomcat webapps to install - docs
# <md>attribute 'tomcat/webapps/enabled/docs',
# <md>          :displayname =>  'Tomcat webapp docs',
# <md>          :description => 'Specifies whether to install the Tomcat webapp examples documentation.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :choice => ['true', 'false'],
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['webapps']['enabled']['docs'] = 'true'

# <> Tomcat webapps to install - examples
# <md>attribute 'tomcat/webapps/enabled/examples',
# <md>          :displayname =>  'Tomcat webapp examples',
# <md>          :description => 'Specifies whether to install the Tomcat webapp examples.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['true', 'false'],
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['webapps']['enabled']['examples'] = 'true'

#-------------------------------------------------------------------------------
# Server Access Control
#-------------------------------------------------------------------------------

# <> Tomcat Roles - manager-gui
# <md>attribute 'tomcat/ui_control/all_roles/manager-gui',
# <md>          :displayname =>  'Tomcat roles: manager-gui',
# <md>          :description => 'Tomcat roles: manager-gui',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['all_roles']['manager-gui'] = 'enabled'

# <> Tomcat Roles - manager-script
# <md>attribute 'tomcat/ui_control/all_roles/manager-script',
# <md>          :displayname =>  'Tomcat roles: manager-script',
# <md>          :description => 'Tomcat roles: manager-script',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['all_roles']['manager-script'] = 'enabled'

# <> Tomcat Roles - manager-jmx
# <md>attribute 'tomcat/ui_control/all_roles/manager-jmx',
# <md>          :displayname =>  'Tomcat roles: manager-jmx',
# <md>          :description => 'Tomcat roles: manager-jmx',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['all_roles']['manager-jmx'] = 'enabled'

# <> Tomcat Roles - manager-status
# <md>attribute 'tomcat/ui_control/all_roles/manager-status',
# <md>          :displayname =>  'Tomcat roles: manager-status',
# <md>          :description => 'Tomcat roles: manager-status',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'enabled',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['all_roles']['manager-status'] = 'enabled'

# <> Tomcat Roles - admin-gui
# <md>attribute 'tomcat/ui_control/all_roles/admin-gui',
# <md>          :displayname =>  'Tomcat roles: admin-gui',
# <md>          :description => 'Tomcat roles: admin-gui',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['all_roles']['admin-gui'] = 'enabled'

# <> Tomcat Users - administrator: status
# <md>attribute 'tomcat/ui_control/users/administrator/status',
# <md>          :displayname =>  'Tomcat admin status',
# <md>          :description => 'Specifies whether to enable the admin user in the Tomcat configuration.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['status'] = 'enabled'

# <> Tomcat Users - administrator: name
# <md>attribute 'tomcat/ui_control/users/administrator/name',
# <md>          :displayname =>  'Tomcat admin username',
# <md>          :description => 'Name of the admin user to be configured in Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'admin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['name'] = 'admin'

# <> Tomcat Users - administrator: password
# <md>attribute 'tomcat/ui_control/users/administrator/password',
# <md>          :displayname =>  'Tomcat admin user password',
# <md>          :description => 'Password of the admin user to be configured in Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.'

default['tomcat']['ui_control']['users']['administrator']['password'] = ''

# <> Tomcat Users - administrator roles: manager-gui
# <md>attribute 'tomcat/ui_control/users/administrator/user_roles/manager-gui',
# <md>          :displayname =>  'Tomcat users administrator roles: manager-gui',
# <md>          :description => 'Tomcat users administrator roles: manager-gui',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-gui'] = 'enabled'

# <> Tomcat Users - administrator roles: manager-script
# <md>attribute 'tomcat/ui_control/users/administrator/user_roles/manager-script',
# <md>          :displayname =>  'Tomcat users administrator roles: manager-script',
# <md>          :description => 'Tomcat users administrator roles: manager-script',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-script'] = 'enabled'

# <> Tomcat Users - administrator roles: manager-jmx
# <md>attribute 'tomcat/ui_control/users/administrator/user_roles/manager-jmx',
# <md>          :displayname =>  'Tomcat users administrator roles: manager-jmx',
# <md>          :description => 'Tomcat users administrator roles: manager-jmx',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-jmx'] = 'enabled'

# <> Tomcat Users - administrator roles: manager-status
# <md>attribute 'tomcat/ui_control/users/administrator/user_roles/manager-status',
# <md>          :displayname =>  'Tomcat users administrator roles: manager-status',
# <md>          :description => 'Tomcat users administrator roles: manager-status',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-status'] = 'enabled'

# <> Tomcat Users - administrator roles: admin-gui
# <md>attribute 'tomcat/ui_control/users/administrator/user_roles/admin-gui',
# <md>          :displayname =>  'Tomcat users administrator roles: admin-gui',
# <md>          :description => 'Tomcat users administrator roles: admin-gui',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :choice => ['enabled', 'disabled'],
# <md>          :default => 'enabled',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ui_control']['users']['administrator']['user_roles']['admin-gui'] = 'enabled'

#-------------------------------------------------------------------------------
# SSL options
#-------------------------------------------------------------------------------

# <> Flag used to enable SSL setup
# <md>attribute 'tomcat/ssl/enabled',
# <md>          :displayname =>  'Tomcat SSL enabled',
# <md>          :description => 'Indicates whether to enable the Tomcat SSL connector.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['enabled'] = 'true'

# <> Tomcat SSL port
# <md>attribute 'tomcat/ssl/port',
# <md>          :displayname =>  'Tomcat SSL port',
# <md>          :description => 'Tomcat port for SSL communication',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8443',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['ssl_port'] = '8443'

# <> SSL options - maxThreads
# <md>attribute 'tomcat/ssl/options/max_threads',
# <md>          :displayname =>  'Tomcat SSL options max threads',
# <md>          :description => 'Tomcat SSL options max threads',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '200',
# <md>          :selectable => 'true',
# <md>          :hidden => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',

# <md>          :secret => 'false'
default['tomcat']['ssl']['options']['max_threads'] = '200'

# <> SSL options - sslProtocol
# <md>attribute 'tomcat/ssl/options/protocol',
# <md>          :displayname =>  'Tomcat SSL options protocol',
# <md>          :description => 'Tomcat SSL options protocol',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'TLS',
# <md>          :hidden => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['options']['protocol'] = 'TLS'

# <> SSL options - ciphers
# <md>attribute 'tomcat/ssl/options/ciphers',
# <md>          :displayname =>  'Tomcat SSL options ciphers',
# <md>          :description => 'Tomcat SSL options ciphers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_RC4_128_SHA,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA,SSL_RSA_WITH_RC4_128_SHA',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['tomcat']['ssl']['options']['ciphers'] = 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_RC4_128_SHA,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA,SSL_RSA_WITH_RC4_128_SHA'

# <> Certificate: Common Name
# <md>attribute 'tomcat/ssl/cert/cn',
# <md>          :displayname =>  'Tomcat SSL certificate common name',
# <md>          :description => 'Tomcat SSL certificate common name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['cn'] = node['fqdn']

# <> Certificate: Organizational Unit
# <md>attribute 'tomcat/ssl/cert/ou',
# <md>          :displayname =>  'Tomcat SSL certificate organizational unit',
# <md>          :description => 'Tomcat SSL certificate organizational unit',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Org',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['ou'] = 'Org'

# <> Certificate: Organization
# <md>attribute 'tomcat/ssl/cert/o',
# <md>          :displayname =>  'Tomcat SSL certificate organization',
# <md>          :description => 'Tomcat SSL certificate organization',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Company',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['o'] = 'Company'

# <> Certificate: Country
# <md>attribute 'tomcat/ssl/cert/c',
# <md>          :displayname =>  'Tomcat SSL certificate country',
# <md>          :description => 'Tomcat SSL certificate country',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'US',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['c'] = 'US'

# <> Certificate: State
# <md>attribute 'tomcat/ssl/cert/s',
# <md>          :displayname =>  'Tomcat SSL certificate state',
# <md>          :description => 'Tomcat SSL certificate state',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'MN',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['s'] = 'MN'

# <> Certificate: Location
# <md>attribute 'tomcat/ssl/cert/l',
# <md>          :displayname =>  'Tomcat SSL certificate location',
# <md>          :description => 'Tomcat SSL certificate location',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Rochester',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['l'] = 'Rochester'

# <> Certificate: Validity
# <md>attribute 'tomcat/ssl/cert/validity',
# <md>          :displayname =>  'Tomcat SSL certificate validity',
# <md>          :description => 'Tomcat SSL certificate validity period',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '3650',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['validity'] = '3650'

# <> Certificate: Alias
# <md>attribute 'tomcat/ssl/cert/alias',
# <md>          :displayname =>  'Tomcat SSL certificate alias',
# <md>          :description => 'Tomcat SSL certificate alias for identification in the keystore',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'tomcat',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['cert']['alias'] = 'tomcat'

# <> Path for certificate file
# <md>attribute 'tomcat/ssl/keystore/file',
# <md>          :displayname =>  'Tomcat SSL keystore file',
# <md>          :description => 'Path to the Tomcat SSL Keystore file.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/tomcat/conf/keystore.jks',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['keystore']['file'] = "#{node['tomcat']['install_dir']}/conf/#{node['fqdn']}.jks"

# <> Keystore type
# <md>attribute 'tomcat/ssl/keystore/type',
# <md>          :displayname =>  'Tomcat SSL keystore type',
# <md>          :description => 'Specifies the keystore type for which Tomcat supports JKS, PKCS11 or PKCS12 formats.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'JKS',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['keystore']['type'] = 'JKS'

# <> Keystore algorithm
# <md>attribute 'tomcat/ssl/keystore/alg',
# <md>          :displayname =>  'Tomcat SSL keystore algorithm',
# <md>          :description => 'The RSA algorithm should be preferred as a secure algorithm.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'RSA',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['ssl']['keystore']['alg'] = 'RSA'

# <> Password for certificate file
# <md>attribute 'tomcat/ssl/keystore/password',
# <md>          :displayname =>  'Tomcat SSL keystore password',
# <md>          :description => 'The keystore password used in Tomcat for SSL configuration.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.'
default['tomcat']['ssl']['keystore']['password'] = ''

#-------------------------------------------------------------------------------
# Java options
#-------------------------------------------------------------------------------

# <> Java version
# Format should be compatible with distribution
# openjdk: 1.8.0
# Oracle java: 8u121
# IBM java: 8.0-4.1
# <md>attribute 'tomcat/java/version',
# <md>          :displayname =>  'Tomcat java version',
# <md>          :description => 'The version of Java to be used for Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '1.8.0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['java']['version'] = '1.8.0'

# <> Java flavor
# <md>attribute 'tomcat/java/java_sdk',
# <md>          :displayname =>  'Tomcat Java Flavor',
# <md>          :description => 'Specifies the use of a Java Development Kit (false) or Runtime Environment (true).',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['java']['java_sdk'] = 'false'

# <> Java vendor. Currently only openjdk is supported.
# <md>attribute 'tomcat/java/vendor',
# <md>          :displayname =>  'Tomcat Java Vendor',
# <md>          :description => 'Currently only openjdk is supported as the Tomcat java vendor.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'openjdk',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['java']['vendor'] = 'openjdk'

# <> Java options, JAVA_OPTS
# <md>attribute 'tomcat/java/java_opts',
# <md>          :displayname =>  'Tomcat java_opts',
# <md>          :description => 'Specifies additional options for commands to start, stop and more on Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['java']['java_opts'] = '-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

# <> Java options, CATALINA_OPTS
# <md>attribute 'tomcat/java/catalina_opts',
# <md>          :displayname =>  'Tomcat catalina_opts',
# <md>          :description => 'Specifies additional options on the java command used to start Tomcat.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '-Xms512M -Xmx1024M -server -XX:+UseParallelGC',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['tomcat']['java']['catalina_opts'] = '-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
