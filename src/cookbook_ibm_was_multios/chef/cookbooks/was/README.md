Was Cookbook
============

Installs and configures WebSphere Application Server and WebSphere Application Server Network Deployment

Requirements
------------

### Platform:

* Rhel6 (>= 6.5)
* Rhel7 (>= 7.0)
* Ubuntu14 (>= 14.04)
* Ubuntu16 (>= 16.0.4)

### Cookbooks:

* ibm_cloud_utils
* im
* linux

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['was']['config']['enable_admin_security']</code></td>
    <td>Enable WebSphere administrative console security</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['config']['os_service']</code></td>
    <td>Setup appropriate operating system job to start WebSphere at system startup</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['config']['use_default_certs']</code></td>
    <td>Use WebSphere default certificates when creating profiles</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['dmgr_host_name']</code></td>
    <td>The fully qualified domain name of the deployment manager to federate this node to</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['dmgr_role_name']</code></td>
    <td>Used for Chef search</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['edition']['base']</code></td>
    <td>WebSphere Application Server will be installed and configured</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['was']['edition']['nd']</code></td>
    <td>WebSphere Application Server Network Deployment will be installed and configured</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['features']['core.feature']</code></td>
    <td>Indicates that the application server feature (core.feature) should be installed</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['features']['ejbdeploy']</code></td>
    <td>Indicates whether the optional feature EJBDeploy tool for pre-EJB 3.0 modules should be installed</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['features']['embeddablecontainer']</code></td>
    <td>Indicates whether the embeddable EJB container should be installed</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['features']['liberty']</code></td>
    <td>Indicates whether the WebSphere Liberty Application Server should be installed. Used for WebSphere installations that bundled Liberty as an install option</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['was']['features']['samples']</code></td>
    <td>Indicates whether the PlantsByWebSphere sample application should be installed</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['was']['features']['thinclient']</code></td>
    <td>Indicates whether the optional IBM stand-alone thin clients and resource adapters should be installed</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['ihs_host_name']</code></td>
    <td>Fully qualified domain name of the IBM HTTP server</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['ihs_role_names']</code></td>
    <td>Used for Chef search</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['install_dir']</code></td>
    <td>The installation root directory for the WebSphere Application Server product binaries</td>
    <td><code>/opt/IBM/WebSphere/AppServer</code></td>
  </tr>
  <tr>
    <td><code>node['was']['java_features']['websphere_java_v8']['enable']</code></td>
    <td>Installation Manager response file option to install Java 8 SDK. Valid only for WebSphere V9</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['was']['java_features']['websphere_java_v8']['offering_id']</code></td>
    <td>Java SDK installation manager offering ID value</td>
    <td><code>com.ibm.java.jdk.v8</code></td>
  </tr>
  <tr>
    <td><code>node['was']['java_version']</code></td>
    <td>The Java SDK version that should be installed with the WebSphere Application Server. Example format is 8.0.4.70</td>
    <td><code>8.0.4.70</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_perms']</code></td>
    <td>File permissions for the WebSphere installation</td>
    <td><code>750</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_users']['was']['comment']</code></td>
    <td>Comment that will be added when creating the userid</td>
    <td><code>WAS administrative user</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_users']['was']['gid']</code></td>
    <td>Operating system group name that will be assigned to the product installation</td>
    <td><code>wasgrp</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_users']['was']['home']</code></td>
    <td>Home directory location for operating system user that is used for product installation</td>
    <td><code>/home/wasadmin</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_users']['was']['ldap_user']</code></td>
    <td>A flag which indicates whether to create the WebSphere user locally, or utilize an LDAP based user</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_users']['was']['name']</code></td>
    <td>Operating system userid that will be used to install the product. Userid will be created if it does not exist</td>
    <td><code>wasadmin</code></td>
  </tr>
  <tr>
    <td><code>node['was']['os_users']['was']['shell']</code></td>
    <td>Default shell for the operating system userid</td>
    <td><code>/bin/bash</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profile_dir']</code></td>
    <td>The directory path that contains WebSphere Application Server profiles</td>
    <td><code>/opt/IBM/WebSphere/AppServer/profiles</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['cell']</code></td>
    <td>A cell name is a logical name for the group of nodes administered by the deployment manager cell</td>
    <td><code>cell01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['host']</code></td>
    <td>A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_)</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['keystorepassword']</code></td>
    <td>Specifies the password to use on keystore created during profile creation</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['node']</code></td>
    <td>A node name is for administration by the deployment manager.  The name must be unique within the cell</td>
    <td><code>{SHORTHOSTNAME}CellManager01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['personalcertdn']</code></td>
    <td>Specifies the distinguished name of the personal certificate that you are creating when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['personalcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the default personal certificate is valid</td>
    <td><code>3</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['BOOTSTRAP_ADDRESS']</code></td>
    <td>Deployment Manager Bootstrap Port value (BOOTSTRAP_ADDRESS)</td>
    <td><code>9809</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['CELL_DISCOVERY_ADDRESS']</code></td>
    <td>Deployment Manager Cell Discovery Address port value (CELL_DISCOVERY_ADDRESS)</td>
    <td><code>7277</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager CSIV2 Client Authentication Listener Port (CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)</td>
    <td><code>9402</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager CSIV2 Server Authentication Listener Port (CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS) value</td>
    <td><code>9403</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['DCS_UNICAST_ADDRESS']</code></td>
    <td>Deployment Manager High Availability Manager Communication Port (DCS_UNICAST_ADDRESS)</td>
    <td><code>9352</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['DataPowerMgr_inbound_secure']</code></td>
    <td>Deployment Manager DataPower Appliance Manager Secure Inbound Port (DataPowerMgr_inbound_secure)</td>
    <td><code>5555</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['IPC_CONNECTOR_ADDRESS']</code></td>
    <td>Deployment Manager IPC Connector Port value (IPC_CONNECTOR_ADDRESS)</td>
    <td><code>9632</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['ORB_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager ORB Listener Port (ORB_LISTENER_ADDRESS)</td>
    <td><code>9100</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['OVERLAY_TCP_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager Administration Overlay TCP Port (OVERLAY_TCP_LISTENER_ADDRESS)</td>
    <td><code>11006</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['OVERLAY_UDP_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager Administration Overlay UDP Port (OVERLAY_UDP_LISTENER_ADDRESS)</td>
    <td><code>11005</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager SAS_SSL_SERVERAUTH_LISTENER_ADDRESS</td>
    <td><code>9401</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['SOAP_CONNECTOR_ADDRESS']</code></td>
    <td>Deployment Manager SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)</td>
    <td><code>8879</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['STATUS_LISTENER_ADDRESS']</code></td>
    <td>Deployment Manager Status Update Listener Port (STATUS_LISTENER_ADDRESS)</td>
    <td><code>9420</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['WC_adminhost']</code></td>
    <td>Deployment Manager Administrative Console Port (WC_adminhost)</td>
    <td><code>9060</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['WC_adminhost_secure']</code></td>
    <td>Deployment Manager Adminsitrative Secure Console Port (WC_adminhost_secure)</td>
    <td><code>9043</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['ports']['XDAGENT_PORT']</code></td>
    <td>Deployment Manager Middleware Agent RPC Port (XDAGENT_PORT)</td>
    <td><code>7060</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['profile']</code></td>
    <td>WebSphere Deployment Manager profile name</td>
    <td><code>Dmgr01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['signingcertdn']</code></td>
    <td>Specifies the distinguished name of the root signing certificate that you create when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['dmgr']['signingcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the root signing certificate is valid</td>
    <td><code>15</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['cell']</code></td>
    <td>Cell name of the Job manager </td>
    <td><code>cell01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['host']</code></td>
    <td>A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_)</td>
    <td><code>{FULLHOSTNAME}</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['keystorepassword']</code></td>
    <td>Specifies the password to use on all keystore files created during profile creation</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['node']</code></td>
    <td>Node name is for administration and must be unique</td>
    <td><code>{SHORTHOSTNAME}JobMgr01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['personalcertdn']</code></td>
    <td>Specifies the distinguished name of the personal certificate that you are creating when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['personalcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the default personal certificate is valid</td>
    <td><code>3</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['BOOTSTRAP_ADDRESS']</code></td>
    <td>Bootstrap Port value (BOOTSTRAP_ADDRESS)</td>
    <td><code>9808</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']</code></td>
    <td>CSIV2 Client Authentication Listener Port (CSIV2_ SSL_ MUTUALAUTH_ LISTENER_ ADDRESS)	9402</td>
    <td><code>9402</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>CSIV2 Server Authentication Listener Port (CSIV2_ SSL_ SERVERAUTH_ LISTENER_ ADDRESS)</td>
    <td><code>9403</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['IPC_CONNECTOR_ADDRESS']</code></td>
    <td>IPC Connector Port value (IPC_CONNECTOR_ADDRESS),
# <md>          :type => </td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['ORB_LISTENER_ADDRESS']</code></td>
    <td>ORB Listener Port (ORB_LISTENER_ADDRESS)</td>
    <td><code>9099</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>SAS_ SSL_ SERVERAUTH_ LISTENER_ ADDRESS (Deprecated)</td>
    <td><code>9401</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['SOAP_CONNECTOR_ADDRESS']</code></td>
    <td>SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)</td>
    <td><code>8876</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['STATUS_LISTENER_ADDRESS']</code></td>
    <td>Status Update Listener Port (STATUS_ LISTENER_ ADDRESS)</td>
    <td><code>9425</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['WC_adminhost']</code></td>
    <td>Job Manager Administrative Console Port (WC_adminhost)</td>
    <td><code>9960</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['ports']['WC_adminhost_secure']</code></td>
    <td>Job Manager Adminsitrative Secure Console Port (WC_adminhost_secure)</td>
    <td><code>9943</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['profile']</code></td>
    <td>Job Manager profile name</td>
    <td><code>JobMgr01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['signingcertdn']</code></td>
    <td>Specifies the distinguished name of the root signing certificate that you create when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['job_manager']['signingcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the root signing certificate is valid</td>
    <td><code>15</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['dmgr_host']</code></td>
    <td>Speicfy the host name or IP address for an existing deployment manager</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['dmgr_port']</code></td>
    <td>Deployment Manager SOAP Port that is used when federating the custom profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['host']</code></td>
    <td>A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_),
# <md>          :type => </td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['keystorepassword']</code></td>
    <td>Specifies the password to use on all keystore files created during profile creation</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['node']</code></td>
    <td>Unique node name for this federated node.  Must be unique within the cell</td>
    <td><code>{SHORTHOSTNAME}Node01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['personalcertdn']</code></td>
    <td>Specifies the distinguished name of the personal certificate that you are creating when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['personalcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the default personal certificate is valid</td>
    <td><code>3</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['BOOTSTRAP_ADDRESS']</code></td>
    <td>Server bootstrap (BOOTSTRAP_ADDRESS)</td>
    <td><code>2810</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']</code></td>
    <td>CSIV2 Client Authentication Listener Port (CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)</td>
    <td><code>9202</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>CSIV2 Server Authentication Listener Port (CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)</td>
    <td><code>9201</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['DCS_UNICAST_ADDRESS']</code></td>
    <td>High Availability Manager Communication Port (DCS_UNICAST_ADDRESS)</td>
    <td><code>9354</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['IPC_CONNECTOR_ADDRESS']</code></td>
    <td>IPC Connector Port value (IPC_CONNECTOR_ADDRESS)</td>
    <td><code>9626</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['NODE_DISCOVERY_ADDRESS']</code></td>
    <td>Node Discovery Address (NODE_DISCOVERY_ADDRESS)</td>
    <td><code>7272</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS']</code></td>
    <td>Node IPV6 Discovery Address (NODE_IPV6_MULTICAST_DISCOVERY_ADDRESS)</td>
    <td><code>5001</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['NODE_MULTICAST_DISCOVERY_ADDRESS']</code></td>
    <td>was node_profile profiles ports NODE_MULTICAST_DISCOVERY_ADDRESS</td>
    <td><code>5000</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['ORB_LISTENER_ADDRESS']</code></td>
    <td>ORB Listener Port (ORB_LISTENER_ADDRESS)</td>
    <td><code>9101</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['OVERLAY_TCP_LISTENER_ADDRESS']</code></td>
    <td>Node Administration Overlay TCP Port (OVERLAY_TCP_LISTENER_ADDRESS)</td>
    <td><code>11002</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['OVERLAY_UDP_LISTENER_ADDRESS']</code></td>
    <td>Node Administration Overlay UDP Port (OVERLAY_UDP_LISTENER_ADDRESS)</td>
    <td><code>11001</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>was node_profile profiles ports SAS_SSL_SERVERAUTH_LISTENER_ADDRESS</td>
    <td><code>9901</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['SOAP_CONNECTOR_ADDRESS']</code></td>
    <td>SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)</td>
    <td><code>8878</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['STATUS_LISTENER_ADDRESS']</code></td>
    <td>Status Update Listener Port (STATUS_LISTENER_ADDRESS)</td>
    <td><code>9420</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['WC_adminhost']</code></td>
    <td>Administrative Console Port (WC_adminhost)</td>
    <td><code>9060</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['ports']['XDAGENT_PORT']</code></td>
    <td>Node Middleware Agent RPC Port (XDAGENT_PORT)</td>
    <td><code>7061</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['profile']</code></td>
    <td>Profile name for a custom profile</td>
    <td><code>Custom01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['signingcertdn']</code></td>
    <td>Specifies the distinguished name of the root signing certificate that you create when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['node_profile']['signingcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the root signing certificate is valid</td>
    <td><code>15</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['cell']</code></td>
    <td>Cell name for the application server</td>
    <td><code>cell01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['host']</code></td>
    <td>A host name is the domain name system (DNS) name (short or long) or the IP address of this virtual machine and cannot contain an understore (_)</td>
    <td><code>{FULLHOSTNAME}</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['keystorepassword']</code></td>
    <td>Specifies the password to use on all keystore files created during profile creation</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['node']</code></td>
    <td>A node name is used for administration</td>
    <td><code>{SHORTHOSTNAME}Node01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['personalcertdn']</code></td>
    <td>Specifies the distinguished name of the personal certificate that you are creating when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['personalcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the default personal certificate is valid</td>
    <td><code>3</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['BOOTSTRAP_ADDRESS']</code></td>
    <td>Bootstrap Port value (BOOTSTRAP_ADDRESS)</td>
    <td><code>2809</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS']</code></td>
    <td>CSIV2 Client Authentication Listener Port (CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)</td>
    <td><code>9402</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>CSIV2 Server Authentication Listener Port (CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)</td>
    <td><code>9403</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['DCS_UNICAST_ADDRESS']</code></td>
    <td>High Availability Manager Communication Port (DCS_UNICAST_ADDRESS)</td>
    <td><code>9353</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['IPC_CONNECTOR_ADDRESS']</code></td>
    <td>IPC Connector Port value (IPC_CONNECTOR_ADDRESS)</td>
    <td><code>9633</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['ORB_LISTENER_ADDRESS']</code></td>
    <td>ORB Listener Port (ORB_LISTENER_ADDRESS)</td>
    <td><code>9100</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['OVERLAY_TCP_LISTENER_ADDRESS']</code></td>
    <td>Administration Overlay TCP Port (OVERLAY_TCP_LISTENER_ADDRESS)</td>
    <td><code>11004</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['OVERLAY_UDP_LISTENER_ADDRESS']</code></td>
    <td>Administration Overlay UDP Port (OVERLAY_UDP_LISTENER_ADDRESS)</td>
    <td><code>11003</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SAS_SSL_SERVERAUTH_LISTENER_ADDRESS']</code></td>
    <td>Application Server SAS_SSL_SERVERAUTH_LISTENER_ADDRESS</td>
    <td><code>9401</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SIB_ENDPOINT_ADDRESS']</code></td>
    <td>Service Integration Port (SIB_ENDPOINT_ADDRESS)</td>
    <td><code>7276</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SIB_ENDPOINT_SECURE_ADDRESS']</code></td>
    <td>Service Integration Secure Port  (SIB_ENDPOINT_SECURE_ADDRESS)</td>
    <td><code>7286</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SIB_MQ_ENDPOINT_ADDRESS']</code></td>
    <td>MQ Transport Port (SIB_MQ_ENDPOINT_ADDRESS)</td>
    <td><code>5558</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SIB_MQ_ENDPOINT_SECURE_ADDRESS']</code></td>
    <td>MQ Transport Secure Port  (SIB_MQ_ENDPOINT_SECURE_ADDRESS)</td>
    <td><code>5578</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SIP_DEFAULTHOST']</code></td>
    <td>SIP Container Port (SIP_DEFAULTHOST)</td>
    <td><code>5060</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SIP_DEFAULTHOST_SECURE']</code></td>
    <td>SIP Container Secure Port (SIP_DEFAULTHOST_SECURE)</td>
    <td><code>5061</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['SOAP_CONNECTOR_ADDRESS']</code></td>
    <td>SOAP Connector Port value (SOAP_CONNECTOR_ADDRESS)</td>
    <td><code>8880</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['WC_adminhost']</code></td>
    <td>Server Administrative Console Port (WC_adminhost)</td>
    <td><code>9060</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['WC_adminhost_secure']</code></td>
    <td>Server Adminsitrative Secure Console Port (WC_adminhost_secure)</td>
    <td><code>9043</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['WC_defaulthost']</code></td>
    <td>HTTP Transport Port (WC_defaulthost)</td>
    <td><code>9080</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['ports']['WC_defaulthost_secure']</code></td>
    <td>HTTP Transport Secure Port (WC_defaulthost_secure)</td>
    <td><code>9443</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['profile']</code></td>
    <td>Application server profile name</td>
    <td><code>AppSrv01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['server']</code></td>
    <td>Name of the application server</td>
    <td><code>server1</code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['signingcertdn']</code></td>
    <td>Specifies the distinguished name of the root signing certificate that you create when you create the profile</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['profiles']['standalone_profiles']['standalone1']['signingcertvalidityperiod']</code></td>
    <td>An optional parameter that specifies the amount of time in years that the root signing certificate is valid</td>
    <td><code>15</code></td>
  </tr>
  <tr>
    <td><code>node['was']['security']['admin_user']</code></td>
    <td>The username for securing the WebSphere adminstrative console</td>
    <td><code>wasadmin</code></td>
  </tr>
  <tr>
    <td><code>node['was']['security']['admin_user_pwd']</code></td>
    <td>The password for the WebSphere administrative account</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['unmanaged_node']['unmngNode01']['host_name']</code></td>
    <td>The host name or ipaddress of the unmanaged host</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['unmanaged_node']['unmngNode01']['node_name']</code></td>
    <td>Node name for the unmanaged node</td>
    <td><code>{SHORTHOSTNAME}UnmangedNode01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['unmanaged_node']['unmngNode01']['os']</code></td>
    <td>Indicates the operating system type for the unmanaged node</td>
    <td><code>linux</code></td>
  </tr>
  <tr>
    <td><code>node['was']['version']</code></td>
    <td>The release and fixpack level of WebSphere Application Server to be installed. Example formats are 8.5.5.12 or 9.0.0.4</td>
    <td><code>9.0.0.4</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['admin_port']</code></td>
    <td>IBM HTTP Administrative Server Port.  Used for creating the web server definition</td>
    <td><code>8008</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['ihs_admin_password']</code></td>
    <td>IBM HTTP administrative username password. Used for creating the web server definition </td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['ihs_admin_user']</code></td>
    <td>IBM HTTP administrative username. Used for creating the web server definition</td>
    <td><code>ihsadmin</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['install_dir']</code></td>
    <td>Specify the HTTP Server installation directory. Used for creating the web server definition</td>
    <td><code>/opt/IBM/HTTPServer</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['node_name']</code></td>
    <td>Web server node name</td>
    <td><code>{SHORTHOSTNAME}UnmangedNode01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['plugin_dir']</code></td>
    <td>Specify the webserver plugin directory. Used for creating the web server definition</td>
    <td><code>/opt/IBM/WebSphere/Plugins</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['webapp_mapping']</code></td>
    <td>Indicate how the applications should be mapped from the webserver</td>
    <td><code>ALL</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['webserver_name']</code></td>
    <td>Web server server name</td>
    <td><code>webserver1</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['webserver_port']</code></td>
    <td>IBM HTTP Server Listener Port that will receive requests on. Use for creating the web server definition</td>
    <td><code>80</code></td>
  </tr>
  <tr>
    <td><code>node['was']['webserver']['ihs_server']['webserver_type']</code></td>
    <td>HTTP Server vendor.  Example IHS</td>
    <td><code>IHS</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['clusters']['cluster01']['cluster_name']</code></td>
    <td>Name of the cluster that will be created</td>
    <td><code>cluster01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['clusters']['cluster01']['cluster_servers']['cluster_server01']['server_name']</code></td>
    <td>Name of the cluster member that will created on each of the nodes</td>
    <td><code>server1</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['clusters']['cluster01']['session_rep']</code></td>
    <td>was wsadmin clusters cluster01 session_rep</td>
    <td><code>true </code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['dmgr']['jvmproperty']['node_name']</code></td>
    <td>Node for the deployment manager that will be updated</td>
    <td><code>{SHORTHOSTNAME}CellManager01</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['dmgr']['jvmproperty']['profile_path']</code></td>
    <td>Directoy where the deployment manager profile resides</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['dmgr']['jvmproperty']['property_value_initial']</code></td>
    <td>Minimum JVM heap size</td>
    <td><code>256</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['dmgr']['jvmproperty']['property_value_maximum']</code></td>
    <td>Maximum JVM heap size</td>
    <td><code>512</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['dmgr']['jvmproperty']['server_name']</code></td>
    <td>Name of server that will be updated for JVM heap size</td>
    <td><code>dmgr</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['nodeagent']['jvmproperty']['node_name']</code></td>
    <td>Node for the node agent that will be updated</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['nodeagent']['jvmproperty']['profile_path']</code></td>
    <td>Node Agent directory where the profile resides</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['nodeagent']['jvmproperty']['property_value_initial']</code></td>
    <td>Minimum JVM heap size</td>
    <td><code>256</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['nodeagent']['jvmproperty']['property_value_maximum']</code></td>
    <td>Maximum JVM heap size</td>
    <td><code>512</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['nodeagent']['jvmproperty']['server_name']</code></td>
    <td>Name of server that will be updated for JVM heap size</td>
    <td><code>nodeagent</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['standalone']['jvmproperty']['node_name']</code></td>
    <td>Node for the application server that will be updated</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['standalone']['jvmproperty']['profile_path']</code></td>
    <td>Directoy where the application server profile resides</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['standalone']['jvmproperty']['property_value_initial']</code></td>
    <td>Minimum JVM heap size</td>
    <td><code>256</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['standalone']['jvmproperty']['property_value_maximum']</code></td>
    <td>Maximum JVM heap size</td>
    <td><code>512</code></td>
  </tr>
  <tr>
    <td><code>node['was']['wsadmin']['standalone']['jvmproperty']['server_name']</code></td>
    <td>Name of server that will be updated for JVM heap size</td>
    <td><code></code></td>
  </tr>
</table>

Recipes
-------

### was::cleanup.rb


Cleanup Post WebSphere Install


### was::configure_dmgr.rb


Configure Deployment Manager JVM min and max HeapSize.


### was::configure_nodeagent.rb


Configure Node agent JVM min and max HeapSize settings


### was::configure_standalone.rb


Configure Websphere standalone server JVM min and max HeapSize.


### was::create_cluster.rb


Creates a WebSphere cluster for a given cell.  There is no retry logic if system management throws an exception.


### was::create_clustermember.rb


Create Websphere cluster members/servers


### was::create_dmgr.rb


Creates WebSphere Deployment Manager profile and starts the deployment manager.


### was::create_job_manager.rb


Create WebSphere Job Manager profile and starts the job manager.


### was::create_managed.rb


Create node agent, manage node profile, start the node agent


### was::create_standalone.rb


Create Websphere standalone server profile and starts the server.


### was::gather_evidence.rb


Gather evidence that installation was successful


### was::install.rb


Installs WebSphere Application Server V8.5.5 or V9


### was::prereq.rb


This recipe will add to the environment the necessary Pre-Requisites to be added prior ro WebSphere Instalation, this will include
Adding users, Packages, Kernel Configuration


### was::prereq_check.rb


This recipe will check the environment prior to installing software.


### was::start_clustermember.rb


Start the Websphere cluster members/application servers


### was::unmanaged_webserver.rb


Creates a IBM HTTP webserver server defintion as an unmanaged node.



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2016, 2017

