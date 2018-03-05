# Cookbook Name:: ihs
# Recipe:: attributes/internal
#
# Copyright IBM Corp. 2016, 2017
#
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
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}/ihs-#{node['hostname']}.tar"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "ihs-#{node['hostname']}.log"
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
  default['ibm']['evidence_file'] = "#{node['ibm']['evidence_path']}\\ihs-#{node['hostname']}.zip"
  # <> The name of the log file for gathered evidence
  default['ibm']['evidence_log'] = "ihs-#{node['hostname']}.log"
end

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
# <> Name of the vault containing credentials for GSKIT db and admin server authorization
default['ihs']['vault']['name'] = node['ibm_internal']['vault']['name']

# <> Root ID of the data bag structure
default['ihs']['vault']['root_id'] = 'ihs'

# <> ID under which admin server credentials are stored
default['ihs']['vault']['admin_server']['index'] = 'admin'

# <> Admin server username key
default['ihs']['vault']['admin_server']['username'] = 'name'

# <> Admin server password key
default['ihs']['vault']['admin_server']['secret'] = 'password'

# <> ID under which GSKIT db password is stored
default['ihs']['vault']['gskit']['index'] = 'gskit'

default['ihs']['vault']['gskit']['secret'] = 'password'

# <> ID in the vault that is encrypted. Preferably the root ID, to encrypt everything
default['ihs']['vault']['encrypted_id'] = node['ibm_internal']['vault']['item']

# <> Cookbook expand area
force_default['ihs']['expand_area'] = node['ibm']['expand_area'] + '/' + 'ihs'

# <> Cookbook log directory
force_default['ihs']['log_dir'] = node['ibm']['log_dir'] + '/' + 'ihs'

# <> Prerequisite packages
case node['platform_family']
when 'rhel'
  force_default['ihs']['prereqs'] = ['curl', 'iproute']
when 'debian'
  force_default['ihs']['prereqs'] = ['curl', 'iproute2']
end

# <> IM Offering ID's for webserver and WAS plugin
# force_default['ihs']['offering_id'] = {
#   'IHS' => 'com.ibm.websphere.IHS.v' + node['ihs']['version'].split('.').first(2).join,
#   'PLG' => 'com.ibm.websphere.PLG.v' + node['ihs']['version'].split('.').first(2).join
# }
force_default['ihs']['offering_id']['IHS'] = 'com.ibm.websphere.IHS.v' + node['ihs']['version'].split('.').first(2).join

force_default['ihs']['offering_id']['PLG'] = 'com.ibm.websphere.PLG.v' + node['ihs']['version'].split('.').first(2).join

force_default['ihs']['profile_id']['IHS'] = 'IBM HTTP Server for WebSphere Application Server v' + node['ihs']['version'].split('.').first(2).join

force_default['ihs']['profile_id']['PLG'] = 'IBM Web Server Plug-ins for IBM WebSphere Application Server v' + node['ihs']['version'].split('.').first(2).join

force_default['ihs']['java']['offering_id'] = 'com.ibm.java.jdk.v' + node['ihs']['java']['version'].split('.').first

# <> IHS Features:
# NOTE: IHS v9 dropped the arch features
# NOTE: only arch.32bit OR arch.64bit should be set to true
# NOTE: in IHS version 9 the only available feature is core.feature

case node['ihs']['features']['bitness']
when '32'
  arch_32bit = 'true'
  arch_64bit = 'false'
when '64'
  arch_32bit = 'false'
  arch_64bit = 'true'
end

# Bitness has been obsoleted in v9
default['ihs']['ihs_features'] = {
  'core.feature' => { 'install' => 'true', 'version_support' => ['8', '9'] },
  'arch.32bit' => { 'install' => arch_32bit, 'version_support' => ['8'] },
  'arch.64bit' => { 'install' => arch_64bit, 'version_support' => ['8'] }
}

# <> WAS Plugin features to install
# NOTE: only com.ibm.jre.6_arch_32bit OR com.ibm.jre.6_arch_64bit should be set to true
# NOTE: in IHS version 9 the only available feature is core.feature
# Otherwise keep the same rules and values from IHS features
force_default['ihs']['plugin']['features'] = {
  'core.feature' => node['ihs']['ihs_features']['core.feature'],
  'com.ibm.jre.6_32bit' => node['ihs']['ihs_features']['arch.32bit'],
  'com.ibm.jre.6_64bit' => node['ihs']['ihs_features']['arch.64bit']
}

# Starting with IHS v9, java must be installed explicitely
force_override['ihs']['java']['install'] = if node['ihs']['version'].split('.').first.to_i > 8
                                             'true'
                                           else
                                             'false'
                                           end

