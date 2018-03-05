#
# Cookbook Name:: oracle_mysql
# attributes :: default
#
# Copyright IBM Corp. 2016, 2017

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''
# <> The path on the repository server where the binaries, sources, scripts or other automation artifacts ar stored
default['ibm']['sw_repo_path'] = 'oracle/mysql/v5.7.17/base/'
# <> IBM sw_repo_user
default['ibm']['sw_repo_user'] = ''
# <> IBM sw_repo_pass
default['ibm']['sw_repo_password'] = ''


case node['platform_family']
when 'rhel'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> The directory where the installation logs and artifacts are stored
  default['ibm']['evidence_path']['unix'] = "#{node['ibm']['log_dir']}/evidence"
  # <> The name of the artifacts archive
  default['ibm']['evidence_zip'] = "#{node['ibm']['evidence_path']['unix']}/oracle_mysql-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "oracle_mysql-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.log"
when 'debian'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> The directory where the installation logs and artifacts are stored
  default['ibm']['evidence_path']['unix'] = "#{node['ibm']['log_dir']}/evidence"
  # <> The name of the artifacts archive
  default['ibm']['evidence_zip'] = "#{node['ibm']['evidence_path']['unix']}/oracle_mysql-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "oracle_mysql-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.log"
when 'windows'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = 'C:\\temp\\ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = 'C:\\temp\\ibm_cloud\\log'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '\\expand_area'
  # <> Oracle MySQL service name
  default['mysql']['service_name'] = 'mysqld'
end

# <> Decide wether to install from Repo Server or use yum/apt repo
# <md>attribute 'mysql/install_from_repo',
# <md>          :displayname => 'Install MySQL from Secure Repository',
# <md>          :description => 'Install MySQL from secure repository server or yum repo',
# <md>          :choice => [ 'true', 'false' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['install_from_repo'] = 'true'

# <> The operating system users and users properties
# <md>attribute 'mysql/os_users/daemon/name',
# <md>          :displayname => 'User Name of Default OS User for MySQL',
# <md>          :description => 'User Name of the default OS user to be used to configure MySQL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'mysql',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'mysql/os_users/daemon/gid',
# <md>          :displayname => 'Group Name of Default OS User for MySQL',
# <md>          :description => 'Group ID of the default OS user to be used to configure MySQL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'mysql',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'mysql/os_users/daemon/ldap_user',
# <md>          :displayname => 'Use LDAP for Authentication',
# <md>          :description => 'A flag which indicates whether to create the MQ USer locally, or utilise an LDAP based user.',
# <md>          :choice => [ 'true', 'false' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'mysql/os_users/daemon/home',
# <md>          :displayname => 'Home Directory of Default OS User for MySQL',
# <md>          :description => 'Home directory of the default OS user to be used to configure MySQL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/mysql',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'mysql/os_users/daemon/comment',
# <md>          :displayname => 'MySQL OS user description',
# <md>          :description => 'Comment associated with the MySQL OS user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'MySQL instance owner',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>attribute 'mysql/os_users/daemon/shell',
# <md>          :displayname => 'OS User Shell',
# <md>          :description => 'Default shell configured on Linux server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/bin/bash',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['os_users']['daemon'] = {
  'name' => 'mysql',
  'gid' => 'mysql',
  'ldap_user' => 'false',
  'home' => '/home/mysql',
  'comment' => 'MySQL instance owner',
  'shell' => '/bin/bash'
}

# <> Oracle MySQL version
# <md>attribute 'mysql/version',
# <md>          :displayname => 'MySQL Version',
# <md>          :description => 'MySQL Version to be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5.7.17',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['version'] = '5.7.17'
# <> Oracle MySQL root password
# <md>attribute 'mysql/root_password',
# <md>          :displayname => 'MySQL root password',
# <md>          :description => 'The password for the MySQL root user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :regex => "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}$",
# <md>          :regexdesc => "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character."
default['mysql']['root_password'] = ''


#-------------------------------------------------------------------------------
# MySQL  my.cnf configuration
#-------------------------------------------------------------------------------

# <> MySQL listen port
# <md>attribute 'mysql/config/port',
# <md>          :displayname => 'MySQL listen port',
# <md>          :description => 'Listen port to be configured in MySQL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '3306',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['port'] = '3306'
# <> MySQL database engine
# <md>attribute 'mysql/config/engine',
# <md>          :displayname => 'MySQL engine',
# <md>          :description => 'MySQL database engine',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'InnoDB',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['engine'] = 'InnoDB'
# <> MySQL database directory
# <md>attribute 'mysql/config/data_dir',
# <md>          :displayname => 'MySQL Data Directory',
# <md>          :description => 'Directory to store information managed by MySQL server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/lib/mysql',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['data_dir'] = '/var/lib/mysql'
# <> Pid file name
# <md>attribute 'mysql/config/pid',
# <md>          :displayname => 'mysql_pid_file',
# <md>          :description => 'MySQL pid file',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/run/mysqld/mysqld.pid',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['pid'] = '/var/run/mysqld/mysqld.pid'
# <> MySQL log file location
# <md>attribute 'mysql/config/log_file',
# <md>          :displayname => 'MySQL Log File',
# <md>          :description => 'Log file configured in MySQL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/log/mysqld.log',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['log_file'] = '/var/log/mysqld.log'
# <> MySQL socket
# <md>attribute 'mysql/config/socket',
# <md>          :displayname => 'mysql_socket',
# <md>          :description => 'MySQL socket',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/run/mysqld/mysql.sock',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['socket'] = '/var/run/mysqld/mysql.sock'
# <> MySQL buffer size
# <md>attribute 'mysql/config/key_buffer_size',
# <md>          :displayname => 'mysql_key_buffer_size',
# <md>          :description => 'Mysql key buffer size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '16M',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['key_buffer_size'] = '16M'
# <> MySQL maximum allowed packet size
# <md>attribute 'mysql/config/max_allowed_packet',
# <md>          :displayname => 'mysql_max_allowed_packet',
# <md>          :description => 'Mysql key buffer size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8M',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['mysql']['config']['max_allowed_packet'] = '8M'

# <> MySQL default database name
# <md>attribute 'mysql/config/databases/database_1/database_name',
# <md>          :displayname => 'Sample Database Name',
# <md>          :description => 'Create a sample database in MySQL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'MyDB',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <> MySQL default database user 1 name
# <md>attribute 'mysql/config/databases/database_1/users/user_1/name',
# <md>          :displayname => 'First User Name to Access the Sample Database',
# <md>          :description => 'Name of the first user which is created and allowed to access the created sample database ',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'defaultUser',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <> MySQL default database user 1 passwords
# <md>attribute 'mysql/config/databases/database_1/users/user_1/password',
# <md>          :displayname => 'First User Password to Access the Sample Database',
# <md>          :description => 'Password of the first user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :regex => ""^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}$",
# <md>          :regexdesc => "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character."
# <> MySQL default database user 2 name
# <md>attribute 'mysql/config/databases/database_1/users/user_2/name',
# <md>          :displayname => 'Second User Name to Access the Sample Database',
# <md>          :description => 'Name of the second user which is created and allowed to access the created sample database',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'defaultUser2',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <> MySQL default database user 2 passwords
# <md>attribute 'mysql/config/databases/database_1/users/user_2/password',
# <md>          :displayname => 'Second User Password to Access the Sample Database',
# <md>          :description => 'Password of the second user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :regex => ""^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}$",
# <md>          :regexdesc => "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character."

default['mysql']['config']['databases'] = {
  'database_1' => {
    'database_name' => 'default_database',
    'host_name' => node['fqdn'],
    'users' => {
      'user_1' => {
        'name' => 'defaultUser',
        'password' => ''
      },
      'user_2' => {
        'name' => 'defaultUser2',
        'password' => ''
      }
    }
  }
}
