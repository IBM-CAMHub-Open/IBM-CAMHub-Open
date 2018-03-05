########################################################
#	  Copyright IBM Corp. 2016, 2017
########################################################

####################
# PRODUCT SETTINGS
####################

# <> List of servers to be stopped
# <md> attribute 'was_liberty/stop_servers',
# <md>          :displayname => 'Liberty servers to be stopped',
# <md>          :description => 'List of liberty application servers to be stopped',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['stop_servers'] = ''

# <> List of servers to be started
# <md> attribute 'was_liberty/start_servers',
# <md>          :displayname => 'Liberty servers to be started',
# <md>          :description => 'List of liberty application servers to be stopped',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'


default['was_liberty']['start_servers'] = ''

# <> Flag to remove installation archives after extraction
# <md> attribute 'was_liberty/cleanpackages',
# <md>          :displayname => 'Liberty cleanpackages flag',
# <md>          :description => 'A flag to indicate whether installation packages are to be cleaned after a successful installation',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'


default['was_liberty']['cleanpackages'] = false

# <> Temp directory to be used
# <md> attribute 'was_liberty/tmp',
# <md>          :displayname => 'Liberty temporary directory',
# <md>          :description => 'Temp directory to be used for temporary files, this directory will be emptied after the installation',

# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['tmp'] = node['ibm']['temp_dir'] + "/was_liberty"

# <> Liberty install user
# <md> attribute 'was_liberty/install_user',
# <md>          :displayname => 'Liberty installation userid',
# <md>          :description => 'Operating system userid that will be used to install the product. Userid will be created if it does not exist',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['install_user'] = ''

# <> Liberty install group
# <md> attribute 'was_liberty/install_grp',
# <md>          :displayname => 'Liberty group name',
# <md>          :description => 'Operating system group name that will be assigned to the product installation',

# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['install_grp'] = ''

# <> Liberty install dir
# <md> attribute 'was_liberty/install_dir',
# <md>          :displayname => 'WebSphere product installation directory',
# <md>          :description => 'The installation root directory for the WebSphere Liberty product binaries',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['install_dir'] = ''

# <> Liberty user dir
# <md> attribute 'was_liberty/wlp_user_dir',
# <md>          :displayname => 'Liberty data dir',
# <md>          :description => 'Liberty directory which product configuration will be written',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was_liberty']['wlp_user_dir'] = "#{node['was_liberty']['install_dir']}/usr"


# <> Shared resources location of IBM Installation Manager
# <md> attribute 'was_liberty/im_shared_dir',
# <md>          :displayname => 'Installation Manager shared resources directory',
# <md>          :description => 'The shared resources directory is where installation artifacts are located that can be used by one or more package groups',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['im_shared_dir'] = "/opt/IBM/IMShared"

# <> Create the OS users: 'true' or 'false'
# <md> attribute 'was_liberty/create_os_users',
# <md>          :displayname => 'Create Liberty Installation userid',
# <md>          :description => 'The userid that performs the installation of Liberty should be created',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['create_os_users'] = 'true'

# <> Liberty edition to be installed
# <md> attribute 'was_liberty/edition',
# <md>          :displayname => 'Liberty Edition to be installed',
# <md>          :description => 'Indicates which Liberty offering should be installed. Valid values are: base, core, nd',
# <md>          :type => 'string',
# <md>          :choice => [ 'base',
# <md>                       'core',
# <md>                       'nd' ],
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['edition'] = 'base'
# NOTE: only one value can be set to true
# <> WAS Liberty edition to install and configure
# default['was_liberty']['editions'] = {
#   'base'    => "false",
#   'nd'      => "true",
#   'core'    => "false"
# }
# <> Liberty features to install
# <md> attribute 'was_liberty/features/embeddablecontainer',
# <md>          :displayname => 'Liberty embeddablecontainer flag',
# <md>          :description => 'Flag which determines whether the embeddablecontainer feature will be installed',

# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/features/liberty',
# <md>          :displayname => 'Liberty liberty flag',
# <md>          :description => 'Flag which determines whether the liberty feature will be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
default['was_liberty']['features'] = {
  'embeddablecontainer' => "true",
  'liberty'             => "true"
}

####################
# Liberty Product Installation Settings
####################

# NOTE: only one version should be set to true
# <> Java oferings
# <md> attribute 'was_liberty/sdk/common_ibm_sdk_v8/enable',
# <md>          :displayname => 'Liberty Install JDK 8 SDK',
# <md>          :description => 'Flag to determine whether Java 8 SDK will be installed or not, only one Java flag is applicable',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/common_ibm_sdk_v8/offering_id',
# <md>          :displayname => 'Java 8 SDK installation manager offering id',
# <md>          :description => 'Java SDK installation manager offering ID value, default = com.ibm.java.jdk.v8',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.java.jdk.v8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/common_ibm_sdk_v8/feature',
# <md>          :displayname => 'Java 8 SDK installation manager feature id',
# <md>          :description => 'Installation Manager response file option to install Java 8 SDK, default = com.ibm.sdk.8',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.sdk.8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/common_ibm_sdk_v71/enable',
# <md>          :displayname => 'Liberty Install JDK 7.1 SDK',
# <md>          :description => 'Indicates that Java 7.1 SDK version should be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/common_ibm_sdk_v71/offering_id',
# <md>          :displayname => 'Java 7.1 SDK installation manager offering id',
# <md>          :description => 'Java 7.1 SDK installation manager offering ID value, default = com.ibm.java.jdk.v71',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.java.jdk.v71',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/common_ibm_sdk_v71/feature',
# <md>          :displayname => 'Java 7.1 SDK installation manager feature id',
# <md>          :description => 'Feature name for java 7.1, default = com.ibm.sdk.71',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.sdk.71',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/websphere_sdk_v80/enable',
# <md>          :displayname => 'Install WebSphere JDK 8 SDK',
# <md>          :description => 'Indicates that WebSphere Liberty Java 8 SDK version should be installed, only one Java flag is applicable',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/websphere_sdk_v80/offering_id',
# <md>          :displayname => 'Java 8.0 SDK installation manager offering id',
# <md>          :description => 'Java 8.0 SDK installation manager offering ID value, default = com.ibm.websphere.liberty.IBMJAVA.v80',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.websphere.liberty.IBMJAVA.v80',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/websphere_sdk_v80/feature',
# <md>          :displayname => 'Java 8.0 SDK installation manager feature id',
# <md>          :description => 'Feature name for java 8.0, default = com.ibm.sdk.8',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.sdk.8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'


# <md> attribute 'was_liberty/sdk/websphere_sdk_v70/enable',
# <md>          :displayname => 'Install WebSphere JDK 7 SDK',
# <md>          :description => 'Indicates that WebSphere Liberty Java 7 SDK version should be installed, only one Java flag is applicable',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/websphere_sdk_v70/offering_id',
# <md>          :displayname => 'Java 7.0 SDK installation manager offering id',
# <md>          :description => 'Java 7.0 SDK installation manager offering ID value, default = com.ibm.websphere.liberty.IBMJAVA.v70',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.websphere.liberty.IBMJAVA.v70',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/sdk/websphere_sdk_v70/feature',
# <md>          :displayname => 'Java 7.0 SDK installation manager feature id',
# <md>          :description => 'Feature name for java common_ibm_sdk_v71, default = com.ibm.sdk.7',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'com.ibm.sdk.7',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was_liberty']['sdk'] = {
  'common_ibm_sdk_v8'  => { 'enable' => "true",
                            'offering_id' => "com.ibm.java.jdk.v8",
                            'feature' => "com.ibm.sdk.8" },
  'common_ibm_sdk_v71' => { 'enable' => "false",
                            'offering_id' => "com.ibm.java.jdk.v71",
                            'feature' => "com.ibm.sdk.71" },
  'websphere_sdk_v80'  => { 'enable' => "false",
                            'offering_id' => "com.ibm.websphere.liberty.IBMJAVA.v80",
                            'feature' => "com.ibm.sdk.8" },
  'websphere_sdk_v70'  => { 'enable' => "false",
                            'offering_id' => "com.ibm.websphere.liberty.IBMJAVA.v70",
                            'feature' => "com.ibm.sdk.7" }
}

# <> Liberty version to install
# <md> attribute 'was_liberty/base_version',
# <md>          :displayname => 'Liberty version',
# <md>          :description => 'The release and fixpack level for WebSphere Liberty to be installed. Example formats are 8.5.5.11 or 17.0.2',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '17.0.2',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was_liberty']['base_version'] = "17.0.2" # ~ip_checker

# <> Java version to install
# <md> attribute 'was_liberty/java_version',
# <md>          :displayname => 'Liberty Java SDK version,
# <md>          :description => 'The Java SDK version that should be installed with Liberty. Example format is 8.0',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8.0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was_liberty']['java_version'] = "8.0"

# <> Liberty fixpack to install
# <md> attribute 'was_liberty/fixpack',
# <md>          :displayname => 'liberty fixpack version',
# <md>          :description => 'The fixpack version of Liberty that should be isntalled, for initial installation this may be left blank' ,
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'
default['was_liberty']['fixpack'] = "" # ~ip_checker

# <> if true, IBM Java will be installed from archives
# <md> attribute 'was_liberty/install_java',
# <md>          :displayname => 'Java install from archives',
# <md>          :description => 'If true, Java will be installed from archives',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['install_java'] = "true"

# <> Java fixpack to install
# <md> attribute 'was_liberty/fixpack_java',
# <md>          :displayname => 'Java fixpack version',
# <md>          :description => 'The java fixpack version to be installed, this field may be left blank',

# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['fixpack_java'] = "" # ~ip_checker
# <> if true, IBM Java fp will be installed
# <md> attribute 'was_liberty/install_javafp',
# <md>          :displayname => 'Java fixpack flag',
# <md>          :description => 'If true, a java fixpack will be installed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'true',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['install_javafp'] = "true"

#################################
# Liberty Server settings
#################################

# <> Force a server restart  even if it is running
# <md> attribute 'was_liberty/force_restart',
# <md>          :displayname => 'Liberty force restart',
# <md>          :description => 'If set to true, the server will be restarted, if false, the server will not be restarted',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => true,
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['force_restart'] = true

# <md>attribute '$dynamicmaps/was_liberty/liberty_servers',
# <md>          :$displayname =>  'IBM Liberty Servers',
# <md>          :$key => 'server',
# <md>          :$max => '4',
# <md>          :$count => '0'

# <> Liberty servers parameters
# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/name',
# <md>          :displayname => 'Liberty server name',
# <md>          :description => 'Name of the initial Liberty server to be created during provisioning',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'defaultServer',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/jvm_params',
# <md>          :displayname => 'Liberty server JVM settings',
# <md>          :description => 'Set the default JVM heap sizes for the liberty server, for example, -Xms256m -Xmx2048m',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '-Xms256m -Xmx2048m',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/timeout',
# <md>          :displayname => 'liberty server timeout',
# <md>          :description => 'Liberty server timeout value',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '20',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/httpport',
# <md>          :displayname => 'Liberty server http port',
# <md>          :description => 'HTTP Transport value that will be set in the defaultHttpEndpoint endpoint in server.xml',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9080',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/httpsport',
# <md>          :displayname => 'Liberty server https port',
# <md>          :description => 'Secure HTTP Transport value that will be set in the defaultHttpEndpoint endpoint in server.xml',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9443',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/feature',
# <md>          :displayname => 'Liberty features that should be included in the server definition',
# <md>          :description => 'Lists the Liberty features that should be included in the feature manager list. For example, webProfile-7.0 adminCenter-1.0',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'webProfile-7.0 adminCenter-1.0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/keystore_id',
# <md>          :displayname => 'Liberty keystore id',
# <md>          :description => 'Keystore id that will be used when setting up the keyStore attribute in the server.xml',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'defaultKeyStore',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/keystore_password',
# <md>          :displayname => 'Liberty Keystore password',
# <md>          :description => 'Liberty keystore password used to protect the Liberty keystore id, this value will be stored in Chef Vault',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :hidden => 'false',
# <md>          :secret => 'true'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/users/admin_user/name',
# <md>          :displayname => 'Liberty administrative user name',
# <md>          :description => 'Administrative console username used for accessing the console, the associated password is the admin_user password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'admin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/users/admin_user/password',
# <md>          :displayname => 'Liberty administrative user name password',
# <md>          :description => 'Password for the Liberty administrative user name, this value to be stored in the Chef Vault',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :regex => '^[!-~]{8,32}$',
# <md>          :regexdesc => 'Allow 8 to 32 printable ASCII characters except space.',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true',
# <md>          :hidden => 'false'

# <md> attribute 'was_liberty/liberty_servers/server($INDEX)/users/admin_user/role',
# <md>          :displayname => 'liberty admin user role',
# <md>          :description => 'Liberty role for which administrative users are to be added to, the admin_user will be added to this role by default',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'admin',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['liberty_servers'] = {
  'server1' => { 'name' => "defaultServer",
                 'jvm_params' => "-Xms256m -Xmx2048m",
                 'timeout' => "20",
                 'httpport' => "9080",
                 'httpsport' => "9443",
                 'feature' => "webProfile-7.0 adminCenter-1.0",
                 'keystore_id' => "defaultKeyStore",
                 'keystore_password' => "",
                 'users' => {
                   'admin_user' => {
                     'name' => "admin",
                     'password' => "",
                     'role' => "admin"
                   }
                 }
  }
}

# server farm configuration
# <md> attribute 'was_liberty/farm/webserverhost',
# <md>          :displayname => 'Liberty farm HTTP Server Host',
# <md>          :description => 'Fully qualified domain name of the IBM HTTP server to which the central server will push the plugin',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['webserverhost'] = ''

# <md> attribute 'was_liberty/farm/webserverPort',
# <md>          :displayname => 'Liberty farm HTTP Web server port',
# <md>          :description => 'HTTP Transport port that the webserver is listening on',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '80',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['webserverPort'] = '80'

# <md> attribute 'was_liberty/farm/webserverSecurePort',
# <md>          :displayname => 'Liberty farm HTTP Secure web server port'',
# <md>          :description => 'HTTPS Transport port that the webserver is listening on',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '9043',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['webserverSecurePort'] = '9043'

# <md> attribute 'was_liberty/farm/webserverName',
# <md>          :displayname => 'Liberty farm web server name',
# <md>          :description => 'A descriptive name for the web server',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'websrv',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['webserverName'] = 'websrv'

# <md> attribute 'was_liberty/farm/httpd_plugins_dir',
# <md>          :descriptive => 'Liberty http plugins dir',
# <md>          :description => 'Liberty farm directory on the web server where the merged plugin will be pushed',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['httpd_plugins_dir'] = ''

# <md> attribute 'was_liberty/farm/httpd_user',
# <md>          :displayname => 'Liberty farm http user',
# <md>          :descriptive => 'Liberty farm user for pushing the merged plugin file to the web server host',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['httpd_user'] = ''

# <md> attribute 'was_liberty/farm/sslKeyringLocation',
# <md>          :displayname => 'Liberty farm ssl Stashfile directory',
# <md>          :description => 'Full path to the liberty farm ssl Keyring, path must not include the name of the Keyring file',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/liberty/sslkeyring',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['sslKeyringLocation'] = '/var/liberty/sslkeyring'

# <md> attribute 'was_liberty/farm/sslStashfileLocation',
# <md>          :displayname => 'Liberty farm ssl Stashfile directory',
# <md>          :description => 'Full path to the Liberty farm ssl Stashfile, path must not include the name of the stash file',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/var/liberty/stashfile',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['sslStashfileLocation'] = '/var/liberty/stashfile'

# <md> attribute 'was_liberty/farm/sslCertlabel',
# <md>          :displayname => 'Liberty farm ssl Cert label',
# <md>          :description => 'Name of the ssl Cert label which will be added to the keystore',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'definedbyuser',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['sslCertlabel'] = 'definedbyuser'

# <md> attribute 'was_liberty/farm/logFileName',
# <md>          :displayname => 'liberty farm log File Name',
# <md>          :description => 'Name of the Liberty farm log file',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'serverfarm.log',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['logFileName'] = "serverfarm.log"

# <md> attribute 'was_liberty/farm/pluginInstallRoot',
# <md>          :displayname => 'Liberty farm plugin Install Root',
# <md>          :description => 'pluginInstallRoot',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'plugin_install_root',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['pluginInstallRoot'] = "plugin_install_root"


# server plugins settings
# <md> attribute 'was_liberty/farm/central_node',
# <md>          :displayname => 'Liberty farm central node',
# <md>          :description => 'Hostname/IP of the liberty node which will gather and merge the plugins. Leave empty when deploying the central node itself',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['central_node'] = ''

# <md> attribute 'was_liberty/farm/plugins_dir',
# <md>          :displayname => 'Liberty farm plugin dir',
# <md>          :description => 'The directory where the generated plugins are stored',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['plugins_dir'] = "#{node['was_liberty']['wlp_user_dir']}/tmp"

# <md> attribute 'was_liberty/farm/mergedplugins_dir',
# <md>          :displayname => 'Liberty farm merged plugin directory',
# <md>          :description => 'The directory where the merged plugins are stored on the central node',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['mergedplugins_dir'] = "#{node['was_liberty']['farm']['plugins_dir']}/merged"

# <md> attribute 'was_liberty/farm/plugin_cpy_user',
# <md>          :displayname => 'Liberty plugin copy user',
# <md>          :description => 'The user for pushing the plugins to the central liberty node',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['plugin_cpy_user'] = node['was_liberty']['install_user']

# <md> attribute 'was_liberty/farm/webserverhost',
# <md>          :displayname => 'Liberty web server host',
# <md>          :description => 'Host name of the web server, not this DNS name must be resolvable',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['was_liberty']['farm']['webserverhost'] = ''

# <md> attribute 'ssh/private_key/path',
# <md>          :displayname => 'Liberty private key path',
# <md>          :description => 'Absolute path of the Liberty private key',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['ssh']['private_key']['path'] = '/root/.ssh/CAMkey.pem'

# <md> attribute 'ssh/private_key/content',
# <md>          :displayname => 'Liberty private key,
# <md>          :description => 'Content of the private key referred to in the private_key_path field',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node'
# <md>          :secret => 'true',
# <md>          :hidden => 'false',
# <md>          :secret => 'false'

default['ssh']['private_key']['content'] = ''
