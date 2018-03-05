# Cookbook Name::was
# Recipe:: internal
#
#         Copyright IBM Corp. 2016, 2017
#
# <> This file contains the preset attributes that have the highest level of precendence.
#
#

############################################################################################################
# STANDARD Environemnt Settings
############################################################################################################

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>

default['ibm']['sw_repo'] = ''

default['ibm']['sw_repo_user'] = ''

default['ibm']['sw_repo_password'] = ''

default['ibm']['im_repo'] = ''

default['ibm']['im_repo_user'] = ''

default['ibm']['im_repo_password'] = ''

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


default['was']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['was']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']


default['was']['OS_supported'] = {
  'windows'  => "true",
  'rhel'    => "true",
  'centos'  => "true",
  'debian'  => "true",
  'sles'   =>  "false"
}

case node['platform_family']
when 'rhel'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> The directory where the installation logs and artifacts are stored
  default['ibm']['evidence_path'] = "#{node['ibm']['log_dir']}/evidence"
  # <> The name of the artifacts archive
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}/was-#{node['hostname']}.tar"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "was-#{node['hostname']}.log"
when 'windows'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = 'C:\\temp\\ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = 'C:\\temp\\ibm_cloud\\log'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '\\expand_area'
  # <> The directory where the installation logs and artifacts are stored
  default['ibm']['evidence_path'] = "#{node['ibm']['log_dir']}/evidence"
  # <> The name of the artifacts archive
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}\\was-#{node['hostname']}.zip"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "was-#{node['hostname']}.log"
end

# <> A temporary directory used for the extraction of installation files
force_override['was']['expand_area'] = node['ibm']['expand_area'] + '/was'

# <> Installation mode for IBM WebSphere Application Server
default['was']['install_mode'] = 'nonAdmin'


case node['was']['version']
when /^8.5.5/ # ~ip_checker
  #<> Installation templates for WebSphere
  force_default['was']['install_template'] = 'WAS.install.xml.erb'

  force_default['was']['im_install_template'] = 'WAS.install.xml'


  #<>IBM Installation Manager offering ID to be used for installation, based on WAS edition
  default['was']['offering_id'] = {
    'base' => 'com.ibm.websphere.BASE.v85',
    'nd' => 'com.ibm.websphere.ND.v85'
  }

  #<> IBM Installation Manager profile to be used for installation, based on WAS edition
  default['was']['profile_id'] = {
    'base' => 'IBM WebSphere Application Server V8.5',
    'nd' => 'IBM WebSphere Application Server Network Deployment V8.5'
  }

when /^9.0.0/ # ~ip_checker
  #<> Installation templates for WebSphere
  force_default['was']['install_template'] = 'WAS.install.xml.erb'

  force_default['was']['im_install_template'] = 'WAS.install.xml'

  #<>IBM Installation Manager offering ID to be used for installation, based on WAS edition
  default['was']['offering_id'] = {
    'base' => 'com.ibm.websphere.BASE.v90',
    'nd' => 'com.ibm.websphere.ND.v90'
  }

  #<> IBM Installation Manager profile to be used for installation, based on WAS edition
  default['was']['profile_id'] = {
    'base' => 'IBM WebSphere Application Server V9.0',
    'nd' => 'IBM WebSphere Application Server Network Deployment V9.0'
  }
end

#<> Prerequisite packages for a Redhat Installation
case node['platform_family']
when 'rhel'
  default['was']['prereq_packages'] = if node['platform_version'].to_i >= 7
    #Removing compat-libstdc++-296 and gtk2-engines paxkages for RHEL7 as its not supported. gtk2-engines is required only for the Installation manager GUI which will not be supported on RHEL7
    %w(compat-libstdc++-33 compat-db ksh gtk2 psmisc pam rpm-build elfutils elfutils-libs libXft glibc libgcc nss-softokn-freebl nss-softokn-freebl libXp libXmu libXtst openssl libXp libXmu libXtst pam gtk2)
                                      else
    %w(compat-libstdc++-33 compat-db ksh gtk2 gtk2-engines pam rpm-build elfutils elfutils-libs libXft glibc libgcc nss-softokn-freebl nss-softokn-freebl libXp libXmu libXtst openssl libXp libXmu libXtst pam compat-libstdc++-296 gtk2 gtk2-engines)
                                      end
  #[compat-libstdc++-33', 'compat-db', 'ksh', 'gtk2', 'gtk2-engines', 'pam', 'rpm-build', 'elfutils', 'elfutils-libs', 'libXft', 'glibc', 'libgcc', 'nss-softokn-freebl', 'nss-softokn-freebl', 'libXp', 'libXmu', 'libXtst', 'openssl', 'libXp', 'libXmu', 'libXtst', 'pam', 'compat-libstdc++-296', 'gtk2', 'gtk2-engines' ]
when 'debian'
  default['was']['prereq_packages'] = %w(libxtst6 libgtk2.0-bin libxft2)
when 'windows'
  default['was']['prereq_packages'] = []
end
