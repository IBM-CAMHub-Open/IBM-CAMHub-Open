#
# Cookbook Name:: httpd
# attributes :: internal
#
# Copyright IBM Corp. 2016, 2017

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
default['ibm_internal']['vault']['item'] = ''

#-------------------------------------------------------------------------------
# Secure repo parameters
#-------------------------------------------------------------------------------

# <> self signed certificate
default['ibm']['sw_repo_self_signed_cert'] = 'false'

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''

# <> IBM sw_repo_user
default['ibm']['sw_repo_user'] = ''

# <> IBM sw_repo_pass
default['ibm']['sw_repo_password'] = ''

# <> The path on the repository server where the binaries, sources, scripts or other automation artifacts ar stored
force_default['httpd']['sw_repo_path'] = '/apache/httpd/v2.4.25/base/'

# <> The paths repo server for each distribution
case node['platform_family']
when 'rhel', 'debian'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> The directory where the installation logs and artifacts are stored
  default['ibm']['evidence_path']['unix'] = "#{node['ibm']['log_dir']}/evidence"
when 'windows'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = 'C:\\temp\\ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = 'C:\\temp\\ibm_cloud\\log'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '\\expand_area'
end

# <> The path on the repo server for each distribution
case node['platform_family']
when 'rhel'
  # <> The name of the artifacts archive
  force_default['httpd']['evidence_zip'] = "#{node['ibm']['evidence_path']['unix']}/httpd-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"
  # <> The name of the log file for gathered evidence
  force_default['httpd']['evidence_log'] = "httpd-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.log"
  # <> PHP packages rhel
  force_default['httpd']['php_packages'] = ['php', 'php-mysql']
  # <> Prereqisite packages
  force_default['httpd']['prereq_packages'] = ['pyOpenSSL', 'openssl', 'net-tools']
  # <> HTTP packages
  force_default['httpd']['server_packages'] = ['httpd', 'httpd-tools']
  # <> HTTP service name
  force_default['httpd']['service_name'] = 'httpd'
when 'debian'
  # <> The name of the artifacts archive
  force_default['httpd']['evidence_zip'] = "#{node['ibm']['evidence_path']['unix']}/httpd-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.tar"
  # <> The name of the log file for gathered evidence
  force_default['httpd']['evidence_log'] = "httpd-#{node['hostname']}-#{Time.now.strftime('%Y-%m-%d%H-%M-%S')}.log"
  # <> PHP packages ubuntu
  if node['platform'] == 'ubuntu'
    if node['platform_version'].split('.').first.to_i == 14
      force_default['httpd']['php_packages'] = ['php5', 'libapache2-mod-php5']      
    elsif node['platform_version'].split('.').first.to_i == 16
      force_default['httpd']['php_packages'] = ['php', 'libapache2-mod-php', 'php-mcrypt']
    end
  end
  # <> Prereqisite packages
  if node['platform'] == 'ubuntu'
    if node['platform_version'].split('.').first.to_i == 14 
      force_default['httpd']['prereq_packages'] = ['python3-openssl', 'openssl', 'net-tools']
    elsif node['platform_version'].split('.').first.to_i == 16
      force_default['httpd']['prereq_packages'] = ['python3-cffi-backend-api-9729', 'python3-idna', 'python3-pyasn1', 'python3-cryptography', 'python3-openssl', 'openssl', 'net-tools'] 
    end
  end
  # <> HTTP packages
  force_default['httpd']['server_packages'] = ['apache2', 'apache2-utils']
  # <> HTTP service name
  force_default['httpd']['service_name'] = 'apache2'
when 'windows'
  # <> Prereq packages windows
  force_default['httpd']['prereq_packages'] = ['php5.msi', 'libapache2-mod-php5.msi', 'php5-mcrypt.msi']
end


# <> A temporary directory used for the extraction of installation files
force_override['httpd']['expand_area'] = node['ibm']['expand_area'] + '/' + 'httpd'

#-------------------------------------------------------------------------------
# Vault parameters
#-------------------------------------------------------------------------------

# <> Apache httpd vault name
# <md> attribute 'httpd/vault/name',
# <md>          :displayname => 'vault_name',
# <md>          :description => 'The chef vault name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
force_default['httpd']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
# <md> attribute 'httpd/vault/encrypted_id',
# <md>          :displayname => 'vault_encrypted_id',
# <md>          :description => 'The chef vault encrypted_id',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
force_default['httpd']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']
