# Cookbook Name:: ihs
# Recipe:: attributes/default
#
# Copyright IBM Corp. 2016, 2017
#

#-------------------------------------------------------------------------------
# Installer Configuration
#-------------------------------------------------------------------------------

# <> Software repo that contains binaries. Passed from environment/role.
default['ibm']['sw_repo'] = ''

# <> User for secure SW repo
default['ibm']['sw_repo_user'] = ''

# <> Vault password for SW repo user
default['ibm']['sw_repo_password'] = ''

# <> IM repository location
default['ibm']['im_repo'] = node['ibm']['sw_repo'] + '/IMRepo'

# <> User for secure IM repo
default['ibm']['im_repo_user'] = ''

# <> Vault password for IM repo user
default['ibm']['im_repo_password'] = ''


#-------------------------------------------------------------------------------
# Installation Options
#-------------------------------------------------------------------------------

# <> Product version to install
# <md>attribute 'ihs/version',
# <md>          :displayname =>  'IBM HTTP Server install version',
# <md>          :description => 'The version of IBM HTTP Server to install',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9.0.0.4',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['version'] = '9.0.0.2' # ~ip_checker

# <> Installation location for IBM HTTP Server
# <md>attribute 'ihs/install_dir',
# <md>          :displayname =>  'IBM HTTP Server installation directory',
# <md>          :description => 'The directory to install IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/HTTPServer',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['install_dir'] = '/opt/IBM/HTTPServer'

# <> Installation mode for IBM HTTP Server
# <md>attribute 'ihs/install_mode',
# <md>          :displayname =>  'IBM HTTP Server installation mode',
# <md>          :description => 'The mode of installation for IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'nonAdmin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['install_mode'] = 'nonAdmin'

# <> The filesystem permissions to be set for product directories
# <md>attribute 'ihs/os_perms',
# <md>          :displayname =>  'IBM HTTP Server file permissions',
# <md>          :description => 'The operating system permissions on IBM HTTP Server files',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '755',
# <md>          :hidden => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['os_perms'] = '755'

# <> Configure product to run automatically
# <md>attribute 'ihs/config_os_service',
# <md>          :displayname =>  'IBM HTTP Server config service',
# <md>          :description => 'Specifies whether to configure IBM HTTP Server as a service',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['config_os_service'] = 'true'

# NOTE: for a managed IBM HTTP Server the OS user settings need to match the WAS user settings.
# <> IBM HTTP Server OS user
# <md>attribute 'ihs/os_users/ihs/name',
# <md>          :displayname =>  'IBM HTTP Server username',
# <md>          :description => 'The username for IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ihssrv',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['os_users']['ihs']['name'] = 'ihssrv'

# <> IBM HTTP Server OS user group
# <md>attribute 'ihs/os_users/ihs/gid',
# <md>          :displayname =>  'IBM HTTP Server user group name',
# <md>          :description => 'The group name for the IBM HTTP Server user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ihsgrp',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['os_users']['ihs']['gid'] = 'ihsgrp'

# <> IBM HTTP Server OS user defined in LDAP
# <md>attribute 'ihs/os_users/ihs/ldap_user',
# <md>          :displayname =>  'IBM HTTP Server user LDAP',
# <md>          :description => 'Specifies if the IBM HTTP Server user is in LDAP',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['os_users']['ihs']['ldap_user'] = 'false'

# <> IBM HTTP Server OS user home directory
# <md>attribute 'ihs/os_users/ihs/home',
# <md>          :displayname =>  'IBM HTTP Server user home directory',
# <md>          :description => 'The IBM HTTP Server user home directory',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['os_users']['ihs']['home'] = 'default'

# <> IBM HTTP Server OS user comment
# <md>attribute 'ihs/os_users/ihs/shell',
# <md>          :displayname =>  'IBM HTTP Server OS user comment',
# <md>          :description => 'A comment associated with the IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'IBM HTTP Server OS user',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['os_users']['ihs']['comment'] = 'IBM HTTP Server OS user'

# <> IBM HTTP Server OS user shell
# <md>attribute 'ihs/os_users/ihs/shell',
# <md>          :displayname =>  'IBM HTTP Server OS user shell',
# <md>          :description => 'Location of the IBM HTTP Server operating system user shell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/sbin/nologin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['os_users']['ihs']['shell'] = '/sbin/nologin'

# <> IBM HTTP Server Features: Can be 32 or 64; not valid for v9 and up
# <md>attribute 'ihs/features/bitness',
# <md>          :displayname =>  'IBM HTTP Server 64 bit',
# <md>          :description => 'Indicate whether IBM HTTP Server is 64 bit',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '64',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['features']['bitness'] = '64'

# <> IBM HTTP Server v9 Java version
# <md>attribute 'ihs/java/version',
# <md>          :displayname =>  'IBM HTTP Server Java version',
# <md>          :description => 'The Java version to be used with IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8.0.4.70',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['java']['version'] = '8.0.4.70'

# <> IBM HTTP Server v85 Java version: starting with IBM HTTP Server v8.5.5.12
# <md>attribute 'ihs/java/legacy',
# <md>          :displayname =>  'IBM HTTP Server v855 Java version',
# <md>          :description => 'The Java version to be used with IBM HTTP Server version 8.5.5',
# <md>          :type => 'string',
# <md>          :choice => ['java6', 'java8'],
# <md>          :required => 'recommended',
# <md>          :default => 'java8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['java']['legacy'] = 'java8'

#-------------------------------------------------------------------------------
# Product configuration
#-------------------------------------------------------------------------------

# <> Service name for IBM HTTP Server
# <md>attribute 'ihs/service_name',
# <md>          :displayname => 'IBM HTTP Server service name',
# <md>          :description => 'IBM HTTP Server service name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ihssrv',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['service_name'] = 'ihs' + node['ihs']['version'].split('.').first(2).join

# <> Webserver port
# <md>attribute 'ihs/port',
# <md>          :displayname =>  'IBM HTTP Server port',
# <md>          :description => 'The IBM HTTP Server default port for HTTP requests',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '80',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['port'] = '80'

# <> Document root of main server
# <md>attribute 'ihs/document_root',
# <md>          :displayname =>  'IBM HTTP Server document root',
# <md>          :description => 'Designated directory for holding web pages in IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/HTTPServer/htdocs',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['document_root'] = node['ihs']['install_dir'] + '/htdocs'

# <> Server name for webservice
# <md>attribute 'ihs/server_name',
# <md>          :displayname =>  'IBM HTTP Server server name',
# <md>          :description => 'Fully qualified name of the server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['server_name'] = node['fqdn']

# <> Webserver admin email
# <md>attribute 'ihs/server_admin',
# <md>          :displayname =>  'IBM HTTP Server admin email',
# <md>          :description => 'The email address of the server admin for IBM HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['server_admin'] = 'you@your.address'

#-------------------------------------------------------------------------------
# WAS plugin options
#-------------------------------------------------------------------------------

# <> WAS plugin enable
# <md>attribute 'ihs/plugin/enabled',
# <md>          :displayname =>  'IBM HTTP Server plugin enabled',
# <md>          :description => 'IBM HTTP Server Plugin Enabled',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'remote',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['plugin']['enabled'] = 'false'

# <> WAS plugin install type - 'remote', 'local_standalone' or 'local_distributed'
# <md>attribute 'ihs/plugin/plugin_install_type',
# <md>          :displayname =>  'IBM HTTP Server plugin installation type',
# <md>          :description => 'IBM HTTP Server Plugin Installation Type',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'remote',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['plugin']['plugin_install_type'] = 'remote'

# <> WAS connection: webserver name
# <md>attribute 'ihs/plugin/was_webserver_name',
# <md>          :displayname =>  'IBM HTTP Server plugin hostname',
# <md>          :description => 'IBM HTTP Server Plugin Hostname, normally the FQDN',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'webserver1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['plugin']['was_webserver_name'] = node['fqdn']

# <> WAS connection: hostname
# <md>attribute 'ihs/plugin/was_hostname',
# <md>          :displayname =>  'IBM HTTP Server plugin DMGR hostname',
# <md>          :description => 'IBM HTTP Server plugin DMGR hostname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['plugin']['was_hostname'] = node['hostname']

# <> Tag string identifying the DMGR host
# <md>attribute 'ihs/plugin/dmgr_tag',
# <md>          :displayname =>  'IBM HTTP Server plugin DMGR tag',
# <md>          :description => 'The tag string identifying the DMGR host',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'DMGR',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['plugin']['dmgr_tag'] = 'DMGR'

# <> Installation location for WAS Plugin for IBM HTTP Server
# <md>attribute 'ihs/plugin/install_dir',
# <md>          :displayname =>  'IBM HTTP Server plugin installation directory',
# <md>          :description => 'IBM HTTP Server Plugin Installation Direcrtory',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/WebSphere/Plugins',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['plugin']['install_dir'] = File.dirname(node['ihs']['install_dir']) + '/WebSphere/Plugins'

#-------------------------------------------------------------------------------
# Admin server settings
#-------------------------------------------------------------------------------

# <> Admin server enable
# <md>attribute 'ihs/admin_server/enabled',
# <md>          :displayname =>  'IBM HTTP Server admin server enabled',
# <md>          :description => 'IBM HTTP Server Admin Server Enable(true/false)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['admin_server']['enabled'] = 'false'

# <> Service name for Admin server
# <md>attribute 'ihs/admin_server/service_name',
# <md>          :displayname =>  'IBM HTTP Server admin server service name',
# <md>          :description => 'IBM HTTP Server Admin Server Service Name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ihsadm',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['admin_server']['service_name'] = 'ihsadm' + node['ihs']['version'].split('.').first(2).join

# <> Admin server port
# <md>attribute 'ihs/admin_server/port',
# <md>          :displayname =>  'IBM HTTP Server admin server port',
# <md>          :description => 'IBM HTTP Server Admin Server Port Number',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8008',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['admin_server']['port'] = '8008'

# <> Admin server name
# <md>attribute 'ihs/admin_server/server_name',
# <md>          :displayname =>  'IBM HTTP Server admin server hostname',
# <md>          :description => 'IBM HTTP Server Admin Server fully qualified hostname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['admin_server']['server_name'] = node['fqdn']

# <> Document root of admin server
# <md>attribute 'ihs/admin_server/document_root',
# <md>          :displayname =>  'IBM HTTP Server admin server docuement root',
# <md>          :description => 'IBM HTTP Server Admin Server Docuement Root',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/HTTPServer/docroot',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['admin_server']['document_root'] = node['ihs']['document_root']

# <> Admin server authorized users
# <md>attribute 'ihs/admin_server/username',
# <md>          :displayname =>  'IBM HTTP Server admin server username',
# <md>          :description => 'IBM HTTP Server Admin Server username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ihsadmin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['ihs']['admin_server']['username'] = 'ihsadmin'

# <> Admin server authorized user password (in vault)
# <md>attribute 'ihs/admin_server/password',
# <md>          :displayname =>  'IBM HTTP Server admin server password',
# <md>          :description => 'IBM HTTP Server Admin Server Password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'
default['ihs']['admin_server']['password'] = ''

#-------------------------------------------------------------------------------
# SSL SETTINGS
#-------------------------------------------------------------------------------

# <> Create an SSL vhost and associated certificates
# <md>attribute 'ihs/ssl/enabled',
# <md>          :displayname =>  'IBM HTTP Server enable SSL',
# <md>          :description => 'IBM HTTP Server Enable SSL Port',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['ssl']['enabled'] = 'false'

# <> Port of SSL vhost
# <md>attribute 'ihs/ssl/port',
# <md>          :displayname =>  'IBM HTTP Server secure port',
# <md>          :description => 'IBM HTTP Server SSL Port Number',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '443',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['ssl']['port'] = '443'

# <> GSKIT keystore
# <md>attribute 'ihs/ssl/keystore',
# <md>          :displayname =>  'IBM HTTP Server keystore location',
# <md>          :description => 'IBM HTTP Server Keystore Location',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/HTTPServer/conf/key.kdb',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['ssl']['keystore'] = "#{node['ihs']['install_dir']}/conf/key.kdb"

# <> Certificate label
# <md>attribute 'ihs/ssl/cert_label',
# <md>          :displayname =>  'IBM HTTP Server keystore label name',
# <md>          :description => 'IBM HTTP Server keystore label name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['ihs']['ssl']['cert_label'] = 'selfSigned'

# <> GSKIT password (in vault)
# <md>attribute 'ihs/ssl/keystore_password',
# <md>          :displayname =>  'IBM HTTP Server keystore password',
# <md>          :description => 'IBM HTTP Server keystore password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'
default['ihs']['ssl']['keystore_password'] = ''
