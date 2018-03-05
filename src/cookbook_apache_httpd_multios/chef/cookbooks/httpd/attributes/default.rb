#
# Cookbook Name:: httpd
# attributes :: default
#
# Copyright IBM Corp. 2016, 2017

# <> Product specific defaults

# <> Root dir of the install; for chroot or SCL type installs
# <md>attribute 'httpd/install_dir',
# <md>          :displayname =>  'HTTP Installation Directory',
# <md>          :description => 'Directory where  HTTP Server will be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['install_dir'] = ''

# <> Service name
# <md>attribute 'httpd/service_name',
# <md>          :displayname =>  'HTTP Server Service Name',
# <md>          :description => 'Name the HTTP Server process will run as',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
case node['platform_family']
when 'rhel'
  force_default['httpd']['service_name'] = 'httpd'
when 'debian'
  force_default['httpd']['service_name'] = 'apache2'
end

# <> Logging directory of the Apache install
# <md>attribute 'httpd/log_dir',
# <md>          :displayname =>  'HTTP Log Directory',
# <md>          :description => 'Directory where HTTP Server logs will be sent',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['log_dir'] = "/var/log/" + node['httpd']['service_name']

# <> Webserver log level
# <md>attribute 'httpd/log_level',
# <md>          :displayname =>  'HTTP Server Log Levels',
# <md>          :description => 'Log levels of the http process',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'warn',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['log_level'] = 'warn'

# <> Webserver error log filename
# <md>attribute 'httpd/error_log',
# <md>          :displayname =>  'HTTP Server Error Log name',
# <md>          :description => 'Name of the error log, for the standard virtual host.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'error_log',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['error_log'] = 'error_log'

# <> Webserver custom log filename
# <md>attribute 'httpd/custom_log',
# <md>          :displayname =>  'HTTP Server Custom Log name',
# <md>          :description => 'Name of the custom log, for the standard virtual host.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'access_log',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['custom_log'] = 'access_log'

# <> Enable PHP mod
# <md>attribute 'httpd/php_mod_enabled',
# <md>          :displayname =>  'Enable PHP Module',
# <md>          :description => 'Enable PHP in Apache on Linux by Loading the Module',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['php_mod_enabled'] = 'true'

# <> Apache HTTP Server Installation version
# <md>attribute 'httpd/version',
# <md>          :displayname =>  'HTTP Server version',
# <md>          :description => 'Version of HTTP Server to be installed.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '2.4',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['version'] = '2.4'

# <> Server root
# <md>attribute 'httpd/server_root',
# <md>          :displayname =>  'httpd server_root',
# <md>          :description => 'httpd server_root',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['server_root'] = node['httpd']['install_dir'] + "/etc/" + node['httpd']['service_name']

# <> Webserver home
# <md>attribute 'httpd/httpd_home',
# <md>          :displayname =>  'Home Directory of the HTTP Server Process',
# <md>          :description => 'Directory of the HTTP Server Process.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['httpd_home'] = node['httpd']['install_dir'] + "/var/www"

# <> Webserver document root
# <md>attribute 'httpd/document_root',
# <md>          :displayname =>  'HTTP Server Document Root Location',
# <md>          :description => 'File System Location of the Document Root',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['document_root'] = node['httpd']['install_dir'] + "/var/www/html"

# <> Directory mode for data
# <md>attribute 'httpd/data_dir_mode',
# <md>          :displayname =>  'HTTP Server OS Permissions Data Directory',
# <md>          :description => 'OS Permisssions of data folders',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '0750',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['data_dir_mode'] = '0750'

# <> File mode for configuration files
# <md>attribute 'httpd/conf_file_mode',
# <md>          :displayname =>  'HTTP Server OS Poermissions Configuration Files',
# <md>          :description => 'OS Permisssions of confguration files',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '0640',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['conf_file_mode'] = '0640'

# <> Main server port
# <md>attribute 'httpd/listen',
# <md>          :displayname =>  'HTTP Server Listen Port',
# <md>          :description => 'Listening port to be configured in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '80',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['listen'] = '80'

# <> Main server server-name
# <md>attribute 'httpd/server_name',
# <md>          :displayname =>  'HTTPd Server Name',
# <md>          :description => 'The Name of the HTTP Server, normally the FQDN of server.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['server_name'] = node['fqdn']

# <> Webserver custom log format
# <md>attribute 'httpd/custom_log_format',
# <md>          :displayname =>  'HTTP Server Log Directory',
# <md>          :description => 'Directory of log to be configured in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'combined',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['custom_log_format'] = 'combined'

# <> Webserver admin
# <md>attribute 'httpd/server_admin',
# <md>          :displayname =>  'HTTP Server Admin',
# <md>          :description => 'Email Address of the Webmaster',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'webmaster@localhost',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['server_admin'] = 'webmaster@localhost'

# <> Webserver directory index
# <md>attribute 'httpd/directory_index',
# <md>          :displayname => 'HTTP Server Enable Directory Listing',
# <md>          :description => 'Enable or Disable directory listing',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'index.html info.php',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['directory_index'] = 'index.html info.php'

# <> UseCanonicalName
# <md>attribute 'httpd/use_canonical_name',
# <md>          :displayname =>  'Enable HTTP Server Canonical hostname',
# <md>          :description => 'Should the HTTP Server use the canonical hostname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Off',
# <md>          :choice => ['On', 'Off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['use_canonical_name'] = 'Off'

# <> Timeout
# <md>attribute 'httpd/timeout',
# <md>          :displayname =>  'HTTP Server TCP timeout',
# <md>          :description => 'httpd timeout',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'off',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['timeout'] = '60'

# <> KeepAlive
# <md>attribute 'httpd/keep_alive',
# <md>          :displayname =>  'HTTP Server keep_alive',
# <md>          :description => 'HTTP Server TCP Keep alive',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Off',
# <md>          :choice => ['On', 'Off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['keep_alive'] = 'Off'

# <> MaxKeepAliveRequests
# <md>attribute 'httpd/max_keep_alive_requests',
# <md>          :displayname =>  'HTTP Server TCP max_keep_alive_requests',
# <md>          :description => 'HTTP Server max_keep_alive_requests',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '100',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['max_keep_alive_requests'] = '100'

# <> KeepAliveTimeout
# <md>attribute 'httpd/keep_alive_timeout',
# <md>          :displayname =>  'HTTP Server keep_alive_timeout',
# <md>          :description => 'HTTP Server keep_alive_timeout',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '15',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['keep_alive_timeout'] = '15'

# <> HostnameLookups
# <md>attribute 'httpd/hostname_lookups',
# <md>          :displayname =>  'HTTP Server hostname_lookups',
# <md>          :description => 'HTTP Server hostname_lookups',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Off',
# <md>          :choice => ['On', 'Off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

default['httpd']['hostname_lookups'] = 'Off'

# <> EnableMMAP
# <md>attribute 'httpd/enable_MMAP',
# <md>          :displayname =>  'HTTP Server enable_MMAP',
# <md>          :description => 'HTTP Server enable_MMAP',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'off',
# <md>          :choice => ['on', 'off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['enable_MMAP'] = 'off'

# <> EnableSendFile
# <md>attribute 'httpd/enable_send_file',
# <md>          :displayname =>  'HTTP Server enable_send_file',
# <md>          :description => 'HTTP Server enable_send_file',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'off',
# <md>          :choice => ['on', 'off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['enable_send_file'] = 'off'

# <> Prefork StartServers: number of server processes to start
# <md>attribute 'httpd/prefork_start_servers',
# <md>          :displayname =>  'HTTP Server prefork_start_servers',
# <md>          :description => 'HTTP Server prefork_start_servers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['prefork_start_servers'] = '8'

# <> Prefork MinSpareServers: minim['vhost_1']um number of server processes which are kept spare
# <md>attribute 'httpd/prefork_min_spare_servers',
# <md>          :displayname =>  'HTTP Server prefork_min_spare_servers',
# <md>          :description => 'HTTP Server prefork_min_spare_servers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['prefork_min_spare_servers'] = '5'

# <> Prefork MaxSpareServers: maximum number of server processes which are kept spare
# <md>attribute 'httpd/prefork_max_spare_servers',
# <md>          :displayname => 'HTTP Server prefork_max_spare_servers',
# <md>          :description => 'HTTP Server prefork_max_spare_servers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '20',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['prefork_max_spare_servers'] = '20'

# <> Prefork ServerLimit: maximum value for MaxClients for the lifetime of the server
# <md>attribute 'httpd/prefork_server_limit',
# <md>          :displayname =>  'HTTP Server prefork_server_limit',
# <md>          :description => 'HTTP Server prefork_server_limit',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '256',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['prefork_server_limit'] = '256'

# <> Prefork MaxClients: maximum number of server processes allowed to start
# <md>attribute 'httpd/prefork_max_clients',
# <md>          :displayname =>  'HTTP Server prefork_max_clients',
# <md>          :description => 'HTTP Server prefork_max_clients',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '256',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['prefork_max_clients'] = '256'

# <> Prefork MaxRequestsPerChild: maximum number of requests a server process serves
# <md>attribute 'httpd/prefork_max_requests_per_child',
# <md>          :displayname =>  'HTTP Server prefork_max_requests_per_child',
# <md>          :description => 'HTTP Server prefork_max_requests_per_child',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4000',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['prefork_max_requests_per_child'] = '4000'

# <> Worker StartServers: number of server processes to start
# <md>attribute 'httpd/worker_start_servers',
# <md>          :displayname =>  'HTTP Server worker_start_servers',
# <md>          :description => 'HTTP Server worker_start_servers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['worker_start_servers'] = '4'

# <> Worker MinSpareServers: minimum number of server processes which are kept spare
# <md>attribute 'httpd/worker_min_spare_servers',
# <md>          :displayname =>  'HTTP Server worker_min_spare_servers',
# <md>          :description => 'HTTP Server worker_min_spare_servers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '300',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['worker_min_spare_servers'] = '300'

# <> Worker MaxSpareServers: maximum number of server processes which are kept spare
# <md>attribute 'httpd/worker_max_spare_servers',
# <md>          :displayname =>  'HTTP Server worker_max_spare_servers',
# <md>          :description => 'HTTP Server worker_max_spare_servers',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '25',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['worker_max_spare_servers'] = '25'

# <> Worker ServerLimit: maximum value for MaxClients for the lifetime of the server
# <md>attribute 'httpd/worker_server_limit',
# <md>          :displayname =>  'HTTP Server worker_server_limit',
# <md>          :description => 'HTTP Server worker_server_limit',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '75',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['worker_server_limit'] = '75'

# <> Worker MaxClients: maximum number of server processes allowed to start
# <md>attribute 'httpd/worker_max_clients',
# <md>          :displayname =>  'HTTP Server worker_max_clients',
# <md>          :description => 'HTTP Server worker_max_clients',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '25',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['worker_max_clients'] = '25'

# <> Worker MaxRequestsPerChild: maximum number of requests a server process serves
# <md>attribute 'httpd/worker_max_requests_per_child',
# <md>          :displayname =>  'HTTP Server worker_max_requests_per_child',
# <md>          :description => 'HTTP Server worker_max_requests_per_child',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['worker_max_requests_per_child'] = '0'

# <> OS Service Users
# <md>attribute 'httpd/os_users/daemon/name',
# <md>          :displayname =>  'HTTP Server daemon name',
# <md>          :description => 'HTTP Server daemon name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'apache',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/daemon/gid',
# <md>          :displayname =>  'HTTP Server daemon gid',
# <md>          :description => 'HTTP Server daemon gid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'apache',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/daemon/ldap_user',
# <md>          :displayname => 'HTTP Server daemon ldap_user',
# <md>          :description => 'HTTP Server daemon ldap_user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/daemon/home',
# <md>          :displayname =>  'HTTP Server daemon home',
# <md>          :description => 'HTTP Server daemon home',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/daemon/comment',
# <md>          :displayname =>  'HTTP Server daemon comment',
# <md>          :description => 'HTTP Server daemon comment',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'HTTP Server daemon user',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/daemon/shell',
# <md>          :displayname =>  'HTTP Server daemon shell',
# <md>          :description => 'HTTP Server daemon shell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/sbin/nologin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['os_users']['daemon'] = {
  'name'      => 'apache',
  'gid'       => 'apache',
  'ldap_user' => 'false',
  'home'      => "#{node['httpd']['install_dir']}/usr/share/httpd",
  'comment'   => 'httpd daemon user',
  'shell'     => '/sbin/nologin'
}

# <> Web content owner
# <md>attribute 'httpd/os_users/web_content_owner/name',
# <md>          :displayname =>  'User Name of HTTP Web Content Owner',
# <md>          :description => 'User ID of web content owner to be configured in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'webmaster',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/web_content_owner/gid',
# <md>          :displayname =>  'Group Name of HTTP Web Content Owner',
# <md>          :description => 'Group ID of web content owner to be configured in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'apache',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/web_content_owner/ldap_user',
# <md>          :displayname =>  'Use LDAP for Authentication',
# <md>          :description => 'Use LDAP to authenticate Web Content Owner account on Linux HTTP server as well as web site logins',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/web_content_owner/home',
# <md>          :displayname =>  'Home Directory of HTTP Web Content Owner',
# <md>          :description => 'Home directory of web content owner to be configured in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/webmaster',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/web_content_owner/comment',
# <md>          :displayname =>  'HTTP Server HTTP Web Content Owner comment',
# <md>          :description => 'Comment, describing the User purpose',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'httpd daemon user',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :hidden => 'true',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'httpd/os_users/web_content_owner/shell',
# <md>          :displayname =>  'HTTP Server HTTP Web Content Owner Unix Shell',
# <md>          :description => 'Default shell configured on Linux server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/bin/bash',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['httpd']['os_users']['web_content_owner'] = {
  'name'      => 'webmaster',
  'gid'       => node['httpd']['os_users']['daemon']['gid'],
  'ldap_user' => 'false',
  'home'      => '/home/webmaster',
  'comment'   => 'Web content owner',
  'shell'     => '/bin/bash'
}

#-------------------------------------------------------------------------------
# SSL configuration
#-------------------------------------------------------------------------------
# <> SSL log dir
default['httpd']['ssl']['log_dir'] = node['httpd']['log_dir']
# <> SSL transfer log filename
default['httpd']['ssl']['transfer_log'] = 'ssl_transfer_log'
# <> SSL log level
default['httpd']['ssl']['log_level'] = 'warn'
# <> SSL self-signed certificate filename
default['httpd']['ssl']['certificate_name'] = node['fqdn']
# <> SSL self-signed certificate path
default['httpd']['ssl']['certificate_path'] = "#{node['httpd']['server_root']}/ssl"

# <md>attribute 'httpd/ssl/install_mod_ssl',
# <md>          :displayname =>  'Enable SSL Module',
# <md>          :description => 'Enable SSL within HTTP Server Configuration',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

default['httpd']['ssl']['install_mod_ssl'] = 'true'

# <md>attribute 'httpd/ssl/sslcompression',
# <md>          :displayname =>  'Enable SSL Compression',
# <md>          :description => 'Enable SSL compression within HTTP Server Configuration',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Off',
# <md>          :choice => ['On', 'Off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['ssl']['sslcompression'] = "Off"

# <md>attribute 'httpd/ssl/sslproxycacertificatefile',
# <md>          :displayname =>  'SSL proxy Certificate file name',
# <md>          :description => 'SSL proxy Certificate file name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'PleaseProvide',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['ssl']['sslproxycacertificatefile'] = "PleaseProvide"

# <md>attribute 'httpd/ssl/sslproxycacertificatepath',
# <md>          :displayname =>  'SSL proxy Certificate file path',
# <md>          :description => 'SSL proxy Certificate file path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'PleaseProvide',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['ssl']['sslproxycacertificatepath'] = "PleaseProvide"

# <md>attribute 'httpd/ssl/sslproxycarevocationcheck',
# <md>          :displayname =>  'SSL proxy CA revocation check',
# <md>          :description => 'SSL proxy CA revocation check',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'PleaseProvide',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['ssl']['sslproxycarevocationcheck'] = "PleaseProvide"

# <md>attribute 'httpd/ssl/sslproxycarevocationfile',
# <md>          :displayname =>  'SSL proxy CA revocation file',
# <md>          :description => 'SSL proxy CA revocation file',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'PleaseProvide',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['ssl']['sslproxycarevocationfile'] = "PleaseProvide"

# <md>attribute 'httpd/ssl/https_port',
# <md>          :displayname =>  'HTTP Server SSL Port',
# <md>          :description => 'Secure Port for the HTTP Server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '443',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['ssl']['https_port'] = '443'


#-------------------------------------------------------------------------------
# vhost configuration
#-------------------------------------------------------------------------------

# <md>attribute 'httpd/vhosts_enabled',
# <md>          :displayname =>  'Enable Virtual Host Configuration',
# <md>          :description => 'Allow to configure virtual hosts to run multiple websites on the same HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['vhosts_enabled'] = 'true'

# <md>attribute 'httpd/virtualhosts/default_http_server/vhost_type',
# <md>          :displayname =>  'HTTP - Virtual Host type, name-based HTTP virtual host',
# <md>          :description => 'Allow to configure virtual hosts to run multiple websites on the same HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'name_based',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/vhost_listen',
# <md>          :displayname =>  'HTTP - Listen Port in Virtual Host for HTTP communication',
# <md>          :description => 'Listening port configured in virtual host for HTTP communication in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '80',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/server_name',
# <md>          :displayname =>  'HTTP - Virtual Host server name for directing requests',
# <md>          :description => 'Vhost server name for directing requests',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/document_root',
# <md>          :displayname =>  'HTTP - Default HTTP Server Virtual Host Document Root',
# <md>          :description => 'Location of the Default Docuement Root',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/log_dir',
# <md>          :displayname =>  'HTTP - Default HTTP Server Virtual Host Log Directory'',
# <md>          :description => 'Location of the HTTP Server Log Directory',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/error_log',
# <md>          :displayname =>  'HTTP - Default HTTP Server Virtual Host Error Log Directory',
# <md>          :description => 'Location of the HTTP Server Error Log',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/custom_log',
# <md>          :displayname =>  'HTTP - Default HTTP Server Virtual Host Custom Log Directory',
# <md>          :description => 'Location of the HTTP Server Custom Log',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/custom_log_format',
# <md>          :displayname =>  'HTTP - Default HTTP Server Virtual Host Custom Log Format',
# <md>          :description => 'Log Format of the Custom Log',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'combined',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/server_admin',
# <md>          :displayname =>  'HTTP - Default HTTP Server Virtual Host Server Admin',
# <md>          :description => 'Email address of the Server Admin',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/ssl_enabled',
# <md>          :displayname =>  'HTTP - Enable SSL for Virtual Host for HTTPS Communication',
# <md>          :description => 'Enable SSL for virtual host for HTTPS communication in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/proxy_enabled',
# <md>          :displayname =>  'HTTP - Enable Proxy for Virtual Host for HTTP Communication',
# <md>          :description => 'Enable proxy usage for virtual host for HTTP Communication in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/virtualhosts/default_http_server/global_ssl_config',
# <md>          :displayname =>  'HTTP - Use Default Global Configuration for HTTP Communication',
# <md>          :description => 'Use default global configuration for HTTP communication in HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['virtualhosts']= {
  'default_http_server' => {
    # <> Vhost type - name_based or ip_based
    'vhost_type' => 'name_based',
    # <> Vhost port
    'vhost_listen' => node['httpd']['listen'],
    # <> Vhost server name
    'server_name' => "vhost_1.#{node['fqdn']}",
    # <> Vhost document root
    'document_root' => "#{node['httpd']['httpd_home']}/vhost_http.#{node['fqdn']}",
    # <> Vhost log dir
    'log_dir' => node['httpd']['log_dir'],
    # <> Vhost error log
    'error_log' => "vhost_1.#{node['fqdn']}_error_log",
    # <> Vhost custom log
    'custom_log' => "vhost_1.#{node['fqdn']}_custom_log",
    # <> Vhost custom log format
    'custom_log_format' => 'combined',
    # <> Vhost Server admin
    'server_admin' => node['httpd']['server_admin'],
    # <> SSL Enabled for Virtual Host
    'ssl_enabled' => 'false',
    # <> Proxy Enabled for Virtual Host
    'proxy_enabled' => 'false',
    # <> Global SSL configuration
    'global_ssl_config' => 'true'
  },

  # <md>attribute 'httpd/virtualhosts/default_https_server/vhost_type',
  # <md>          :displayname =>  'HTTPS - Virtual Host type, name-based HTTPS virtual host',
  # <md>          :description => 'Specify type of virtual host for HTTPS communication in HTTPS server',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => 'name_based',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/vhost_listen',
  # <md>          :displayname =>  'HTTPS - Listen Port in Virtual Host for HTTPS communication',
  # <md>          :description => 'Listening port configured in virtual host for HTTPS communication in HTTP server',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '443',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/server_name',
  # <md>          :displayname =>  'HTTPS -  virtual host servername',
  # <md>          :description => 'HTTPS Virtual host server name for directing requests',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/document_root',
  # <md>          :displayname =>  'HTTPS - virtual host DocumentRoot',
  # <md>          :description => 'HTTPS virtual host document root',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/log_dir',
  # <md>          :displayname =>  'HTTPS -  virtual host LogDir',
  # <md>          :description => 'HTTPS virtual host log dir',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/error_log',
  # <md>          :displayname =>  'HTTPS -  virtual host ErrorLogDir',
  # <md>          :description => 'HTTPS Virtual host error log dir',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/custom_log',
  # <md>          :displayname =>  'HTTPS -  virtual host CustomLogDir',
  # <md>          :description => 'HTTPS Virtual host custom log dir',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/custom_log_format',
  # <md>          :displayname =>  'HTTPS -  virtual host CustomLogFormat',
  # <md>          :description => 'HTTPS Virtual host custom log format',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => 'combined',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/server_admin',
  # <md>          :displayname =>  'HTTPS -  virtual host ServerAdmin',
  # <md>          :description => 'HTTPS Virtual host server admin',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => '',
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/ssl_enabled',
  # <md>          :displayname =>  'HTTPS - Enable SSL for Virtual Host for HTTP Communication',
  # <md>          :description => 'HTTPS - Enable SSL for virtual host for HTTP communication in HTTP server',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => 'true',
  # <md>          :selectable => 'true',
  # <md>          :choice => ['true', 'false'],
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/proxy_enabled',
  # <md>          :displayname =>  'HTTPS -  virtual host enable proxy configuration',
  # <md>          :description => 'Enable proxy configuration',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => 'true',
  # <md>          :selectable => 'true',
  # <md>          :choice => ['true', 'false']
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'
  # <md>attribute 'httpd/virtualhosts/default_https_server/global_ssl_config',
  # <md>          :displayname =>  'HTTPS - Use Default Global Configuration for HTTPS Communication',
  # <md>          :description => 'Use default global configuration for HTTPS communication in HTTP server',
  # <md>          :type => 'string',
  # <md>          :required => 'recommended',
  # <md>          :default => 'true',
  # <md>          :choice => ['true', 'false'],
  # <md>          :selectable => 'true',
  # <md>          :precedence_level => 'node',
  # <md>          :parm_type => 'node',
  # <md>          :secret => 'false'

  'default_https_server' => {
    # <> Vhost type - name_based or ip_based
    'vhost_type' => 'name_based',
    # <> Vhost port
    'vhost_listen' => '443',
    # <> Vhost server name
    'server_name' => "vhost_2.#{node['fqdn']}",
    # <> Vhost document root
    'document_root' => "#{node['httpd']['httpd_home']}/vhost_https.#{node['fqdn']}",
    # <> Vhost log dir
    'log_dir' => "#{node['httpd']['log_dir']}/",
    # <> Vhost error log
    'error_log' => "vhost_2.#{node['fqdn']}_error_log",
    # <> Vhost custom log
    'custom_log' => "vhost_2.#{node['fqdn']}_custom_log",
    # <> Vhost custom log format
    'custom_log_format' => 'combined',
    # <> Vhost Server admin
    'server_admin' => node['httpd']['server_admin'],
    # <> SSL Enabled for Virtual Host
    'ssl_enabled' => 'true',
    # <> Proxy Enabled for Virtual Host
    'proxy_enabled' => 'false',
    # <> Global SSL configuration
    'global_ssl_config' => 'true'

  }
}

# <> Apache HTTPD proxy settings
# <md>attribute 'httpd/proxy/ProxyPreserveHost',
# <md>          :displayname =>  'Enable ProxyPreserveHost',
# <md>          :description => 'Instruct the reverse proxy to preserve original host header from the client browser',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'On',
# <md>          :choice => ['On', 'Off'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/proxy/rules/ProxyPass/path',
# <md>          :displayname =>  'HTTP Server ProxyPass path',
# <md>          :description => 'HTTP Server ProxyPass path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/sw/',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/proxy/rules/ProxyPass/url',
# <md>          :displayname =>  'HTTP Server ProxyPass url',
# <md>          :description => 'HTTP Server ProxyPass url',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'http://localhost',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/proxy/rules/ProxyPassReverse/path',
# <md>          :displayname =>  'HTTP Server ProxyPassReverse path',
# <md>          :description => 'HTTP Server ProxyPassReverse path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/sw/',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
# <md>attribute 'httpd/proxy/rules/ProxyPassReverse/url',
# <md>          :displayname =>  'HTTP Server ProxyPassReverse url',
# <md>          :description => 'HTTP Server ProxyPassReverse url',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'http://localhost',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['httpd']['proxy'] = {
  'ProxyPreserveHost' => 'On',
  'rules' => { 'ProxyPass' => [],
               'ProxyPassReverse' => []
  }
}
