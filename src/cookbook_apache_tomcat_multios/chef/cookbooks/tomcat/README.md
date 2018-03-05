Tomcat Cookbook
===============

## DESCRIPTION
This cookbook installs and configures Apache Tomcat.

## Platforms Support
* Red Hat Enterprise Linux 7
* Red Hat Enterprise Linux 6
* Ubuntu 16.04 LTS
* Ubuntu 14.04 LTS

## Versions
* Apache Tomcat 8.0.x
* Apache Tomcat 8.5.x

## Use Cases
* Basic install, no SSL, no users
* Install with SSL support, admin user

## Platform Pre-Requisites
* Linux YUM Repository - An onsite linux YUM Repsoitory is required.

## Softare Package Repository
REPO -> Stored in the ['ibm']['sw_repo'] attribute.


Requirements
------------

### Platform:

* Rhel6 (>= 6.5)
* Rhel7
* Ubuntu (>= 14.04)

### Cookbooks:

* ibm_cloud_utils

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ajp']['port']</code></td>
    <td>Specifies the AJP port to be configured in Tomcat.</td>
    <td><code>8009</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['http']['port']</code></td>
    <td>The Tomcat port to service HTTP requests.</td>
    <td><code>8080</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['install_dir']</code></td>
    <td>Specifies the directory to install Tomcat.</td>
    <td><code>/opt/tomcat</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['instance_dirs']['conf_dir']</code></td>
    <td>Specifies the directory for Tomcat configuration data.</td>
    <td><code>/opt/tomcat/conf</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['instance_dirs']['log_dir']</code></td>
    <td>Specifies the directory for Tomcat log files.</td>
    <td><code>/opt/tomcat/logs</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['instance_dirs']['temp_dir']</code></td>
    <td>Specifies the temporary directory for Tomcat.</td>
    <td><code>/opt/tomcat/temp</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['instance_dirs']['webapps_dir']</code></td>
    <td>Specifies the Tomcat directory for web applications.</td>
    <td><code>/opt/tomcat/webapps</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['instance_dirs']['work_dir']</code></td>
    <td>Specifies the Tomcat working directory.</td>
    <td><code>/opt/tomcat/work</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['java']['catalina_opts']</code></td>
    <td>Specifies additional options on the java command used to start Tomcat.</td>
    <td><code>-Xms512M -Xmx1024M -server -XX:+UseParallelGC</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['java']['java_opts']</code></td>
    <td>Specifies additional options for commands to start, stop and more on Tomcat.</td>
    <td><code>-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['java']['java_sdk']</code></td>
    <td>Specifies the use of a Java Development Kit (false) or Runtime Environment (true).</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['java']['vendor']</code></td>
    <td>Currently only openjdk is supported as the Tomcat java vendor.</td>
    <td><code>openjdk</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['java']['version']</code></td>
    <td>The version of Java to be used for Tomcat.</td>
    <td><code>1.8.0</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['os_users']['daemon']['comment']</code></td>
    <td>Specifies a login comment for the Tomcat daemon user.</td>
    <td><code>tomcat daemon user</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['os_users']['daemon']['gid']</code></td>
    <td>Specifies the name of the Operating System group for Tomcat daemon users.</td>
    <td><code>tomcat</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['os_users']['daemon']['home']</code></td>
    <td>Specifies the home directory of the Tomcat daemon user.</td>
    <td><code>/home/tomcat</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['os_users']['daemon']['ldap_user']</code></td>
    <td>Specifies whether the Tomcat daemon user is stored in LDAP.</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['os_users']['daemon']['name']</code></td>
    <td>Specifies the user for the Tomcat daemon.</td>
    <td><code>tomcat</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['os_users']['daemon']['shell']</code></td>
    <td>The Tomcat daemon Unix shell.</td>
    <td><code>/sbin/nologin</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['server']['manage']</code></td>
    <td>Specifies whether the tomcat server.xml is managed by CHEF or allows for manually modifications.</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['server']['port']</code></td>
    <td>Specifies the server port to be configured in Tomcat.</td>
    <td><code>8005</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['server']['shutdown_cmd']</code></td>
    <td>Specifies the command to be used to shutdown Tomcat.</td>
    <td><code>SHUTDOWN</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['service']['enabled']</code></td>
    <td>Specifies whether the Tomcat service will be started automatically on server reboot.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['service']['name']</code></td>
    <td>Specifies the Tomcat service name.</td>
    <td><code>tomcat</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['service']['started']</code></td>
    <td>Specifies the desired Tomcat service state.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['alias']</code></td>
    <td>Tomcat SSL certificate alias for identification in the keystore</td>
    <td><code>tomcat</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['c']</code></td>
    <td>Tomcat SSL certificate country</td>
    <td><code>US</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['cn']</code></td>
    <td>Tomcat SSL certificate common name</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['l']</code></td>
    <td>Tomcat SSL certificate location</td>
    <td><code>Rochester</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['o']</code></td>
    <td>Tomcat SSL certificate organization</td>
    <td><code>Company</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['ou']</code></td>
    <td>Tomcat SSL certificate organizational unit</td>
    <td><code>Org</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['s']</code></td>
    <td>Tomcat SSL certificate state</td>
    <td><code>MN</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['cert']['validity']</code></td>
    <td>Tomcat SSL certificate validity period</td>
    <td><code>3650</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['enabled']</code></td>
    <td>Indicates whether to enable the Tomcat SSL connector.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['keystore']['alg']</code></td>
    <td>The RSA algorithm should be preferred as a secure algorithm.</td>
    <td><code>RSA</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['keystore']['file']</code></td>
    <td>Path to the Tomcat SSL Keystore file.</td>
    <td><code>/opt/tomcat/conf/keystore.jks</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['keystore']['password']</code></td>
    <td>The keystore password used in Tomcat for SSL configuration.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['keystore']['type']</code></td>
    <td>Specifies the keystore type for which Tomcat supports JKS, PKCS11 or PKCS12 formats.</td>
    <td><code>JKS</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['options']['ciphers']</code></td>
    <td>Tomcat SSL options ciphers</td>
    <td><code>TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_RC4_128_SHA,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA,SSL_RSA_WITH_RC4_128_SHA</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['options']['max_threads']</code></td>
    <td>Tomcat SSL options max threads</td>
    <td><code>200</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['options']['protocol']</code></td>
    <td>Tomcat SSL options protocol</td>
    <td><code>TLS</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ssl']['port']</code></td>
    <td>Tomcat port for SSL communication</td>
    <td><code>8443</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['all_roles']['admin-gui']</code></td>
    <td>Tomcat roles: admin-gui</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['all_roles']['manager-gui']</code></td>
    <td>Tomcat roles: manager-gui</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['all_roles']['manager-jmx']</code></td>
    <td>Tomcat roles: manager-jmx</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['all_roles']['manager-script']</code></td>
    <td>Tomcat roles: manager-script</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['all_roles']['manager-status']</code></td>
    <td>Tomcat roles: manager-status</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['name']</code></td>
    <td>Name of the admin user to be configured in Tomcat.</td>
    <td><code>admin</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['password']</code></td>
    <td>Password of the admin user to be configured in Tomcat.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['status']</code></td>
    <td>Specifies whether to enable the admin user in the Tomcat configuration.</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['user_roles']['admin-gui']</code></td>
    <td>Tomcat users administrator roles: admin-gui</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-gui']</code></td>
    <td>Tomcat users administrator roles: manager-gui</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-jmx']</code></td>
    <td>Tomcat users administrator roles: manager-jmx</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-script']</code></td>
    <td>Tomcat users administrator roles: manager-script</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['ui_control']['users']['administrator']['user_roles']['manager-status']</code></td>
    <td>Tomcat users administrator roles: manager-status</td>
    <td><code>enabled</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['version']</code></td>
    <td>The version of Tomcat to be installed.</td>
    <td><code>8.0.15</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['webapps']['enabled']['ROOT']</code></td>
    <td>Tomcat webapp ROOT</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['webapps']['enabled']['docs']</code></td>
    <td>Specifies whether to install the Tomcat webapp examples documentation.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['webapps']['enabled']['examples']</code></td>
    <td>Specifies whether to install the Tomcat webapp examples.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['webapps']['enabled']['host-manager']</code></td>
    <td>Specifies whether to install the Tomcat host-manager webapp.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['tomcat']['webapps']['enabled']['manager']</code></td>
    <td>Specifies whether to install the Tomcat manager webapp.</td>
    <td><code>true</code></td>
  </tr>
</table>

Recipes
-------

### tomcat::cleanup.rb


Cleanup recipe (cleanup.rb)
Perform post-install cleanup


### tomcat::configure_tomcat_init.rb


Create init script (configure_tomcat_init.rb)
Create init script.


### tomcat::configure_tomcat_server.rb


Configure tomcat server recipe (configure_tomcat_server.rb)
Setup the main server configuration file


### tomcat::configure_tomcat_users.rb




### tomcat::default.rb


Default recipe (default.rb)
Include recipes for a standard installation


### tomcat::gather_evidence.rb


Gather evidence recipe (gather_evidence.rb)
Gather evidence that installation was successful


### tomcat::install.rb


Installation recipe (install.rb)
Perform an installation of selected tomcat package on the target node.


### tomcat::prereq.rb


Prerequisites recipe (prereq.rb)
Perform prerequisite tasks.


### tomcat::prereq_check.rb


Prerequisites recipe (prereq_check.rb)
Verify required prerequisites, validate input


### tomcat::service.rb


Service setup recipe (service.rb)
Configure tomcat service



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2017, 2017

