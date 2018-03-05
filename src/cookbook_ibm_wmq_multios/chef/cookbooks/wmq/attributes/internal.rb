###############################################################################################
##
## Cookbook Name:: wmq
## Recipe:: internal
##
## Copyright IBM Corp. 2016, 2017
################################################################################################

############################################################################################################
# STANDARD Environemnt Settings
############################################################################################################

# <> The URL to the root directory of the HTTP server hosting the software installation packages i.e. http://<hostname>:<port>
default['ibm']['sw_repo'] = ''

default['ibm']['sw_repo_user'] = ''

default['ibm']['sw_repo_password'] = ''

# <> If a secure Software repo is used but it uses a self signed SSL certificate this should be set to "true"
default['ibm']['sw_repo_self_signed_cert'] = "true"

# <> If a secure Software repo is used and basic authentication is required you should set this to "true"
default['ibm']['sw_repo_auth'] = "true"

default['wqm']['skip_indexes'] = "false"

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


default['wmq']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['wmq']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

case node['platform_family']
when 'rhel', 'debian'
  # <> An absolute path to a directory that will be used to hold any temporary files created as part of the automation
  default['ibm']['temp_dir'] = '/tmp/ibm_cloud'
  # <> An absolute path to a directory that will be used to hold any persistent files created as part of the automation
  default['ibm']['log_dir'] = '/var/log/ibm_cloud'
  # <> A temporary directory used for the extraction of installation files
  default['ibm']['expand_area'] = node['ibm']['temp_dir'] + '/expand_area'
  # <> The directory where the installation logs and artifacts are stored
  default['ibm']['evidence_path'] = "#{node['ibm']['log_dir']}/evidence"
  # <> The name of the artifacts archive
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}/--cookbook_name--_#{node['hostname']}.tar"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "--cookbook_name--_#{node['hostname']}.log"
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
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}\\--cookbook_name--_#{node['hostname']}.zip"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "--cookbook_name--_#{node['hostname']}.log"
end

# <> An absolute path to a directory that will be used to store the evidence file created as part of the automation
force_default['wmq']['expand_area'] = node['ibm']['expand_area'] + '/wmq'

# <> Cookbook log directory
force_default['wmq']['log_dir'] = node['wmq']['log_dir'] + '/' + 'wmq'

# <> repo path for IBM WebSphere MQ base package
force_default['wmq']['sw_repo_path'] = '/wmq/v' + node['wmq']['version']

# <> Supported Versions of MQSeries to install
force_default['wmq']['versions'] = "9.0, 8.0"

#-------------------------------------------------------------------------------
# Supported OS Versions
#-------------------------------------------------------------------------------

default['wmq']['OS_supported'] = {
  'windows'  => "true",
  'rhel'    => "true",
  'centos'  => "false",
  'debian'  => "true",
  'sles'   =>  "false"
}

#-------------------------------------------------------------------------------
# Installation Files
#-------------------------------------------------------------------------------
# V8.0 http://www-01.ibm.com/support/docview.wss?uid=swg24040028
# V9.0

# <> WebSphere MQ Server Base Files
default['wmq']['archive_names'] = []
case node['wmq']['version']
when '8.0'
  case node['platform_family']
  when 'rhel'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "8.0.0-WS-MQ-LinuxX64-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = %w(ksh binutils compat-libstdc++-33 compat-libstdc++-33.i686 pam.i686 gcc gcc-c++ gcc glibc libgcc openssl gtk2 libstdc++.i686 libstdc++  redhat-lsb-core)
    when 'powerpc'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_FOR_AIX_V8.0_EIMAGE.tar.tgz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "8.0.0-WS-MQ-LinuxPPC64-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'glibc', 'libgcc', 'openssl', 'gtk2', 'libstdc++.ppc libstdc++.ppc64']
    when 's390x'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_SYS_Z_64B_V8.0_IMG.tar.gz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "8.0.0-WS-MQ-LinuxS390X-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'glibc', 'libgcc', 'openssl', 'gtk2', 'libstdc++.s390x', 'libstdc++.s390']
    end
  when 'debian'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "8.0.0-WS-MQ-LinuxX64-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'gcc-multilib', 'openssl', 'libgtk2.0-0', 'rpm', 'lsb-core']
    when 'powerpc'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_FOR_AIX_V8.0_EIMAGE.tar.tgz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "8.0.0-WS-MQ-LinuxPPC64-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'gcc-multilib', 'openssl', 'libgtk2.0-0', 'rpm']
    when 's390x'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_SYS_Z_64B_V8.0_IMG.tar.gz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "8.0.0-WS-MQ-LinuxS390X-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'gcc-multilib', 'openssl', 'libgtk2.0-0', 'rpm']
    end
  end
when '9.0'
  case node['platform_family']
  when 'rhel'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'IBM_MQ_9.0.0.0_LINUX_X86-64.tar.gz', # ~ip_checker
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "9.0.0-IBM-MQ-LinuxX64-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = %w(ksh binutils compat-libstdc++-33 compat-libstdc++-33.i686 pam.i686 gcc gcc-c++ gcc glibc libgcc openssl gtk2 libstdc++.i686 libstdc++ redhat-lsb-core)
    when 'powerpc'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_FOR_AIX_V9.0.0_EIMAGE.tar.tgz',
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a' }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'glibc', 'libgcc', 'openssl', 'gtk2', 'libstdc++.ppc64', 'libstdc++.ppc', 'redhat-lsb-core']
    when 's390x'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_SYS_Z_64B_V9.0.0_IMG.tar.gz',
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a' }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'glibc', 'libgcc', 'openssl', 'gtk2', 'libstdc++.s390x', 'libstdc++.s390', 'redhat-lsb-core']
    end
  when 'debian'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'IBM_MQ_9.0.0.0_LINUX_X86-64.tar.gz', # ~ip_checker
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a' }
      }
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => "9.0.0-IBM-MQ-LinuxX64-FP000#{node['wmq']['fixpack']}.tar.gz" }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'gcc-multilib', 'openssl', 'libgtk2.0-0', 'rpm', 'lsb-core']
    when 'powerpc'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_FOR_AIX_V9.0.0_EIMAGE.tar.tgz',
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a' }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'gcc-multilib', 'openssl', 'libgtk2.0-0', 'rpm', 'lsb-core']
    when 's390x'
      force_default['wmq']['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_SYS_Z_64B_V9.0.0_IMG.tar.gz',
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a' }
      }
      force_default['wmq']['prereqs'] = ['ksh', 'binutils', 'gcc', 'gcc-multilib', 'openssl', 'libgtk2.0-0', 'rpm', 'lsb-core']
    end
  end
end
#-------------------------------------------------------------------------------
# Installation Packages
#-------------------------------------------------------------------------------

# <> WebSphere MQ Server fixpack series
case node['wmq']['version']
when '8.0'
  force_default['wmq']['fixpack_series'] = "U800#{node['wmq']['fixpack']}-8.0.0-#{node['wmq']['fixpack']}"
when '9.0'
  force_default['wmq']['fixpack_series'] = "U900#{node['wmq']['fixpack']}-9.0.0-#{node['wmq']['fixpack']}"
end

case node['platform_family']
when 'rhel', 'debian'
  case node['kernel']['machine']
  when 'x86_64'
    # <> WebSphere MQ Server version packages inside archive
    force_default['wmq']['packages'] = "MQSeriesRuntime-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesServer-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesSDK-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesSamples-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesJava-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesMan-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesJRE-#{node['wmq']['version']}.0-0.x86_64.rpm  MQSeriesClient-#{node['wmq']['version']}.0-0.x86_64.rpm"

    # <> WebSphere MQ Server version gsk inside archive
    force_default['wmq']['gskpackages'] = "MQSeriesGSKit-#{node['wmq']['version']}.0-0.x86_64.rpm"

    # <> WebSphere MQ Server version uninstall packages inside archive
    force_default['wmq']['uninstall'] = 'MQSeriesGSKit MQSeriesRuntime MQSeriesServer MQSeriesJRE MQSeriesJava MQSeriesClient MQSeriesSDK MQSeriesSamples MQSeriesMan'

    # <> WebSphere MQ Server fixpack_version packages inside archive
    force_default['wmq']['fixpackpackages'] = "MQSeriesRuntime-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesServer-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesSDK-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesSamples-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesJava-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesMan-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesJRE-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesClient-#{node['wmq']['fixpack_series']}.x86_64.rpm"

    # <> WebSphere MQ Server fixpack_version gsk inside archive
    force_default['wmq']['fixpackgsk'] = "MQSeriesGSKit-#{node['wmq']['fixpack_series']}.x86_64.rpm"

    # <> WebSphere MQ Server fixpack_version packages uninstall inside archive
    force_default['wmq']['uninstallfixpack'] = "MQSeriesGSKit-#{node['wmq']['fixpack_series']} MQSeriesRuntime-#{node['wmq']['fixpack_series']} MQSeriesServer-#{node['wmq']['fixpack_series']} MQSeriesJRE-#{node['wmq']['fixpack_series']} MQSeriesJava-#{node['wmq']['fixpack_series']} MQSeriesClient-#{node['wmq']['fixpack_series']} MQSeriesSDK-#{node['wmq']['fixpack_series']} MQSeriesSamples-#{node['wmq']['fixpack_series']} MQSeriesMan-#{node['wmq']['fixpack_series']}"

    # <> WebSphere MQ Advanced Packages
    force_default['wmq']['advancedpackages'] = "MQSeriesFTBase-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesFTAgent-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesFTService-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesFTLogger-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesFTTools-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesAMS-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesAMS-#{node['wmq']['version']}.0-0.x86_64.rpm MQSeriesXRService-#{node['wmq']['version']}.0-0.x86_64.rpm"

    # <> WebSphere MQ Advanced Fixpack
    force_default['wmq']['advancedfixpack'] = "MQSeriesFTBase-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesFTAgent-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesFTService-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesFTLogger-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesFTTools-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesAMS-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesAMS-#{node['wmq']['fixpack_series']}.x86_64.rpm MQSeriesXRService-#{node['wmq']['fixpack_series']}.x86_64.rpm"

  when 's390x'
    # <> WebSphere MQ Server version packages inside archive
    force_default['wmq']['packages'] = "MQSeriesRuntime-#{node['wmq']['version']}.s390x.rpm MQSeriesServer-#{node['wmq']['version']}.s390x.rpm MQSeriesJRE-#{node['wmq']['version']}.s390x.rpm MQSeriesJava-#{node['wmq']['version']}.s390x.rpm MQSeriesClient-#{node['wmq']['version']}.s390x.rpm MQSeriesSDK-#{node['wmq']['version']}.s390x.rpm MQSeriesSamples-#{node['wmq']['version']}.s390x.rpm MQSeriesMan-#{node['wmq']['version']}.s390x.rpm"

    # <> WebSphere MQ Server version gsk inside archive
    force_default['wmq']['gskpackages'] = "MQSeriesGSKit-#{node['wmq']['version']}.s390x.rpm"

    # <> WebSphere MQ Server version uninstall packages inside archive
    force_default['wmq']['uninstall'] = 'MQSeriesGSKit MQSeriesRuntime MQSeriesServer MQSeriesJRE MQSeriesJava MQSeriesClient MQSeriesSDK MQSeriesSamples MQSeriesMan'

    # <> WebSphere MQ Server fixpack_version packages inside archive
    force_default['wmq']['fixpackpackages'] = "MQSeriesGSKit-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesJRE-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesServer-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesJava-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesClient-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesSDK-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesRuntime-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesSamples-#{node['wmq']['fixpack_series']}.s390x.rpm MQSeriesMan-#{node['wmq']['fixpack_series']}.s390x.rpm"

    # <> WebSphere MQ Server fixpack_version packages uninstall inside archive
    force_default['wmq']['fixpack']['uninstall'] = "MQSeriesGSKit-#{node['wmq']['fixpack_series']} MQSeriesRuntime-#{node['wmq']['fixpack_series']} MQSeriesServer-#{node['wmq']['fixpack_series']} MQSeriesJRE-#{node['wmq']['fixpack_series']} MQSeriesJava-#{node['wmq']['fixpack_series']} MQSeriesClient-#{node['wmq']['fixpack_series']} MQSeriesSDK-#{node['wmq']['fixpack_series']} MQSeriesSamples-#{node['wmq']['fixpack_series']} MQSeriesMan-#{node['wmq']['fixpack_series']}"
  end
when 'aix'
  # <> WebSphere MQ Server version packages inside archive
  force_default['wmq']['packages'] = 'all'
  # <> WebSphere MQ Server version gsk inside archive
  force_default['wmq']['gskpackages'] = 'all'
  # <> WebSphere MQ Server version uninstall packages inside archive
  force_default['wmq']['uninstall'] = 'mqseries'

  # <> WebSphere MQ Server fixpack_version packages inside archive
  force_default['wmq']['fixpackpackages'] = 'all'
  # <> WebSphere MQ Server fixpack_version gsk inside archive
  force_default['fixpackgsk'] = 'all'
  # <> WebSphere MQ Server fixpack_version packages uninstall inside archive
  force_default['wmq']['fixpack']['uninstall'] = 'mqseries'
end
