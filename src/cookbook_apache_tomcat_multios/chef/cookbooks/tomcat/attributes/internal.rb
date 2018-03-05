################################################################################
# Copyright IBM Corp. 2017, 2017
################################################################################

#-------------------------------------------------------------------------------
# Chef-vault Options
#-------------------------------------------------------------------------------

# <> Name of the vault containing credentials for GSKIT db and admin server authorization
force_default['tomcat']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
force_default['tomcat']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

#-------------------------------------------------------------------------------
# Installer Attributes
#-------------------------------------------------------------------------------

# <> Temporary location of binaries
force_default['tomcat']['expand_area'] = "#{node['ibm']['expand_area']}/tomcat"

# <> Validation script name
force_default['tomcat']['validation_script'] = node['ibm']['evidence_path']['unix'] + '/tomcat_validation.sh'

# <> Validation log
force_default['tomcat']['validation_log'] = 'tomcat-' + node['hostname'] + '.log'

#-------------------------------------------------------------------------------
# Tomcat Attributes
#-------------------------------------------------------------------------------

# <> Tomcat base package, prerequisites and optional packages
force_default['tomcat']['archive_names']['tomcat']['filename'] = 'apache-tomcat-' + node['tomcat']['version'] + '.tar.gz'

# <> Relative path in repo
force_default['tomcat']['sw_repo_path']['base'] = "apache/tomcat/v#{node['tomcat']['version'].split('.').first}0/base"

#-------------------------------------------------------------------------------
# Java Attributes
#-------------------------------------------------------------------------------

# <> Java relative path in repo
force_default['tomcat']['sw_repo_path']['java'] = 'java/java8/xLinux64'

case node['tomcat']['java']['vendor']
when 'openjdk'
  # <> Java home
  default['tomcat']['java']['java_home'] = 'test' # will be set automatically; when set manually, make sure it matches distribution and version
else
  # <> Java package URL
  default['tomcat']['java']['package_url'] = node['ibm']['sw_repo'] + '/java/' + 'ibm-java-' + 'jre' + '-' + node['tomcat']['java']['version'] + '-x86_64-archive.bin'
  # <> Java installation directory
  default['tomcat']['java']['install_dir'] = '/usr/java/'
  # Java home will resolve to install_dir
  default['tomcat']['java']['java_home'] = node['tomcat']['java']['install_dir']
end
