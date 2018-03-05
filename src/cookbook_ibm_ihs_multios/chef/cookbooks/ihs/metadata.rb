name             'ihs'
maintainer       'IBM Corp'
maintainer_email ''
license 'Copyright IBM Corp. 2012, 2017'
description      'Installs/Configures IBM HTTP server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.2'
depends          'ibm_cloud_utils'
depends          'im'
description <<-EOH
## DESCRIPTION

This cookbook installs and configures IBM HTTP Server.

## Platforms Support

* RHEL 6.x
* RHEL 7.x
* Ubuntu Server 14.04 or greater

## Versions

* IBM HTTP Server 9.0
* IBM HTTP Server 8.5.5

## Use Cases

* IHS installation via IM LWRP, admin mode
* IHS installation via IM LWRP, nonAdmin mode

## Platform Pre-Requisites

* Linux YUM Repository - An onsite linux YUM Repsoitory is required.

## IM Package Repository
IM_REPO -> Stored in the ['ibm']['im_repo'] attribute.
EOH



supports "RHEL6", ">= 6.5"
supports "RHEL7"
supports "ubuntu", ">= 14.04"



attribute 'ihs/admin_server/document_root',
          :default => '/opt/IBM/HTTPServer/docroot',
          :description => 'IBM HTTP Server Admin Server Docuement Root',
          :displayname => 'IBM HTTP Server admin server docuement root',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/admin_server/enabled',
          :default => 'false',
          :description => 'IBM HTTP Server Admin Server Enable(true/false)',
          :displayname => 'IBM HTTP Server admin server enabled',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/admin_server/password',
          :default => '',
          :description => 'IBM HTTP Server Admin Server Password',
          :displayname => 'IBM HTTP Server admin server password',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/admin_server/port',
          :default => '8008',
          :description => 'IBM HTTP Server Admin Server Port Number',
          :displayname => 'IBM HTTP Server admin server port',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/admin_server/server_name',
          :default => '',
          :description => 'IBM HTTP Server Admin Server fully qualified hostname',
          :displayname => 'IBM HTTP Server admin server hostname',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/admin_server/service_name',
          :default => 'ihsadm',
          :description => 'IBM HTTP Server Admin Server Service Name',
          :displayname => 'IBM HTTP Server admin server service name',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/admin_server/username',
          :default => 'ihsadmin',
          :description => 'IBM HTTP Server Admin Server username',
          :displayname => 'IBM HTTP Server admin server username',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/config_os_service',
          :default => 'true',
          :description => 'Specifies whether to configure IBM HTTP Server as a service',
          :displayname => 'IBM HTTP Server config service',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/document_root',
          :default => '/opt/IBM/HTTPServer/htdocs',
          :description => 'Designated directory for holding web pages in IBM HTTP Server',
          :displayname => 'IBM HTTP Server document root',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/features/bitness',
          :default => '64',
          :description => 'Indicate whether IBM HTTP Server is 64 bit',
          :displayname => 'IBM HTTP Server 64 bit',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/install_dir',
          :default => '/opt/IBM/HTTPServer',
          :description => 'The directory to install IBM HTTP Server',
          :displayname => 'IBM HTTP Server installation directory',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/install_mode',
          :default => 'nonAdmin',
          :description => 'The mode of installation for IBM HTTP Server',
          :displayname => 'IBM HTTP Server installation mode',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/java/legacy',
          :choice => ['java6', 'java8'],
          :default => 'java8',
          :description => 'The Java version to be used with IBM HTTP Server version 8.5.5',
          :displayname => 'IBM HTTP Server v855 Java version',
          :hidden => 'false',
          :options => ['java6', 'java8'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/java/version',
          :default => '8.0.4.70',
          :description => 'The Java version to be used with IBM HTTP Server',
          :displayname => 'IBM HTTP Server Java version',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/os_perms',
          :default => '755',
          :description => 'The operating system permissions on IBM HTTP Server files',
          :displayname => 'IBM HTTP Server file permissions',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/os_users/ihs/gid',
          :default => 'ihsgrp',
          :description => 'The group name for the IBM HTTP Server user',
          :displayname => 'IBM HTTP Server user group name',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/os_users/ihs/home',
          :default => 'default',
          :description => 'The IBM HTTP Server user home directory',
          :displayname => 'IBM HTTP Server user home directory',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/os_users/ihs/ldap_user',
          :default => 'false',
          :description => 'Specifies if the IBM HTTP Server user is in LDAP',
          :displayname => 'IBM HTTP Server user LDAP',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/os_users/ihs/name',
          :default => 'ihssrv',
          :description => 'The username for IBM HTTP Server',
          :displayname => 'IBM HTTP Server username',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/os_users/ihs/shell',
          :default => '/sbin/nologin',
          :description => 'Location of the IBM HTTP Server operating system user shell',
          :displayname => 'IBM HTTP Server OS user shell',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/plugin/dmgr_tag',
          :default => 'DMGR',
          :description => 'The tag string identifying the DMGR host',
          :displayname => 'IBM HTTP Server plugin DMGR tag',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/plugin/enabled',
          :default => 'remote',
          :description => 'IBM HTTP Server Plugin Enabled',
          :displayname => 'IBM HTTP Server plugin enabled',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/plugin/install_dir',
          :default => '/opt/IBM/WebSphere/Plugins',
          :description => 'IBM HTTP Server Plugin Installation Direcrtory',
          :displayname => 'IBM HTTP Server plugin installation directory',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/plugin/plugin_install_type',
          :default => 'remote',
          :description => 'IBM HTTP Server Plugin Installation Type',
          :displayname => 'IBM HTTP Server plugin installation type',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/plugin/was_hostname',
          :default => '',
          :description => 'IBM HTTP Server plugin DMGR hostname',
          :displayname => 'IBM HTTP Server plugin DMGR hostname',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/plugin/was_webserver_name',
          :default => 'webserver1',
          :description => 'IBM HTTP Server Plugin Hostname, normally the FQDN',
          :displayname => 'IBM HTTP Server plugin hostname',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/port',
          :default => '80',
          :description => 'The IBM HTTP Server default port for HTTP requests',
          :displayname => 'IBM HTTP Server port',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/server_admin',
          :default => '',
          :description => 'The email address of the server admin for IBM HTTP Server',
          :displayname => 'IBM HTTP Server admin email',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/server_name',
          :default => '',
          :description => 'Fully qualified name of the server',
          :displayname => 'IBM HTTP Server server name',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/service_name',
          :default => 'ihssrv',
          :description => 'IBM HTTP Server service name',
          :displayname => 'IBM HTTP Server service name',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/ssl/cert_label',
          :default => '',
          :description => 'IBM HTTP Server keystore label name',
          :displayname => 'IBM HTTP Server keystore label name',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/ssl/enabled',
          :default => 'false',
          :description => 'IBM HTTP Server Enable SSL Port',
          :displayname => 'IBM HTTP Server enable SSL',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/ssl/keystore',
          :default => '/opt/IBM/HTTPServer/conf/key.kdb',
          :description => 'IBM HTTP Server Keystore Location',
          :displayname => 'IBM HTTP Server keystore location',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/ssl/keystore_password',
          :default => '',
          :description => 'IBM HTTP Server keystore password',
          :displayname => 'IBM HTTP Server keystore password',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/ssl/port',
          :default => '443',
          :description => 'IBM HTTP Server SSL Port Number',
          :displayname => 'IBM HTTP Server secure port',
          :hidden => 'true',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'ihs/version',
          :default => '9.0.0.4',
          :description => 'The version of IBM HTTP Server to install',
          :displayname => 'IBM HTTP Server install version',
          :hidden => 'false',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
recipe 'ihs::cleanup.rb', '
Cleanup recipe (cleanup.rb)
Perform post-install cleanup
'
recipe 'ihs::config_admin_conf.rb', '
Configure admin server recipe (config_admin_conf.rb)
Create admin.conf and service script for the admin server
'
recipe 'ihs::config_httpd_conf.rb', '
Main server configuration recipe (config_httpd_conf.rb)
Configure main server and service file
'
recipe 'ihs::config_ssl_selfsigned.rb', '
SSL configuration recipe (config_ssl_selfsigned.rb)
Configure a SSL vhost and associated self-signed certificates
'
recipe 'ihs::config_wasplugin.rb', '
WAS plugin configuration recipe (config_wasplugin.rb)
Configure the WAS plugin
'
recipe 'ihs::default.rb', '
Default recipe (default.rb)
Perform minimal product installation
'
recipe 'ihs::gather_evidence.rb', '
Gather evidence recipe (gather_evidence.rb)
Gather evidence that installation was successful
'
recipe 'ihs::install.rb', '
Installation recipe (install.rb)
Perform installation of the main asset
'
recipe 'ihs::prereq.rb', '
Prerequisites recipe (prereq.rb)
Perform prerequisite actions
'
recipe 'ihs::prereq_check.rb', '
Prerequisites recipe (prereq_check.rb)
Verify required prerequisites, validate input
'
recipe 'ihs::service_admin.rb', '
Configure admin server recipe (service_admin.rb)
Configure and manage admin server service
'
recipe 'ihs::service_httpd.rb', '
Configure web server recipe (service_httpd.rb)
Configure and manage web service
'
