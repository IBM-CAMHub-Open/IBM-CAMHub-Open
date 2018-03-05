# Cookbook Name::was
# Recipe::attributes
#
#         Copyright IBM Corp. 2016, 2017
#
# <> The attributes file will define all attributes that may be over-written by CHEF Attribute Precendence
#

######################################################################################################
# INSTALLATION Options
######################################################################################################

#<> WebSphere Installation Version. options to user would be latest ones starts with "8.5.5" or "9.0.0"
#default['was']['version'] = "8.5.5.12"
# <md>attribute 'was/version',
# <md>          :displayname =>  'WebSphere Application Server Version',
# <md>          :description => 'The release and fixpack level of WebSphere Application Server to be installed. Example formats are 8.5.5.12 or 9.0.0.4',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9.0.0.4',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['was']['version'] = "9.0.0.2" # ~ip_checker

#<> Rolenames required for chef-search
# <md>attribute 'was/dmgr_role_name',
# <md>          :displayname =>  'dmgr_role_name',
# <md>          :description => 'Used for Chef search',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['was']['dmgr_role_name'] = "was_create_dmgr"

# <md>attribute 'was/ihs_role_names',
# <md>          :displayname =>  'ihs_role_names',
# <md>          :description => 'Used for Chef search',
# <md>          :type => 'array',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['was']['ihs_role_names'] = ["ihs-wasmode-admin", "ihs-wasmode-nonadmin"]

#<> WAS edition to install and configure
#<> NOTE: only one value can be set to true
#<> Rolenames required for chef-search
# <md>attribute 'was/edition/base',
# <md>          :displayname =>  'WebSphere Base Edition',
# <md>          :description => 'WebSphere Application Server will be installed and configured',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

#<> Rolenames required for chef-search
# <md>attribute 'was/edition/nd',
# <md>          :displayname =>  'WebSphere ND Edition',
# <md>          :description => 'WebSphere Application Server Network Deployment will be installed and configured',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['was']['edition'] = {
  'base'  => "false",
  'nd'    => "true"
}

#<> WebSphere Installation Options
#<> NOTE: only com.ibm.sdk.6_32bit OR com.ibm.sdk.6_64bit should be set to true

# <md>attribute 'was/java_version',
# <md>          :displayname =>  'WebSphere Java SDK version',
# <md>          :description => 'The Java SDK version that should be installed with the WebSphere Application Server. Example format is 8.0.4.70',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8.0.4.70',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/java_features/websphere_java_v8/enable',
# <md>          :displayname =>  'WebSphere install Java 8 SDK',
# <md>          :description => 'Installation Manager response file option to install Java 8 SDK. Valid only for WebSphere V9',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/java_features/websphere_java_v8/offering_id',
# <md>          :displayname =>  'WebSphere Java 8 SDK installation manager offering id',
# <md>          :description => 'Java SDK installation manager offering ID value',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.java.jdk.v8',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/features/core.feature',
# <md>          :displayname =>  'WebSphere install runtime',
# <md>          :description => 'Indicates that the application server feature (core.feature) should be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/features/ejbdeploy',
# <md>          :displayname =>  'WebSphere install optional EJBDeploy feature',
# <md>          :description => 'Indicates whether the optional feature EJBDeploy tool for pre-EJB 3.0 modules should be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/features/thinclient',
# <md>          :displayname =>  'WebSphere install optional stand-alone thin clients and resource adapters',
# <md>          :description => 'Indicates whether the optional IBM stand-alone thin clients and resource adapters should be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/features/embeddablecontainer',
# <md>          :displayname =>  'WebSphere install optional Embeddable EJB Container feature',
# <md>          :description => 'Indicates whether the embeddable EJB container should be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/features/samples',
# <md>          :displayname =>  'WebSphere install optional WebSphere Sample applications',
# <md>          :description => 'Indicates whether the PlantsByWebSphere sample application should be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/features/liberty',
# <md>          :displayname =>  'WebSphere features liberty',
# <md>          :description => 'Indicates whether the WebSphere Liberty Application Server should be installed. Used for WebSphere installations that bundled Liberty as an install option',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

case node['was']['version']
when /^8.5.5/ # ~ip_checker
  #<> IBM Java 7 Version valid_options 7.0.9.30, 7.1.40.5
  default['was']['java_version'] = "7.1.40.5" # ~ip_checker

  #<> WebSphere Installation Options
  default['was']['java_features'] = {
    'websphere_java_v70'  => { 'enable' => "false",
                               'offering_id' => "com.ibm.websphere.IBMJAVA.v70" },
    'websphere_java_v71'  => { 'enable' => "true",
                               'offering_id' => "com.ibm.websphere.IBMJAVA.v71" }
  }

  default['was']['features'] = {
    'core.feature'        => "true",
    'ejbdeploy'           => "true",
    'thinclient'          => "true",
    'embeddablecontainer' => "true",
    'samples'             => "false",
    'liberty'             => "false",
    'com.ibm.sdk.6_32bit' => "false",
    'com.ibm.sdk.6_64bit' => "true"
  }
when /^9.0.0/ # ~ip_checker

  default['was']['java_version'] = "8.0.4.10" # ~ip_checker

  #<> WebSphere Installation Options
  default['was']['java_features'] = {
    'websphere_java_v8'  => { 'enable' => "true",
                              'offering_id' => "com.ibm.java.jdk.v8" }
  }

  default['was']['features'] = {
    'core.feature'        => "true",
    'ejbdeploy'           => "true",
    'thinclient'          => "true",
    'embeddablecontainer' => "true",
    'samples'             => "false",
    'liberty'             => "false"
  }
end


############################################################################################################
# INSTALLATION Settings
############################################################################################################

#<> WAS installation directory
# <md>attribute 'was/install_dir',
# <md>          :displayname =>  'WebSphere product installation directory',
# <md>          :description => 'The installation root directory for the WebSphere Application Server product binaries',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/WebSphere/AppServer',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was']['install_dir'] = "/opt/IBM/WebSphere/AppServer"

#<> WAS profile directory
# <md>attribute 'was/profile_dir',
# <md>          :displayname =>  'WebSphere profile location',
# <md>          :description => 'The directory path that contains WebSphere Application Server profiles',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/WebSphere/AppServer/profiles',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was']['profile_dir'] = "#{node['was']['install_dir']}/profiles"

#<> Permissions to be set for directories
# <md>attribute 'was/os_perms',
# <md>          :displayname =>  'WebSphere operating system permissions',
# <md>          :description => 'File permissions for the WebSphere installation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '750',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['was']['os_perms'] = "750"


############################################################################################################
# OS Users
############################################################################################################

#<> WebSphere Operating System Users To Create
# <md>attribute 'was/os_users/was/name',
# <md>          :displayname =>  'WebSphere installation userid',
# <md>          :description => 'Operating system userid that will be used to install the product. Userid will be created if it does not exist',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'wasadmin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/os_users/was/gid',
# <md>          :displayname =>  'WebSphere user group name',
# <md>          :description => 'Operating system group name that will be assigned to the product installation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'wasgrp',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/os_users/was/comment',
# <md>          :displayname =>  'WebSphere user comment for user',
# <md>          :description => 'Comment that will be added when creating the userid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'WAS administrative user',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/os_users/was/home',
# <md>          :displayname =>  'WebSphere installation userid home directory',
# <md>          :description => 'Home directory location for operating system user that is used for product installation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/wasadmin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/os_users/was/shell',
# <md>          :displayname =>  'WebSphere userid default shell',
# <md>          :description => 'Default shell for the operating system userid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/bin/bash',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/os_users/was/ldap_user',
# <md>          :displayname =>  'WebSphere to use LDAP for authentication',
# <md>          :description => 'A flag which indicates whether to create the WebSphere user locally, or utilize an LDAP based user',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['was']['os_users'] = {
  'was'  =>  {
    'name' =>     'wasadmin',
    'gid' =>      'wasgrp',
    'comment' =>  'WAS administrative user',
    'home' =>     "/home/wasadmin",
    'shell' =>    '/bin/bash',
    'ldap_user' => 'false'
  }
}

############################################################################################################
# WebSphere Console Security
############################################################################################################

#<> WAS admininstrative user
# <md>attribute 'was/security/admin_user',
# <md>          :displayname =>  'WebSphere administrative user name',
# <md>          :description => 'The username for securing the WebSphere adminstrative console',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'wasadmin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was']['security']['admin_user'] = "wasadmin"

# <md>attribute 'was/security/admin_user_pwd',
# <md>          :displayname =>  'WebSphere administrative user password',
# <md>          :description => 'The password for the WebSphere administrative account',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'
default['was']['security']['admin_user_pwd'] = ""



############################################################################################################
# General Profile Settings
############################################################################################################

#<> Profile Configuration Settings
#<> os_service: if true, OS service will be configured
#<> soap_client_props:if true, soap.client.properties file will be setup
#<> use_ports_file:if true, ports file will be used for profiles
#<> enable_admin_security:if true, admin security will be enabled for profiles
#<> use_default_certs:if true, default certificates will be used for profiles. If false, certificate info below will be used.

# <md>attribute 'was/config/os_service',
# <md>          :displayname =>  'WebSphere enable automatic start of servers',
# <md>          :description => 'Setup appropriate operating system job to start WebSphere at system startup',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/config/enable_admin_security',
# <md>          :displayname =>  'WebSphere enable administrative security',
# <md>          :description => 'Enable WebSphere administrative console security',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/config/use_default_certs',
# <md>          :displayname =>  'WebSphere create a new default personal certificate',
# <md>          :description => 'Use WebSphere default certificates when creating profiles',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :choice => ['true', 'false'],
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'
default['was']['config'] = {
  'os_service' => "true",
  'enable_admin_security' => "true",
  'use_default_certs' => "true"
}

# <> Hostnames can be entered if bringing from outside of stack
# <md>attribute 'was/dmgr_host_name',
# <md>          :displayname =>  'WebSphere Deployment Manager hostname',
# <md>          :description => 'The fully qualified domain name of the deployment manager to federate this node to',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was']['dmgr_host_name'] = ''

# <md>attribute 'was/ihs_host_name',
# <md>          :displayname =>  'IBM HTTP hostname',
# <md>          :description => 'Fully qualified domain name of the IBM HTTP server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was']['ihs_host_name'] = ''
############################################################################################################
# Deployment Manage Profile
############################################################################################################

#<> Profile settings - Deployment Manager
#<> NOTE: personalcertdn - needs to contain "\\\\" before ","
#<>   profile: Name of the profile
#<>   cell: Name of the cell
#<>   node: Node name for the DMGR, supports TAGS
#<>   host: Host name of the DMGR, supports TAGS
#<>   ports: Default port file to use, default is dmgr.ports
#<>   personalcertdn: Personal certificate for the DMGR
#<>   personalcertvalidityperiod: validity period for the DMGR Certificate
#<>   signingcertdn: dn of the signing certificate
#<>   signingcertvalidityperiod: Validity period of the signing certificate
#<>   keystorepassword: Password of the keystore, use 'databag' if the password is to reside in a databag

# Singular Instance per Deployment

# <md>attribute 'was/profiles/dmgr/profile',
# <md>          :displayname =>  'WebSphere Deployment Manager profile name',
# <md>          :description => 'WebSphere Deployment Manager profile name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Dmgr01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/cell',
# <md>          :displayname =>  'WebSphere cell name',
# <md>          :description => 'A cell name is a logical name for the group of nodes administered by the deployment manager cell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'cell01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/node',
# <md>          :displayname =>  'WebSphere node name',
# <md>          :description => 'A node name is for administration by the deployment manager.  The name must be unique within the cell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}CellManager01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/host',
# <md>          :displayname =>  'WebSphere Deployment Manager host name',
# <md>          :description => 'A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/WC_adminhost',
# <md>          :displayname =>  'WebSphere Administrative Console Port',
# <md>          :description => 'Deployment Manager Administrative Console Port (WC_adminhost)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9060',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/WC_adminhost_secure',
# <md>          :displayname =>  'WebSphere Administrative Console Secure Port',
# <md>          :description => 'Deployment Manager Adminsitrative Secure Console Port (WC_adminhost_secure)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9043',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/BOOTSTRAP_ADDRESS',
# <md>          :displayname =>  'WebSphere Bootstrap Port',
# <md>          :description => 'Deployment Manager Bootstrap Port value (BOOTSTRAP_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9809',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/SOAP_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere SOAP Connector Port',
# <md>          :description => 'Deployment Manager SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8879',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/IPC_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere IPC Connector Port value',
# <md>          :description => 'Deployment Manager IPC Connector Port value (IPC_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9632',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere SAS_SSL_SERVERAUTH_LISTENER_ADDRESS Port',
# <md>          :description => 'Deployment Manager SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9401',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere CSIV2 Server Authentication Listener Port',
# <md>          :description => 'Deployment Manager CSIV2 Server Authentication Listener Port (CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS) value',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9403',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere CSIV2 Client Authentication Listener Port',
# <md>          :description => 'Deployment Manager CSIV2 Client Authentication Listener Port (CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9402',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/ORB_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere ORB Listener Port',
# <md>          :description => 'Deployment Manager ORB Listener Port (ORB_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9100',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/CELL_DISCOVERY_ADDRESS',
# <md>          :displayname =>  'WebSphere Cell Discovery Address',
# <md>          :description => 'Deployment Manager Cell Discovery Address port value (CELL_DISCOVERY_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7277',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/DCS_UNICAST_ADDRESS',
# <md>          :displayname =>  'WebSphere High Availability Manager Communication Port',
# <md>          :description => 'Deployment Manager High Availability Manager Communication Port (DCS_UNICAST_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9352',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/DataPowerMgr_inbound_secure',
# <md>          :displayname =>  'WebSphere DataPower Appliance Manager Secure Inbound Port',
# <md>          :description => 'Deployment Manager DataPower Appliance Manager Secure Inbound Port (DataPowerMgr_inbound_secure)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5555',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/XDAGENT_PORT',
# <md>          :displayname =>  'WebSphere Middleware Agent RPC Port',
# <md>          :description => 'Deployment Manager Middleware Agent RPC Port (XDAGENT_PORT)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7060',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/OVERLAY_UDP_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Administration Overlay UDP Port',
# <md>          :description => 'Deployment Manager Administration Overlay UDP Port (OVERLAY_UDP_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11005',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/OVERLAY_TCP_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Administration Overlay TCP Port',
# <md>          :description => 'Deployment Manager Administration Overlay TCP Port (OVERLAY_TCP_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11006',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/ports/STATUS_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Status Update Listener Port',
# <md>          :description => 'Deployment Manager Status Update Listener Port (STATUS_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9420',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/personalcertdn',
# <md>          :displayname =>  'WebSphere personal certificate Distingushed name',
# <md>          :description => 'Specifies the distinguished name of the personal certificate that you are creating when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/personalcertvalidityperiod',
# <md>          :displayname =>  'WebSphere personal certificate expiration period in years',
# <md>          :description => 'An optional parameter that specifies the amount of time in years that the default personal certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '3',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/signingcertdn',
# <md>          :displayname =>  'WebSphere root certificate distinguished name',
# <md>          :description => 'Specifies the distinguished name of the root signing certificate that you create when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/signingcertvalidityperiod',
# <md>          :displayname =>  'WebSphere root signing certificate expiration period in years',
# <md>          :description => 'An optional parameter that specifies the amount of time in years that the root signing certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '15',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/dmgr/keystorepassword',
# <md>          :displayname =>  'WebSphere default keystore password',
# <md>          :description => 'Specifies the password to use on keystore created during profile creation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

default['was']['profiles']['dmgr'] = {
  'profile' => 'Dmgr01',
  'cell' => 'cell01',
  'node' => '{SHORTHOSTNAME}CellManager01',
  'host' => node['was']['dmgr_host_name'],
  'ports' => {
    'WC_adminhost' => '9060',
    'WC_adminhost_secure' => '9043',
    'BOOTSTRAP_ADDRESS' => '9809',
    'SOAP_CONNECTOR_ADDRESS' => '8879',
    'IPC_CONNECTOR_ADDRESS' => '9632',
    'SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9401',
    'CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9403',
    'CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' => '9402',
    'ORB_LISTENER_ADDRESS' => '9100',
    'CELL_DISCOVERY_ADDRESS' => '7277',
    'DCS_UNICAST_ADDRESS' => '9352',
    'DataPowerMgr_inbound_secure' => '5555',
    'XDAGENT_PORT' => '7060',
    'OVERLAY_UDP_LISTENER_ADDRESS' => '11005',
    'OVERLAY_TCP_LISTENER_ADDRESS' => '11006',
    'STATUS_LISTENER_ADDRESS' => '9420'
  }, #'dmgr.ports',
  'personalcertdn' => "cn=" + "{FULLHOSTNAME}" + "\\\\,ou=dmgr\\\\,o=IBM\\\\,c=US",
  'personalcertvalidityperiod' => '3',
  'signingcertdn' => 'cn=cell\\\\,ou=dmgr\\\\,o=IBM\\\\,c=US',
  'signingcertvalidityperiod' => '15',
  'keystorepassword' => ''
}

# Singular Instance per Node

# <md>attribute 'was/profiles/node_profile/profile',
# <md>          :displayname =>  'WebSphere Custom Node profile name',
# <md>          :description => 'Profile name for a custom profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'Custom01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/dmgr_host',
# <md>          :displayname =>  'WebSphere Deployment Manager host name or IP address',
# <md>          :description => 'Speicfy the host name or IP address for an existing deployment manager',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/dmgr_port',
# <md>          :displayname =>  'WebSphere Deployment Manager SOAP Port',
# <md>          :description => 'Deployment Manager SOAP Port that is used when federating the custom profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/node',
# <md>          :displayname =>  'WebSphere custom profile node name',
# <md>          :description => 'Unique node name for this federated node.  Must be unique within the cell',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}Node01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/host',
# <md>          :displayname =>  'WebSphere custom profile host name',
# <md>          :description => 'A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_),
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/WC_adminhost',
# <md>          :displayname =>  'WebSphere Administrative Console Port',
# <md>          :description => 'Administrative Console Port (WC_adminhost)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9060',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/BOOTSTRAP_ADDRESS',
# <md>          :displayname =>  'WebSphere Bootstrap Port',
# <md>          :description => 'Server bootstrap (BOOTSTRAP_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '2810',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/SOAP_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere SOAP Connector Port',
# <md>          :description => 'SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8878',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/IPC_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere IPC Connector Port',
# <md>          :description => 'IPC Connector Port value (IPC_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9626',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere SAS_SSL_SERVERAUTH_LISTENER_ADDRESS Port',
# <md>          :description => 'was node_profile profiles ports SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9901',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere CSIV2 Server Authentication Listener Port',
# <md>          :description => 'CSIV2 Server Authentication Listener Port (CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9201',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere CSIV2 Client Authentication Listener Port',
# <md>          :description => 'CSIV2 Client Authentication Listener Port (CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9202',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/ORB_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere ORB Listener Port',
# <md>          :description => 'ORB Listener Port (ORB_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9101',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/NODE_DISCOVERY_ADDRESS',
# <md>          :displayname =>  'WebSphere Node Discovery Address',
# <md>          :description => 'Node Discovery Address (NODE_DISCOVERY_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7272',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'


# <md>attribute 'was/profiles/node_profile/ports/NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS',
# <md>          :displayname =>  'WebSphere Node IPV6 Discovery Address Port',
# <md>          :description => 'Node IPV6 Discovery Address (NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5001',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/NODE_MULTICAST_DISCOVERY_ADDRESS',
# <md>          :displayname =>  'WebSphere was node_profile profiles ports NODE_MULTICAST_DISCOVERY_ADDRESS',
# <md>          :description => 'was node_profile profiles ports NODE_MULTICAST_DISCOVERY_ADDRESS',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5000',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/DCS_UNICAST_ADDRESS',
# <md>          :displayname =>  'WebSphere High Availability Manager Communication Port (DCS)',
# <md>          :description => 'High Availability Manager Communication Port (DCS_UNICAST_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9354',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'


# <md>attribute 'was/profiles/node_profile/ports/XDAGENT_PORT',
# <md>          :displayname =>  'WebSphere Node Middleware Agent RPC Port',
# <md>          :description => 'Node Middleware Agent RPC Port (XDAGENT_PORT)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7061',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/OVERLAY_UDP_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Node Administration Overlay UDP Port',
# <md>          :description => 'Node Administration Overlay UDP Port (OVERLAY_UDP_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11001',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/OVERLAY_TCP_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Node Administration Overlay TCP Port',
# <md>          :description => 'Node Administration Overlay TCP Port (OVERLAY_TCP_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11002',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/ports/STATUS_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Status Update Listener Port',
# <md>          :description => 'Status Update Listener Port (STATUS_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9420',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/personalcertdn',
# <md>          :displayname =>  'WebSphere personal certificate distingushed name',
# <md>          :description => 'Specifies the distinguished name of the personal certificate that you are creating when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/personalcertvalidityperiod',
# <md>          :displayname =>  'WebSphere personal certificate expiration period in years',
# <md>          :description =>  'An optional parameter that specifies the amount of time in years that the default personal certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '3',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/signingcertdn',
# <md>          :displayname =>  'WebSphere root certificate distinguished name',
# <md>          :description => 'Specifies the distinguished name of the root signing certificate that you create when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/signingcertvalidityperiod',
# <md>          :displayname =>  'WebSphere root signing certificate expiration period in years',
# <md>          :description =>  'An optional parameter that specifies the amount of time in years that the root signing certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '15',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/node_profile/keystorepassword',
# <md>          :displayname =>  'WebSphere default keystore password',
# <md>          :description => 'Specifies the password to use on all keystore files created during profile creation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

default['was']['profiles']['node_profile'] = {
  'profile' => 'AppSrv01',
  'dmgr_host' => node['was']['dmgr_host_name'],
  'dmgr_port' => '',
  'node' => '{SHORTHOSTNAME}Node01',
  'host' => '{FULLHOSTNAME}',
  'ports' => {
    'BOOTSTRAP_ADDRESS' => '2810',
    'SOAP_CONNECTOR_ADDRESS' => '8878',
    'IPC_CONNECTOR_ADDRESS' => '9626',
    'SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9901',
    'CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9201',
    'CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' => '9202',
    'ORB_LISTENER_ADDRESS' => '9101',
    'NODE_DISCOVERY_ADDRESS' => '7272',
    'NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS' => '5001',
    'NODE_MULTICAST_DISCOVERY_ADDRESS' => '5000',
    'DCS_UNICAST_ADDRESS' => '9354',
    'XDAGENT_PORT' => '7061',
    'OVERLAY_UDP_LISTENER_ADDRESS' => '11001',
    'OVERLAY_TCP_LISTENER_ADDRESS' => '11002'
  }, #'managed.ports',
  'personalcertdn' => "cn=" + "{FULLHOSTNAME}" + "\\\\,ou=nodeagent\\\\,o=IBM\\\\,c=US",
  'personalcertvalidityperiod' => '3',
  'signingcertdn' => 'cn=cell\\\\,ou=nodeagent\\\\,o=IBM\\\\,c=US',
  'signingcertvalidityperiod' => '15',
  'keystorepassword' => ''
}

# Multiple Instances Per Node
# <md>attribute 'was/profiles/standalone_profiles/standalone1/profile',
# <md>          :displayname =>  'WebSphere Application Server profile name',
# <md>          :description => 'Application server profile name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'AppSrv01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/cell',
# <md>          :displayname =>  'WebSphere Application Server cell name',
# <md>          :description => 'Cell name for the application server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'cell01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/node',
# <md>          :displayname =>  'WebSphere Application Server node name',
# <md>          :description => 'A node name is used for administration',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}Node01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/host',
# <md>          :displayname =>  'WebSphere Application Server host name',
# <md>          :description => 'A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{FULLHOSTNAME}',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/server',
# <md>          :displayname =>  'WebSphere Application Server name',
# <md>          :description => 'Name of the application server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'server1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/WC_adminhost',
# <md>          :displayname =>  'WebSphere Administrative Console Port',
# <md>          :description => 'Server Administrative Console Port (WC_adminhost)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9060',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/WC_adminhost_secure',
# <md>          :displayname =>  'WebSphere Administrative Console Secure Port',
# <md>          :description => 'Server Adminsitrative Secure Console Port (WC_adminhost_secure)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9043',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/WC_defaulthost',
# <md>          :displayname =>  'WebSphere Application Server HTTP Transport Port',
# <md>          :description => 'HTTP Transport Port (WC_defaulthost)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9080',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/WC_defaulthost_secure',
# <md>          :displayname =>  'WebSphere Application Server Secure HTTP Transport Port',
# <md>          :description => 'HTTP Transport Secure Port (WC_defaulthost_secure)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9443',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/BOOTSTRAP_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server bootstrap address',
# <md>          :description =>  'Bootstrap Port value (BOOTSTRAP_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '2809',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SOAP_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server SOAP connector Port',
# <md>          :description => 'SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8880',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/IPC_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server IPC Connector Port',
# <md>          :description => 'IPC Connector Port value (IPC_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9633',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :description => 'Application Server SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9401',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server CSIV2 Server Authentication Listener Port',
# <md>          :description => 'CSIV2 Server Authentication Listener Port (CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9403',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Application server CSIV2 Client Authentication Listener Port',
# <md>          :description => 'CSIV2 Client Authentication Listener Port (CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9402',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/ORB_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server ORB Listener Port',
# <md>          :description => 'ORB Listener Port (ORB_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9100',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/DCS_UNICAST_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server High Availability Manager Communication Port ',
# <md>          :description => 'High Availability Manager Communication Port (DCS_UNICAST_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9353',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SIB_ENDPOINT_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server Service Integration Port',
# <md>          :description =>  'Service Integration Port (SIB_ENDPOINT_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7276',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SIB_ENDPOINT_SECURE_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server Service Integration Secure Port',
# <md>          :description => 'Service Integration Secure Port  (SIB_ENDPOINT_SECURE_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '7286',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SIB_MQ_ENDPOINT_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server MQ Transport Port',
# <md>          :description => 'MQ Transport Port (SIB_MQ_ENDPOINT_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5558',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SIB_MQ_ENDPOINT_SECURE_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server MQ Transport Secure Port',
# <md>          :description => 'MQ Transport Secure Port  (SIB_MQ_ENDPOINT_SECURE_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5578',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SIP_DEFAULTHOST',
# <md>          :displayname =>  'WebSphere Application Server SIP Container Port',
# <md>          :description => 'SIP Container Port (SIP_DEFAULTHOST)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5060',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/SIP_DEFAULTHOST_SECURE',
# <md>          :displayname =>  'WebSphere Application Server SIP Container Secure Port',
# <md>          :description => 'SIP Container Secure Port (SIP_DEFAULTHOST_SECURE)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '5061',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/OVERLAY_UDP_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server Administration Overlay UDP Port ',
# <md>          :description => 'Administration Overlay UDP Port (OVERLAY_UDP_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11003',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/ports/OVERLAY_TCP_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Application Server Administration Overlay TCP Port',
# <md>          :description =>  'Administration Overlay TCP Port (OVERLAY_TCP_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '11004',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/personalcertdn',
# <md>          :displayname =>  'WebSphere personal certificate distingushed name',
# <md>          :description =>  'Specifies the distinguished name of the personal certificate that you are creating when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/personalcertvalidityperiod',
# <md>          :displayname =>  'WebSphere personal certificate expiration period in years',
# <md>          :description =>  'An optional parameter that specifies the amount of time in years that the default personal certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '3',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/signingcertdn',
# <md>          :displayname =>  'WebSphere root certificate distinguished name',
# <md>          :description =>  'Specifies the distinguished name of the root signing certificate that you create when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/signingcertvalidityperiod',
# <md>          :displayname =>  'WebSphere root signing certificate expiration period in years',
# <md>          :description =>  'An optional parameter that specifies the amount of time in years that the root signing certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '15',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/standalone_profiles/standalone1/keystorepassword',
# <md>          :displayname =>  'WebSphere default keystore password',
# <md>          :description => 'Specifies the password to use on all keystore files created during profile creation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

default['was']['profiles']['standalone_profiles'] = {
  "standalone1" => {
    'profile' => 'AppSrv01',
    'cell' => 'cell01',
    'node' => '{SHORTHOSTNAME}Node01',
    'host' => '{FULLHOSTNAME}',
    'server' => 'server1',
    'ports' => {
      'WC_adminhost' => '9060',
      'WC_adminhost_secure' => '9043',
      'WC_defaulthost' => '9080',
      'WC_defaulthost_secure' => '9443',
      'BOOTSTRAP_ADDRESS' => '2809',
      'SOAP_CONNECTOR_ADDRESS' => '8880',
      'IPC_CONNECTOR_ADDRESS' => '9633',
      'SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9401',
      'CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9403',
      'CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' => '9402',
      'ORB_LISTENER_ADDRESS' => '9100',
      'DCS_UNICAST_ADDRESS' => '9353',
      'SIB_ENDPOINT_ADDRESS' => '7276',
      'SIB_ENDPOINT_SECURE_ADDRESS' => '7286',
      'SIB_MQ_ENDPOINT_ADDRESS' => '5558',
      'SIB_MQ_ENDPOINT_SECURE_ADDRESS' => '5578',
      'SIP_DEFAULTHOST' => '5060',
      'SIP_DEFAULTHOST_SECURE' => '5061',
      'OVERLAY_UDP_LISTENER_ADDRESS' => '11003',
      'OVERLAY_TCP_LISTENER_ADDRESS' => '11004'
    }, #'managed.ports',
    'personalcertdn' => "cn=" + "{FULLHOSTNAME}" + "\\\\,ou=nodeagent\\\\,o=IBM\\\\,c=US",
    'personalcertvalidityperiod' => '3',
    'signingcertdn' => 'cn=cell\\\\,ou=nodeagent\\\\,o=IBM\\\\,c=US',
    'signingcertvalidityperiod' => '15',
    'keystorepassword' => ''
  }
}

# <md>attribute 'was/profiles/job_manager/profile',
# <md>          :displayname =>  'WebSphere Job Manager profile name ',
# <md>          :description => 'Job Manager profile name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'JobMgr01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/cell',
# <md>          :displayname =>  'WebSphere Job Manager cell name',
# <md>          :description => 'Cell name of the Job manager ',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'cell01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/node',
# <md>          :displayname =>  'WebSphere Job Manager node name',
# <md>          :description => 'Node name is for administration and must be unique',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}JobMgr01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/host',
# <md>          :displayname =>  'WebSphere Job Manager host name',
# <md>          :description => 'A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{FULLHOSTNAME}',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/WC_adminhost',
# <md>          :displayname =>  'WebSphere Administrative Console Port',
# <md>          :description => 'Job Manager Administrative Console Port (WC_adminhost)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9960',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/WC_adminhost_secure',
# <md>          :displayname =>  'WebSphere Administrative Console Secure Port',
# <md>          :description => 'Job Manager Adminsitrative Secure Console Port (WC_adminhost_secure)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9943',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/BOOTSTRAP_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager Bootstrap address',
# <md>          :description => 'Bootstrap Port value (BOOTSTRAP_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9808',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/SOAP_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager SOAP Connector Port',
# <md>          :description => 'SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8876',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/IPC_CONNECTOR_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager IPC Connector Port value',
# <md>          :description => 'IPC Connector Port value (IPC_CONNECTOR_ADDRESS),
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9631',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/SAS_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager SAS SSL ServerAuth Port',
# <md>          :description => 'SAS_ SSL_ SERVERAUTH_ LISTENER_ ADDRESS (Deprecated)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9401',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager CSIV2 Server Authentication Listener Port',
# <md>          :description => 'CSIV2 Server Authentication Listener Port (CSIV2_ SSL_ SERVERAUTH_ LISTENER_ ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9403',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager CSIV2 Client Authentication Listener Port',
# <md>          :description =>  'CSIV2 Client Authentication Listener Port (CSIV2_ SSL_ MUTUALAUTH_ LISTENER_ ADDRESS)	9402',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9402',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/ORB_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager ORB listener Port',
# <md>          :description => 'ORB Listener Port (ORB_LISTENER_ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9099',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/ports/STATUS_LISTENER_ADDRESS',
# <md>          :displayname =>  'WebSphere Job Manager Status update listener Port',
# <md>          :description => 'Status Update Listener Port (STATUS_ LISTENER_ ADDRESS)',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9425',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/personalcertdn',
# <md>          :displayname =>  'WebSphere personal certificate distingushed name',
# <md>          :description => 'Specifies the distinguished name of the personal certificate that you are creating when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/personalcertvalidityperiod',
# <md>          :displayname =>  'WebSphere personal certificate expiration period in years',
# <md>          :description => 'An optional parameter that specifies the amount of time in years that the default personal certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '3',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/signingcertdn',
# <md>          :displayname =>  'WebSphere root certificate distinguished name',
# <md>          :description => 'Specifies the distinguished name of the root signing certificate that you create when you create the profile',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/signingcertvalidityperiod',
# <md>          :displayname =>  'WebSphere root signing certificate expiration period in years',
# <md>          :description => 'An optional parameter that specifies the amount of time in years that the root signing certificate is valid',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '15',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/profiles/job_manager/keystorepassword',
# <md>          :displayname =>  'WebSphere default keystore password',
# <md>          :description =>  'Specifies the password to use on all keystore files created during profile creation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

default['was']['profiles']['job_manager'] = {
  'profile' => 'JobMgr01',
  'cell' => 'cell01',
  'node' => '{SHORTHOSTNAME}JobMgr01',
  'host' => '{FULLHOSTNAME}',
  'ports' => {
    'WC_adminhost' => '9960',
    'WC_adminhost_secure' => '9943',
    'BOOTSTRAP_ADDRESS' => '9808',
    'SOAP_CONNECTOR_ADDRESS' => '8876',
    'IPC_CONNECTOR_ADDRESS' => '9631',
    'SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9401',
    'CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' => '9403',
    'CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' => '9402',
    'ORB_LISTENER_ADDRESS' => '9099',
    'STATUS_LISTENER_ADDRESS' => '9425'
  }, #'job_manager.ports',
  'personalcertdn' => "cn=" + "{FULLHOSTNAME}" + "\\\\,ou=job_manager\\\\,o=IBM\\\\,c=US",
  'personalcertvalidityperiod' => '3',
  'signingcertdn' => 'cn=cell\\\\,ou=job_manager\\\\,o=IBM\\\\,c=US',
  'signingcertvalidityperiod' => '15',
  'keystorepassword' => ''
}

# <md>attribute 'was/unmanaged_node/unmngNode01/node_name',
# <md>          :displayname =>  'WebSphere Unmanaged node name ',
# <md>          :description => 'Node name for the unmanaged node',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}UnmangedNode01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/unmanaged_node/unmngNode01/host_name',
# <md>          :displayname =>  'WebSphere Unmanaged host name',
# <md>          :description => 'The host name or ipaddress of the unmanaged host',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/unmanaged_node/unmngNode01/os',
# <md>          :displayname =>  'WebSphere Unmanaged node operating system type',
# <md>          :description => 'Indicates the operating system type for the unmanaged node',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'linux',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

default['was']['unmanaged_node'] = {
  'unmngNode01'  =>  {
    'node_name'  =>  '{SHORTHOSTNAME}UnmangedNode01',
    'host_name' =>     node['was']['ihs_host_name'],
    'os' =>   "linux"
  }
}

# <md>attribute 'was/webserver/ihs_server/node_name',
# <md>          :displayname =>  'WebSphere was webserver ihs_server node_name',
# <md>          :description => 'Web server node name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}UnmangedNode01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/webserver_name',
# <md>          :displayname =>  'WebSphere was webserver ihs_server webserver_name',
# <md>          :description => 'Web server server name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'webserver1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/webserver_port',
# <md>          :displayname =>  'IBM HTTP Server Listener Port',
# <md>          :description => 'IBM HTTP Server Listener Port that will receive requests on. Use for creating the web server definition',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '80',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/install_dir',
# <md>          :displayname =>  'IBM HTTP Server installation directory',
# <md>          :description => 'Specify the HTTP Server installation directory. Used for creating the web server definition',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/HTTPServer',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/plugin_dir',
# <md>          :displayname =>  'WebSphere plugin installation directory',
# <md>          :description => 'Specify the webserver plugin directory. Used for creating the web server definition',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/IBM/WebSphere/Plugins',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/admin_port',
# <md>          :displayname =>  'IBM HTTP Administrative Server Port',
# <md>          :description => 'IBM HTTP Administrative Server Port.  Used for creating the web server definition',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8008',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/ihs_admin_user',
# <md>          :displayname =>  'IBM HTTP administrative username',
# <md>          :description => 'IBM HTTP administrative username. Used for creating the web server definition',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ihsadmin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/ihs_admin_password',
# <md>          :displayname =>  'IBM HTTP administrative username password',
# <md>          :description => 'IBM HTTP administrative username password. Used for creating the web server definition ',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

# <md>attribute 'was/webserver/ihs_server/webserver_type',
# <md>          :displayname =>  'Type of WebServer',
# <md>          :description => 'HTTP Server vendor.  Example IHS',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'IHS',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/webserver/ihs_server/webapp_mapping',
# <md>          :displayname =>  'Map all applications to the webserver',
# <md>          :description => 'Indicate how the applications should be mapped from the webserver',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ALL',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was']['webserver'] = {
  'ihs_server'  =>  {
    'node_name'  =>  '{SHORTHOSTNAME}UnmangedNode01',
    'webserver_name' => 'webserver1',
    'webserver_port' =>   '80',
    'install_dir' => '/opt/IBM/HTTPServer',
    'plugin_dir' => '/opt/IBM/WebSphere/Plugins',
    'admin_port' => '8008',
    'ihs_admin_user' => 'ihsadmin',
    'ihs_admin_password' => '',
    'webserver_type' => 'IHS',
    'webapp_mapping' => 'ALL'
  }
}

#<> WebSphere configure jvm properties and cluster configurations

# <md>attribute 'was/wsadmin/dmgr/jvmproperty/server_name',
# <md>          :displayname =>  'WebSphere Deployment Manager server name',
# <md>          :description => 'Name of server that will be updated for JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'dmgr',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/dmgr/jvmproperty/node_name',
# <md>          :displayname =>  'WebSphere Deployment Manager node name',
# <md>          :description => 'Node for the deployment manager that will be updated',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '{SHORTHOSTNAME}CellManager01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/dmgr/jvmproperty/profile_path',
# <md>          :displayname =>  'WebSphere Deployment Manager profile path',
# <md>          :description => 'Directoy where the deployment manager profile resides',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/dmgr/jvmproperty/property_value_initial',
# <md>          :displayname =>  'WebSphere Deployment Manager minimum JVM Heap Size',
# <md>          :description => 'Minimum JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '256',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/dmgr/jvmproperty/property_value_maximum',
# <md>          :displayname =>  'WebSphere Deployment Manager maximum JVM Heap Size',
# <md>          :description => 'Maximum JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '512',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/nodeagent/jvmproperty/server_name',
# <md>          :displayname =>  'WebSphere Node Agent server name',
# <md>          :description => 'Name of server that will be updated for JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'nodeagent',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/nodeagent/jvmproperty/node_name',
# <md>          :displayname =>  'WebSphere Node Agent node name',
# <md>          :description => 'Node for the node agent that will be updated',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/nodeagent/jvmproperty/profile_path',
# <md>          :displayname =>  'WebSphere Node Agent profile path',
# <md>          :description => 'Node Agent directory where the profile resides',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/nodeagent/jvmproperty/property_value_initial',
# <md>          :displayname =>  'WebSphere Node Agent minimum JVM Heap Size',
# <md>          :description => 'Minimum JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '256',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/nodeagent/jvmproperty/property_value_maximum',
# <md>          :displayname =>  'WebSphere Node Agent maximum JVM heap size',
# <md>          :description => 'Maximum JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '512',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/standalone/jvmproperty/server_name',
# <md>          :displayname =>  'WebSphere Application Server name',
# <md>          :description => 'Name of server that will be updated for JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/standalone/jvmproperty/node_name',
# <md>          :displayname =>  'WebSphere Application Server node name',
# <md>          :description => 'Node for the application server that will be updated',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/standalone/jvmproperty/profile_path',
# <md>          :displayname =>  'WebSphere Application Server profile path',
# <md>          :description =>  'Directoy where the application server profile resides',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/standalone/jvmproperty/property_value_initial',
# <md>          :displayname =>  'WebSphere Application Server minimum JVM Heap Size',
# <md>          :description => 'Minimum JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '256',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/standalone/jvmproperty/property_value_maximum',
# <md>          :displayname =>  'WebSphere Application Server maximum JVM Heap Size',
# <md>          :description => 'Maximum JVM heap size',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '512',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/clusters/cluster01/cluster_name',
# <md>          :displayname =>  'WebSphere Cluster name',
# <md>          :description => 'Name of the cluster that will be created',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'cluster01',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/clusters/cluster01/session_rep',
# <md>          :displayname =>  'was wsadmin clusters cluster01 session_rep',
# <md>          :description => 'was wsadmin clusters cluster01 session_rep',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true ',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'true',
# <md>          :secret => 'false'

# <md>attribute 'was/wsadmin/clusters/cluster01/cluster_servers/cluster_server01/server_name',
# <md>          :displayname =>  'WebSphere Cluster member name',
# <md>          :description => 'Name of the cluster member that will created on each of the nodes',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'server1',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was']['wsadmin'] = {
  'dmgr'  =>  {
    'jvmproperty' => {
      'server_name' => 'dmgr',
      'node_name' => node['was']['profiles']['dmgr']['node'],
      'profile_path' => "#{node['was']['profile_dir']}/#{node['was']['profiles']['dmgr']['profile']}",
      'property_value_initial' =>   "256",
      'property_value_maximum' =>   "512"
    }
  },
  'nodeagent'  =>  {
    'jvmproperty' => {
      'server_name' => 'nodeagent',
      'node_name' => node['was']['profiles']['node_profile']['node'],
      'profile_path' => "#{node['was']['profile_dir']}/#{node['was']['profiles']['node_profile']['profile']}",
      'property_value_initial' =>   "256",
      'property_value_maximum' =>   "512"
    }
  },
  'standalone'  =>  {
    'jvmproperty' => {
      'server_name' => node['was']['profiles']['standalone_profiles']['standalone1']['server'],
      'node_name' => node['was']['profiles']['standalone_profiles']['standalone1']['node'],
      'profile_path' => "#{node['was']['profile_dir']}/#{node['was']['profiles']['standalone_profiles']['standalone1']['profile']}",
      'property_value_initial' =>   "256",
      'property_value_maximum' =>   "512"
    }
  },
  'clusters'  =>  {
    'cluster01'  =>  {
      'cluster_name' => 'cluster01',
      'session_rep' =>   "True",
      'cluster_servers' => {
        'cluster_server01'  =>  {
          'server_name' =>     "server1"
        }
      }
    }
  }
}
