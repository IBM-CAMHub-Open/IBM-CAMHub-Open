Ihs Cookbook
============

## DESCRIPTION

This cookbook installs and configures IBM HTTP Server.

## Platforms Support

* RHEL 6.x
* RHEL 7.x
* Ubuntu Server 14.04 or greater

## Versions

* IBM HTTP Server 9.0
* IBM HTTP Server 8.5.5

## Use Cases

* IHS installation via IM LWRP, admin mode
* IHS installation via IM LWRP, nonAdmin mode

## Platform Pre-Requisites

* Linux YUM Repository - An onsite linux YUM Repsoitory is required.

## IM Package Repository
IM_REPO -> Stored in the ['ibm']['im_repo'] attribute.


Requirements
------------

### Platform:

* Rhel6 (>= 6.5)
* Rhel7
* Ubuntu (>= 14.04)

### Cookbooks:

* ibm_cloud_utils
* im

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['document_root']</code></td>
    <td>IBM HTTP Server Admin Server Docuement Root</td>
    <td><code>/opt/IBM/HTTPServer/docroot</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['enabled']</code></td>
    <td>IBM HTTP Server Admin Server Enable(true/false)</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['password']</code></td>
    <td>IBM HTTP Server Admin Server Password</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['port']</code></td>
    <td>IBM HTTP Server Admin Server Port Number</td>
    <td><code>8008</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['server_name']</code></td>
    <td>IBM HTTP Server Admin Server fully qualified hostname</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['service_name']</code></td>
    <td>IBM HTTP Server Admin Server Service Name</td>
    <td><code>ihsadm</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['admin_server']['username']</code></td>
    <td>IBM HTTP Server Admin Server username</td>
    <td><code>ihsadmin</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['config_os_service']</code></td>
    <td>Specifies whether to configure IBM HTTP Server as a service</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['document_root']</code></td>
    <td>Designated directory for holding web pages in IBM HTTP Server</td>
    <td><code>/opt/IBM/HTTPServer/htdocs</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['features']['bitness']</code></td>
    <td>Indicate whether IBM HTTP Server is 64 bit</td>
    <td><code>64</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['install_dir']</code></td>
    <td>The directory to install IBM HTTP Server</td>
    <td><code>/opt/IBM/HTTPServer</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['install_mode']</code></td>
    <td>The mode of installation for IBM HTTP Server</td>
    <td><code>nonAdmin</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['java']['legacy']</code></td>
    <td>The Java version to be used with IBM HTTP Server version 8.5.5</td>
    <td><code>java8</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['java']['version']</code></td>
    <td>The Java version to be used with IBM HTTP Server</td>
    <td><code>8.0.4.70</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['os_perms']</code></td>
    <td>The operating system permissions on IBM HTTP Server files</td>
    <td><code>755</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['os_users']['ihs']['gid']</code></td>
    <td>The group name for the IBM HTTP Server user</td>
    <td><code>ihsgrp</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['os_users']['ihs']['home']</code></td>
    <td>The IBM HTTP Server user home directory</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['os_users']['ihs']['ldap_user']</code></td>
    <td>Specifies if the IBM HTTP Server user is in LDAP</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['os_users']['ihs']['name']</code></td>
    <td>The username for IBM HTTP Server</td>
    <td><code>ihssrv</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['os_users']['ihs']['shell']</code></td>
    <td>Location of the IBM HTTP Server operating system user shell</td>
    <td><code>/sbin/nologin</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['plugin']['dmgr_tag']</code></td>
    <td>The tag string identifying the DMGR host</td>
    <td><code>DMGR</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['plugin']['enabled']</code></td>
    <td>IBM HTTP Server Plugin Enabled</td>
    <td><code>remote</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['plugin']['install_dir']</code></td>
    <td>IBM HTTP Server Plugin Installation Direcrtory</td>
    <td><code>/opt/IBM/WebSphere/Plugins</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['plugin']['plugin_install_type']</code></td>
    <td>IBM HTTP Server Plugin Installation Type</td>
    <td><code>remote</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['plugin']['was_hostname']</code></td>
    <td>IBM HTTP Server plugin DMGR hostname</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['plugin']['was_webserver_name']</code></td>
    <td>IBM HTTP Server Plugin Hostname, normally the FQDN</td>
    <td><code>webserver1</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['port']</code></td>
    <td>The IBM HTTP Server default port for HTTP requests</td>
    <td><code>80</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['server_admin']</code></td>
    <td>The email address of the server admin for IBM HTTP Server</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['server_name']</code></td>
    <td>Fully qualified name of the server</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['service_name']</code></td>
    <td>IBM HTTP Server service name</td>
    <td><code>ihssrv</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['ssl']['cert_label']</code></td>
    <td>IBM HTTP Server keystore label name</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['ssl']['enabled']</code></td>
    <td>IBM HTTP Server Enable SSL Port</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['ssl']['keystore']</code></td>
    <td>IBM HTTP Server Keystore Location</td>
    <td><code>/opt/IBM/HTTPServer/conf/key.kdb</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['ssl']['keystore_password']</code></td>
    <td>IBM HTTP Server keystore password</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['ssl']['port']</code></td>
    <td>IBM HTTP Server SSL Port Number</td>
    <td><code>443</code></td>
  </tr>
  <tr>
    <td><code>node['ihs']['version']</code></td>
    <td>The version of IBM HTTP Server to install</td>
    <td><code>9.0.0.4</code></td>
  </tr>
</table>

Recipes
-------

### ihs::cleanup.rb


Cleanup recipe (cleanup.rb)
Perform post-install cleanup


### ihs::config_admin_conf.rb


Configure admin server recipe (config_admin_conf.rb)
Create admin.conf and service script for the admin server


### ihs::config_httpd_conf.rb


Main server configuration recipe (config_httpd_conf.rb)
Configure main server and service file


### ihs::config_ssl_selfsigned.rb


SSL configuration recipe (config_ssl_selfsigned.rb)
Configure a SSL vhost and associated self-signed certificates


### ihs::config_wasplugin.rb


WAS plugin configuration recipe (config_wasplugin.rb)
Configure the WAS plugin


### ihs::default.rb


Default recipe (default.rb)
Perform minimal product installation


### ihs::gather_evidence.rb


Gather evidence recipe (gather_evidence.rb)
Gather evidence that installation was successful


### ihs::install.rb


Installation recipe (install.rb)
Perform installation of the main asset


### ihs::prereq.rb


Prerequisites recipe (prereq.rb)
Perform prerequisite actions


### ihs::prereq_check.rb


Prerequisites recipe (prereq_check.rb)
Verify required prerequisites, validate input


### ihs::service_admin.rb


Configure admin server recipe (service_admin.rb)
Configure and manage admin server service


### ihs::service_httpd.rb


Configure web server recipe (service_httpd.rb)
Configure and manage web service



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2012, 2017

