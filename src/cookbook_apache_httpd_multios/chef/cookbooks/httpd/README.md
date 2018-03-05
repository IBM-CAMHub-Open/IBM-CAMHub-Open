Httpd Cookbook
==============

## DESCRIPTION
The Apache HTTP cookbook provides the necessary resources to install and manage Apache HTTP Server
## Platforms Support
* RHEL 6.x
* RHEL 7.x
* Ubuntu Server 14.04 or greater

## Versions
Apache HTTP Server 2.4

## Use Cases
* Single installation with no configuration.
* Single installation with SSL and Proxy configuration

## Platform Pre-Requisites
* Linux YUM Repository - An onsite linux YUM Repsoitory is required.



Requirements
------------

### Platform:

*No platforms defined*

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
    <td><code>node['httpd']['conf_file_mode']</code></td>
    <td>OS Permisssions of confguration files</td>
    <td><code>0640</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['custom_log']</code></td>
    <td>Name of the custom log, for the standard virtual host.</td>
    <td><code>access_log</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['custom_log_format']</code></td>
    <td>Directory of log to be configured in HTTP server</td>
    <td><code>combined</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['data_dir_mode']</code></td>
    <td>OS Permisssions of data folders</td>
    <td><code>0750</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['directory_index']</code></td>
    <td>Enable or Disable directory listing</td>
    <td><code>index.html info.php</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['document_root']</code></td>
    <td>File System Location of the Document Root</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['enable_MMAP']</code></td>
    <td>HTTP Server enable_MMAP</td>
    <td><code>off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['enable_send_file']</code></td>
    <td>HTTP Server enable_send_file</td>
    <td><code>off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['error_log']</code></td>
    <td>Name of the error log, for the standard virtual host.</td>
    <td><code>error_log</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['hostname_lookups']</code></td>
    <td>HTTP Server hostname_lookups</td>
    <td><code>Off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['httpd_home']</code></td>
    <td>Directory of the HTTP Server Process.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['install_dir']</code></td>
    <td>Directory where  HTTP Server will be installed</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['keep_alive']</code></td>
    <td>HTTP Server TCP Keep alive</td>
    <td><code>Off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['keep_alive_timeout']</code></td>
    <td>HTTP Server keep_alive_timeout</td>
    <td><code>15</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['listen']</code></td>
    <td>Listening port to be configured in HTTP server</td>
    <td><code>80</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['log_dir']</code></td>
    <td>Directory where HTTP Server logs will be sent</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['log_level']</code></td>
    <td>Log levels of the http process</td>
    <td><code>warn</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['max_keep_alive_requests']</code></td>
    <td>HTTP Server max_keep_alive_requests</td>
    <td><code>100</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['daemon']['comment']</code></td>
    <td>HTTP Server daemon comment</td>
    <td><code>HTTP Server daemon user</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['daemon']['gid']</code></td>
    <td>HTTP Server daemon gid</td>
    <td><code>apache</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['daemon']['home']</code></td>
    <td>HTTP Server daemon home</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['daemon']['ldap_user']</code></td>
    <td>HTTP Server daemon ldap_user</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['daemon']['name']</code></td>
    <td>HTTP Server daemon name</td>
    <td><code>apache</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['daemon']['shell']</code></td>
    <td>HTTP Server daemon shell</td>
    <td><code>/sbin/nologin</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['web_content_owner']['comment']</code></td>
    <td>Comment, describing the User purpose</td>
    <td><code>httpd daemon user</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['web_content_owner']['gid']</code></td>
    <td>Group ID of web content owner to be configured in HTTP server</td>
    <td><code>apache</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['web_content_owner']['home']</code></td>
    <td>Home directory of web content owner to be configured in HTTP server</td>
    <td><code>/home/webmaster</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['web_content_owner']['ldap_user']</code></td>
    <td>Use LDAP to authenticate Web Content Owner account on Linux HTTP server as well as web site logins</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['web_content_owner']['name']</code></td>
    <td>User ID of web content owner to be configured in HTTP server</td>
    <td><code>webmaster</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['os_users']['web_content_owner']['shell']</code></td>
    <td>Default shell configured on Linux server</td>
    <td><code>/bin/bash</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['php_mod_enabled']</code></td>
    <td>Enable PHP in Apache on Linux by Loading the Module</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['prefork_max_clients']</code></td>
    <td>HTTP Server prefork_max_clients</td>
    <td><code>256</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['prefork_max_requests_per_child']</code></td>
    <td>HTTP Server prefork_max_requests_per_child</td>
    <td><code>4000</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['prefork_max_spare_servers']</code></td>
    <td>HTTP Server prefork_max_spare_servers</td>
    <td><code>20</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['prefork_min_spare_servers']</code></td>
    <td>HTTP Server prefork_min_spare_servers</td>
    <td><code>5</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['prefork_server_limit']</code></td>
    <td>HTTP Server prefork_server_limit</td>
    <td><code>256</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['prefork_start_servers']</code></td>
    <td>HTTP Server prefork_start_servers</td>
    <td><code>8</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['proxy']['ProxyPreserveHost']</code></td>
    <td>Instruct the reverse proxy to preserve original host header from the client browser</td>
    <td><code>On</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['proxy']['rules']['ProxyPass']['path']</code></td>
    <td>HTTP Server ProxyPass path</td>
    <td><code>/sw/</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['proxy']['rules']['ProxyPass']['url']</code></td>
    <td>HTTP Server ProxyPass url</td>
    <td><code>http://localhost</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['proxy']['rules']['ProxyPassReverse']['path']</code></td>
    <td>HTTP Server ProxyPassReverse path</td>
    <td><code>/sw/</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['proxy']['rules']['ProxyPassReverse']['url']</code></td>
    <td>HTTP Server ProxyPassReverse url</td>
    <td><code>http://localhost</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['server_admin']</code></td>
    <td>Email Address of the Webmaster</td>
    <td><code>webmaster@localhost</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['server_name']</code></td>
    <td>The Name of the HTTP Server, normally the FQDN of server.</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['server_root']</code></td>
    <td>httpd server_root</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['service_name']</code></td>
    <td>Name the HTTP Server process will run as</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['https_port']</code></td>
    <td>Secure Port for the HTTP Server</td>
    <td><code>443</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['install_mod_ssl']</code></td>
    <td>Enable SSL within HTTP Server Configuration</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['sslcompression']</code></td>
    <td>Enable SSL compression within HTTP Server Configuration</td>
    <td><code>Off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['sslproxycacertificatefile']</code></td>
    <td>SSL proxy Certificate file name</td>
    <td><code>PleaseProvide</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['sslproxycacertificatepath']</code></td>
    <td>SSL proxy Certificate file path</td>
    <td><code>PleaseProvide</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['sslproxycarevocationcheck']</code></td>
    <td>SSL proxy CA revocation check</td>
    <td><code>PleaseProvide</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['ssl']['sslproxycarevocationfile']</code></td>
    <td>SSL proxy CA revocation file</td>
    <td><code>PleaseProvide</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['timeout']</code></td>
    <td>httpd timeout</td>
    <td><code>off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['use_canonical_name']</code></td>
    <td>Should the HTTP Server use the canonical hostname</td>
    <td><code>Off</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['version']</code></td>
    <td>Version of HTTP Server to be installed.</td>
    <td><code>2.4</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['vhosts_enabled']</code></td>
    <td>Allow to configure virtual hosts to run multiple websites on the same HTTP server</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['custom_log']</code></td>
    <td>Location of the HTTP Server Custom Log</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['custom_log_format']</code></td>
    <td>Log Format of the Custom Log</td>
    <td><code>combined</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['document_root']</code></td>
    <td>Location of the Default Docuement Root</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['error_log']</code></td>
    <td>Location of the HTTP Server Error Log</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['global_ssl_config']</code></td>
    <td>Use default global configuration for HTTP communication in HTTP server</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['log_dir']</code></td>
    <td></td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['proxy_enabled']</code></td>
    <td>Enable proxy usage for virtual host for HTTP Communication in HTTP server</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['server_admin']</code></td>
    <td>Email address of the Server Admin</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['server_name']</code></td>
    <td>Vhost server name for directing requests</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['ssl_enabled']</code></td>
    <td>Enable SSL for virtual host for HTTPS communication in HTTP server</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['vhost_listen']</code></td>
    <td>Listening port configured in virtual host for HTTP communication in HTTP server</td>
    <td><code>80</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_http_server']['vhost_type']</code></td>
    <td>Allow to configure virtual hosts to run multiple websites on the same HTTP server</td>
    <td><code>name_based</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['custom_log']</code></td>
    <td>HTTPS Virtual host custom log dir</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['custom_log_format']</code></td>
    <td>HTTPS Virtual host custom log format</td>
    <td><code>combined</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['document_root']</code></td>
    <td>HTTPS virtual host document root</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['error_log']</code></td>
    <td>HTTPS Virtual host error log dir</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['global_ssl_config']</code></td>
    <td>Use default global configuration for HTTPS communication in HTTP server</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['log_dir']</code></td>
    <td>HTTPS virtual host log dir</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['proxy_enabled']</code></td>
    <td>Enable proxy configuration</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['server_admin']</code></td>
    <td>HTTPS Virtual host server admin</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['server_name']</code></td>
    <td>HTTPS Virtual host server name for directing requests</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['ssl_enabled']</code></td>
    <td>HTTPS - Enable SSL for virtual host for HTTP communication in HTTP server</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['vhost_listen']</code></td>
    <td>Listening port configured in virtual host for HTTPS communication in HTTP server</td>
    <td><code>443</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['virtualhosts']['default_https_server']['vhost_type']</code></td>
    <td>Specify type of virtual host for HTTPS communication in HTTPS server</td>
    <td><code>name_based</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['worker_max_clients']</code></td>
    <td>HTTP Server worker_max_clients</td>
    <td><code>25</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['worker_max_requests_per_child']</code></td>
    <td>HTTP Server worker_max_requests_per_child</td>
    <td><code>0</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['worker_max_spare_servers']</code></td>
    <td>HTTP Server worker_max_spare_servers</td>
    <td><code>25</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['worker_min_spare_servers']</code></td>
    <td>HTTP Server worker_min_spare_servers</td>
    <td><code>300</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['worker_server_limit']</code></td>
    <td>HTTP Server worker_server_limit</td>
    <td><code>75</code></td>
  </tr>
  <tr>
    <td><code>node['httpd']['worker_start_servers']</code></td>
    <td>HTTP Server worker_start_servers</td>
    <td><code>4</code></td>
  </tr>
</table>

Recipes
-------

### httpd::cleanup.rb


Cleanup recipe (cleanup.rb)
Perform post-install cleanup


### httpd::config_httpd_conf.rb


Configure httpd server recipe (config_httpd_conf.rb)
Setup the main server configuration file


### httpd::config_ssl.rb


SSL configuration recipe (config_proxy.rb)
Install mod_ssl, create SSL configuration file, create certificates


### httpd::config_vhosts.rb


vhost configuration recipe (config_vhost.rb)
Create vhost configuration file


### httpd::default.rb


Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.


### httpd::gather_evidence.rb


Gather evidence recipe (gather_evidence.rb)
Gather evidence that installation was successful


### httpd::install.rb


Installation recipe (install.rb)
Perform an installation of selected httpd package on the target node.


### httpd::prereq.rb


Prerequisites recipe (prereq.rb)
Perform prerequisite tasks.


### httpd::service.rb


Service control recipe (service.rb)
Enable and start the httpd service



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2016, 2017

