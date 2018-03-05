Im Cookbook
===========

## DESCRIPTION
This cookbook provides a lightweight resource/provider (LWRP) that can be used to install IBM Installation Manager (IM) and IBM products using the IBM Installation Manager.
## Versions
* IBM IM V1.8.5, V1.8.6
## Use Cases
* IM installation
* IM upgrade to the latest IM version included in IM repository.
* Installation of any package included in IM repository (IHS - com.ibm.websphere.IHS.v85_8.5.5009.20160225_0435.jar ; WAS ND - com.ibm.websphere.ND.v85_8.5.5009.20160225_0435.jar; etc.)
## Platform Pre-Requisites
* Linux YUM Repository - An onsite linux YUM Repsoitory is required.
## Software Repository
SW_REPO_ROOT -> Stored in the ['ibm']['sw_repo'] attribute.
## IM Package Repository
IM_REPO -> Stored in the ['ibm']['im_repo'] attribute.
Relative to the software repository, the installation files must be stored in the following location.
* BASE FILES   -> /im/v1x/base/
The following is a description of files needed on the REPO Server depending on version and architecture.
```python
case node['platform_family']
when 'rhel' || 'debian'
  case node['kernel']['machine']
  when 'x86_64'
    default['im']['arch'] = 'x86_64'
    # <> Installation Manager Version 1.8.5, 1.8.6
    force_override['im']['archive_names'] =
    { '1.8.5' => { 'filename' => 'agent.installer.linux.gtk.' + node['im']['arch'] + '_1.8.5000.20160506_1125.zip',
                   'sha256' => '76190adf69f6e4a6a8d7432983f5aebe68d56545a3a13b3ecd6b25c12d433b04' },
      '1.8.6' => { 'filename' => 'agent.installer.linux.gtk.' + node['im']['arch'] + '_1.8.6000.20161118_1611.zip',
                   'sha256' => 'b253a06bccace5934b108632487182f6a6f659082fea69372242b9865a64e4f3' } }
  end
```
# Resources
* [im_install] - Installs IBM Installation Manager. Installs an IBM product by executing the IBM Installation manager.
## im_install
Installs IBM Installation Manager. Installs an IBM product by executing the IBM Installation manager.
### Actions
- install_im: Installs IBM Installation Manager.
- upgrade_im: Installs the latest fixpack available in IM Repository for IBM Installation Manager.
- install:  Default action. Installs an IBM product by executing the IBM Installation manager.
### Attribute Parameters
<table>
  <tr>
    <td>LWRP Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>repositories</code></td>
    <td>The IM repository.</td>
    <td><code>node['ibm']['im_repo']</code></td>
  </tr>
  <tr>
    <td><code>secure_repo</code></td>
    <td>If the IM repo is public this should be set to "false"</td>
    <td><code>'true'</code></td>
  </tr>
  <tr>
    <td><code>im_repo_user</code></td>
    <td>User used to access IM repo if this repo is secured and authentication is required This is not required if IM repo is not secured.</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>im_repo_nonsecureMode</code></td>
    <td>If the IM repo is secured but it uses a self signed SSL certificate this should be set to "true"</td>
    <td><code>'false'</code></td>
  </tr>
  <tr>
    <td><code>repo_nonsecureMode</code></td>
    <td>If the Software repo is secured but it uses a self signed SSL certificate this should be set to "true"</td>
    <td><code>'false'</code></td>
  </tr>
  <tr>
    <td><code>response_file</code></td>
    <td>The response file for the IBM Installation Manager.</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>install_dir</code></td>
    <td>Installation directory for the product that is installed using this LWRP</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>offering_id</code></td>
    <td>Offering ID. You can find the value in your IMRepo. Each Product has a different ID (e.g. com.ibm.websphere.IHS.v85, com.ibm.websphere.PLG.v85, com.ibm.websphere.ND.v85 )</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>java_offering_id</code></td>
    <td>Java offering ID. You can find the value in your IMRepo. Each Product has a different ID</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>offering_version</code></td>
    <td>Offering version. You can find the value in your IMRepo. Each Product has a different offering version</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>java_offering_version</code></td>
    <td>Java offering version. You can find the value in your IMRepo. Each Product has a different offering version</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>profile_id</code></td>
    <td>Profile ID. This is a short description of the product</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>feature_list</code></td>
    <td>Feature list for the product. This is a list of components that should be installed for a specific product</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>java_feature_list</code></td>
    <td>Java feature list for the product. This is a list of components that should be installed for a specific product</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>install_java</code></td>
    <td>Flag for Java Installation. Supports "true" or "false"</td>
    <td><code>'false'</code></td>
  </tr>
  <tr>
    <td><code>im_shared_dir</code></td>
    <td>Directory where installation artifacts are stored.</td>
    <td><code>'/opt/IBM/IMShared'</code></td>
  </tr>
  <tr>
    <td><code>user</code></td>
    <td>User used to install IM and that should be used to install a product. It should be created before calling im_install LWRP</td>
    <td><code>'root'</code></td>
  </tr>
  <tr>
    <td><code>group</code></td>
    <td>Group used to install IM and that should be used to install a product. It should be created before calling im_install LWRP</td>
    <td><code>'root'</code></td>
  </tr>
  <tr>
    <td><code>im_install_mode</code></td>
    <td>Installation mode used to install IM and that should be used to install a product. Supports "admin", "nonAdmin" or "group"</td>
    <td><code>'admin'</code></td>
  </tr>
  <tr>
    <td><code>im_install_dir</code></td>
    <td>Directory where im will be installed</td>
    <td><code>'/opt/IBM/InstallationManager'</code></td>
  </tr>
  <tr>
    <td><code>log_dir</code></td>
    <td>An absolute path to a directory that will be used to hold any persistent files created as part of the automation</td>
    <td><code>'node['ibm']['evidence_path']'</code></td>
  </tr>
  <tr>
    <td><code>version</code></td>
    <td>Installation Manager Version Number to be installed. Supported versions: 1.8.5, 1.8.6</td>
    <td><code>node['im']['version']</code></td>
  </tr>
  <tr>
    <td><code>im_data_dir</code></td>
    <td>Installation Manager Data Directory</td>
    <td><code>'/var/ibm/InstallationManager'</code></td>
  </tr>
</table>
### examples
Installing IM and IHS from a public IM repository using admin installation mode
```ruby
im_install "com.ibm.websphere.IHS.v85" do
  repositories "http://<hostname>:<port>/<path>"
  install_dir '/opt/IBM/HTTPServer'
  response_file "IHSv85.install.xml"
  offering_id 'com.ibm.websphere.IHS.v85'
  offering_version '8.5.5008.20151112_0939'
  profile_id "IBM HTTP Server for WebSphere Application Server V8.5"
  feature_list "core.feature,arch.64bit"
  im_install_mode 'admin'
  action [:install_im, :upgrade_im, :install]
end
```
Installing a specific version of IM and IHS from a public IM repository using admin installation mode
```ruby
im_install "com.ibm.websphere.IHS.v85" do
  repositories "http://<hostname>:<port>/<path>"
  version '1.8.6'
  install_dir '/opt/IBM/HTTPServer'
  response_file "IHSv85.install.xml"
  offering_id 'com.ibm.websphere.IHS.v85'
  offering_version '8.5.5008.20151112_0939'
  profile_id "IBM HTTP Server for WebSphere Application Server V8.5"
  feature_list "core.feature,arch.64bit"
  im_install_mode 'admin'
  action [:install_im, :upgrade_im, :install]
end
```
Installing IM and IHS from a password protected repository using admin installation mode
```ruby
im_install "com.ibm.websphere.IHS.v85" do
  repositories "https://<hostname>:<port>/<path>"
  im_repo_user '<im repo username>'
  install_dir '/opt/IBM/HTTPServer'
  response_file "IHSv85.install.xml"
  offering_id 'com.ibm.websphere.IHS.v85'
  offering_version '8.5.5008.20151112_0939'
  profile_id "IBM HTTP Server for WebSphere Application Server V8.5"
  feature_list "core.feature,arch.64bit"
  im_install_mode 'admin'
  action [:install_im, :upgrade_im, :install]
end
```
Installing IM and IHS from a password protected repository (both using a self signed certificate) using admin installation mode
```ruby
im_install "com.ibm.websphere.IHS.v85" do
  repositories "https://<hostname>:<port>/<path>"
  im_repo_user '<im repo username>'
  im_repo_nonsecureMode 'true'
  repo_nonsecureMode 'true'
  install_dir '/opt/IBM/HTTPServer'
  response_file "IHSv85.install.xml"
  offering_id 'com.ibm.websphere.IHS.v85'
  offering_version '8.5.5008.20151112_0939'
  profile_id "IBM HTTP Server for WebSphere Application Server V8.5"
  feature_list "core.feature,arch.64bit"
  im_install_mode 'admin'
  action [:install_im, :upgrade_im, :install]
end
```
Installing WASND and Java from a password protected repository (IM repo using a self signed certificate) using nonAdmin installation mode. Assuming that IM is already installed.
```ruby
im_install "com.ibm.websphere.ND.v85" do
  repositories "https://<hostname>:<port>/<path>"
  im_repo_user '<im repo username>'
  im_repo_nonsecureMode 'true'
  install_dir /home/wasadmin/opt/IBM/WebSphere/AppServer
  response_file "WASv85.install.xml"
  offering_id "com.ibm.websphere.ND.v85"
  offering_version '8.5.5008.20151112_0939'
  profile_id "IBM WebSphere Application Server V8.5"
  feature_list "core.feature,ejbdeploy,thinclient,embeddablecontainer,com.ibm.sdk.6_64bit"
  install_java "true"
  java_feature_list "com.ibm.sdk.7"
  java_offering_id "com.ibm.websphere.IBMJAVA.v70"
  java_offering_version "7.0.9030.20160224_1826"
  im_install_mode 'nonAdmin'
  user 'wasadmin'
  group 'wasgroup'
  action [:install]
end
```
Response file template:
```ruby
<?xml version="1.0" encoding="UTF-8"?>
<!-- ##### Copyright ######################################################
# Licensed Materials - Property of IBM (c) Copyright IBM Corp. 2012.
# All Rights Reserved. US Government Users Restricted Rights-Use, duplication
# or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
####################################################################### -->
<agent-input clean="true" temporary="true">
<server>
<repository location='<%= @REPO_LOCATION %>' />
</server>
<install modify='false'>
<offering id='<%= @OFFERING_ID %>' version='<%= @OFFERING_VERSION %>' profile='<%= @PROFILE_ID %>' features='<%= @FEATURE_LIST %>' installFixes='none'/>
<% if @INSTALL_JAVA == "true" %>
<offering id='<%= @JAVA_OFFERING_ID %>' version='<%= @JAVA_OFFERING_VERSION %>' profile='<%= @PROFILE_ID %>' features='<%= @JAVA_FEATURE_LIST %>' installFixes='none'/>
<% end %>
</install>
<profile id='<%= @PROFILE_ID %>' installLocation='<%= @INSTALL_LOCATION %>'>
<data key='eclipseLocation' value='<%= @INSTALL_LOCATION %>'/>
<data key='user.import.profile' value='false'/>
<data key='cic.selector.nl' value='en'/>
<% if @OFFERING_ID.include? "IHS" %>
<data key='user.ihs.httpPort' value='<%= node['ihs']['port'] %>'/>
<data key='user.ihs.allowNonRootSilentInstall' value='true'/>
<% end %>
</profile>
<preference name='com.ibm.cic.common.core.preferences.connectTimeout' value='30'/>
<preference name='com.ibm.cic.common.core.preferences.readTimeout' value='45'/>
<preference name='com.ibm.cic.common.core.preferences.downloadAutoRetryCount' value='0'/>
<preference name='offering.service.repositories.areUsed' value='false'/>
<preference name='com.ibm.cic.common.core.preferences.ssl.nonsecureMode' value='<%= @IM_REPO_NONSECUREMODE %>'/>
<preference name='com.ibm.cic.common.core.preferences.http.disablePreemptiveAuthentication' value='false'/>
<preference name='http.ntlm.auth.kind' value='NTLM'/>
<preference name='http.ntlm.auth.enableIntegrated.win32' value='true'/>
<preference name='com.ibm.cic.common.core.preferences.keepFetchedFiles' value='false'/>
<preference name='PassportAdvantageIsEnabled' value='false'/> <%# ~password_checker %>
<preference name='com.ibm.cic.common.core.preferences.searchForUpdates' value='false'/>
<preference name='com.ibm.cic.agent.ui.displayInternalVersion' value='false'/>
<preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='<%= @IMSHARED %>'/>
```


Requirements
------------

### Platform:

* Rhel (>= 7.0)
* Ubuntu (>= 14.04)

### Cookbooks:

* ibm_cloud_utils

Attributes
----------

*No attributes defined*

Recipes
-------

### im::cleanup.rb


Cleanup recipe ( cleanup.rb )
This recipe will delete temp directory where installers were copied as they are not required any further.


### im::default.rb


Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.


### im::environment_check.rb


environment_check recipe (environment_check.rb)
This recipe will test that the external environment is ready to have a cookbook installed


### im::fixpack.rb


Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.


### im::gather_evidence.rb


Gather evidence recipe (gather_evidence.rb)
It will create log file mentioning installed application version.


### im::install.rb


Install  recipe (install.rb)
Installation recipe, source the version, unpack the file and install product


### im::prereq.rb


Prerequisites recipe (prereq.rb)
This recipe configures the operating prerequisites for the pattern.



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2016, 2017

