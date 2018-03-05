# Template - IBM WebSphere Network Deployment V9 cell with IBM HTTP Server
Template Version - 1.0

## Description

This template deploys a WebSphere Application Server Network Deployment V9 cell with an integrated IBM HTTP Server.<br>

## Features

### Clouds

 VMware<br>
<br>
### Template Version

1.0<br>
<br>
### Operating Systems Supported

Red Hat Enterprise Linux 7<br>
Red Hat Enterprise Linux 6<br>
Ubuntu 16.04 LTS<br>
Ubuntu 14.04 LTS<br>
<br>
### Topology

Virtual Machine 1: WebSphere Deployment Manager<br>
Virtual Machine 2: WebSphere Custom Node, one cluster member<br>
Virtual Machine 3: WebSphere Custom Node, one cluster member<br>
Virtual Machine 4: IBM HTTP Server and web server plug-in for WAS configured<br>
<br>
### Software Deployed

IBM WebSphere Application Server Network Deployment V9<br>
IBM HTTP Server for WebSphere Application Server V9<br>
Web Server Plug-ins for IBM WebSphere Application Server V9<br>
IBM SDK, Java Technology Edition 8<br>
<br>
### Default Virtual Machine Settings

 vCPU 2, Memory (GB) 4<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. Detailed system requirements for WAS ND 9 - <a href=\"https://www.ibm.com/software/reports/compatibility/clarity/index.html\" target=\"_blank\">https://www.ibm.com/software/reports/compatibility/clarity/index.html</a><br>
3. IBM Knowledge Center for WAS ND 9 - <a href=\"https://www.ibm.com/support/knowledgecenter/en/SSAW57_9.0.0\" target=\"_blank\">https://www.ibm.com/support/knowledgecenter/en/SSAW57_9.0.0</a><br>
4. IBM Support Portal - <a href=\"https://www.ibm.com/support/home/\" target=\"_blank\">https://www.ibm.com/support/home/</a><br>
<br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

VMware vSphere

### Software Deployed

- IBM WebSphere 
- IBM HTTP Server 

### Major Versions

- IBM WebSphere  8.5.5
- IBM WebSphere  9.0.0
- IBM HTTP Server  8.5.5
- IBM HTTP Server  9.0.0


### Minor Versions

- IBM WebSphere  8.5.5.12
- IBM WebSphere  9.0.0.4
- IBM HTTP Server  8.5.5.12
- IBM HTTP Server  9.0.0.4


*Note, these represent base versions only, explicit fixpacks may also be added.*

### Platforms Supported

The following Operating Systems are supported for software defined in this template.

- RHEL 6.x
- RHEL 7.x
- Ubuntu 14.x
- Ubuntu 16.x
- RHEL 6.x
- RHEL 7.x
- Ubuntu 14.x
- Ubuntu 16.x


### Nodes Description

The following table describes the nodes and relevant software component deployed on each node.

<table>
  <tr>
    <th>Node Name</th>
    <th>Component</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>WASDMGRNode01</code></td>
    <td>was_create_dmgr</code></td>
    <td>Create and configure the WebSphere Application Server Deployment manager profile</code></td>
  </tr>
  <tr>
    <td>WASDMGRNode01</code></td>
    <td>was_v9_install</code></td>
    <td>Install WebSphere V9.0.0.x with Java 8 SDK</code></td>
  </tr>
  <tr>
    <td>WASDMGRNode01</code></td>
    <td>was_create_webserver</code></td>
    <td>was_create_webserver</code></td>
  </tr>
  <tr>
    <td>WASNode02</code></td>
    <td>was_v9_install</code></td>
    <td>Install WebSphere V9.0.0.x with Java 8 SDK</code></td>
  </tr>
  <tr>
    <td>WASNode02</code></td>
    <td>was_create_nodeagent</code></td>
    <td>WAS-Create-NODE</code></td>
  </tr>
  <tr>
    <td>WASNode02</code></td>
    <td>was_create_clusters_and_members</code></td>
    <td>was_create_clusters_and_members</code></td>
  </tr>
  <tr>
    <td>IHSNode01</code></td>
    <td>ihs-wasmode-nonadmin</code></td>
    <td>IHS frontend for WAS, nonAdmin install mode</code></td>
  </tr>
  <tr>
    <td>WASNode01</code></td>
    <td>was_create_clusters_and_members</code></td>
    <td>was_create_clusters_and_members</code></td>
  </tr>
  <tr>
    <td>WASNode01</code></td>
    <td>was_create_nodeagent</code></td>
    <td>WAS-Create-NODE</code></td>
  </tr>
  <tr>
    <td>WASNode01</code></td>
    <td>was_v9_install</code></td>
    <td>Install WebSphere V9.0.0.x with Java 8 SDK</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

### IBM WebSphere 
<table>
  <tr>
    <td>Internal Firewall</td>
    <td>off</td>
  </tr>
  <tr>
    <td>Min Disk</td>
    <td>20GB</td>
  </tr>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
  <tr>
    <td>Remote Root Access</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>Min Memory</td>
    <td>1024</td>
  </tr>
</table>

### IBM HTTP Server 
<table>
  <tr>
    <td>Internal Firewall</td>
    <td>off</td>
  </tr>
  <tr>
    <td>Min Disk</td>
    <td>20GB</td>
  </tr>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
  <tr>
    <td>Remote Root Access</td>
    <td>yes</td>
  </tr>
  <tr>
    <td>Min Memory</td>
    <td>1024</td>
  </tr>
</table>



## Disk Requirements

The following lists on a per-product basis the minimal reccomended disk required for each product installed.

### IBM WebSphere 
<table>
  <tr>
    <td>/opt/IBM/WebSphere/AppServer</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/tmp/ibm_cloud</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/var</td>
    <td>512</td>
  </tr>
  <tr>
    <td>/tmp</td>
    <td>2048</td>
  </tr>
</table>

### IBM HTTP Server 
<table>
  <tr>
    <td>/var</td>
    <td>512</td>
  </tr>
  <tr>
    <td>/tmp/ibm_cloud</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/tmp</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/opt/IBM/IHS</td>
    <td>2048</td>
  </tr>
</table>



## Software Repository Libraries

The following standard operating system libraries are required in the relevant Operating System library for each Operating System.

### IBM WebSphere 
<table>
  <tr>
    <td>debian</td>
    <td>x86_64</td>
    <td>libxtst6, libgtk2.0-bin, libxft2</td>
  </tr>
  <tr>
    <td>redhat</td>
    <td>x86_64</td>
    <td>compat-libstdc++-33, compat-db, ksh, gtk2, gtk2-engines, pam, rpm-build, elfutils, elfutils-libs, libXft, glibc, libgcc, nss-softokn-freebl, libXp, libXmu, libXtst, openssl, compat-libstdc++-296</td>
  </tr>
</table>

### IBM HTTP Server 
<table>
  <tr>
    <td>debian</td>
    <td>x86_64</td>
    <td>curl, iproute2</td>
  </tr>
  <tr>
    <td>redhat</td>
    <td>x86_64</td>
    <td>curl, iproute</td>
  </tr>
</table>



## Network Connectivity and Security Groups

Network connectivity is required from the deployed nodes to standard infrastructure. The following is a description of the network Ports required on each node based on the software deployed on that node.

### IBM WebSphere 
<table>
  <tr>
    <td>CELL DISCOVERY ADDRESS Port</td>
    <td>7277</td>
  </tr>
  <tr>
    <td>DCS UNICASTADDRESS Port</td>
    <td>9352</td>
  </tr>
  <tr>
    <td>DataPowerMgr inbound secure Port</td>
    <td>5555</td>
  </tr>
  <tr>
    <td>OVERLAY TCP LISTENER ADDRESS Port</td>
    <td>11006</td>
  </tr>
  <tr>
    <td>SAS SSL SERVERAUTH LISTENER ADDRESS Port</td>
    <td>9401</td>
  </tr>
  <tr>
    <td>CSIV2 SSL MUTUALAUTH LISTENER ADDRESS Port</td>
    <td>9402</td>
  </tr>
  <tr>
    <td>CSIV2 SSL SERVERAUTH LISTENER ADDRESS Port</td>
    <td>9403</td>
  </tr>
  <tr>
    <td>XDAGENT PORT</td>
    <td>7060</td>
  </tr>
  <tr>
    <td>SOAP CONNECTOR ADDRESS Port</td>
    <td>8879</td>
  </tr>
  <tr>
    <td>WC adminhost Port</td>
    <td>9060</td>
  </tr>
  <tr>
    <td>IPC CONNECTOR ADDRESS Port</td>
    <td>9632</td>
  </tr>
  <tr>
    <td>STATUS LISTENER ADDRESS Port</td>
    <td>9420</td>
  </tr>
  <tr>
    <td>BOOTSTRAP ADDRESS Port</td>
    <td>9809</td>
  </tr>
  <tr>
    <td>ORB LISTENER ADDRESS Port</td>
    <td>9100</td>
  </tr>
  <tr>
    <td>OVERLAY UDP LISTENER ADDRESS Port</td>
    <td>11005</td>
  </tr>
  <tr>
    <td>WC adminhost secure Port</td>
    <td>9043</td>
  </tr>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
</table>

### IBM HTTP Server 
<table>
  <tr>
    <td>Admin Port</td>
    <td>8008</td>
  </tr>
  <tr>
    <td>Http Port</td>
    <td>80</td>
  </tr>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
  <tr>
    <td>Https Port</td>
    <td>443</td>
  </tr>
</table>



# Software Repository Requirements

The following files are neccessary on the Software Repository to successfully install this product. Please refer to the document on managing software repositories for the correct method to load  and manage files on the Software Repository.


## IBM WebSphere 

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>8.5.5</td>
    <td>X86_64</td>
    <td>IM Repository File</td>
    <td><br>com.ibm.websphere.IHS.v85_8.5.5011.20161206_1434</br><br>com.ibm.websphere.ND.v85_8.5.5011.20161206_1434</br><br>com.ibm.websphere.PLG.v85_8.5.5011.20161206_1434</br><br>com.ibm.websphere.WCT.v85_8.5.5011.20161206_1434</br></td>
  </tr>
  <tr>
    <td>9.0.0</td>
    <td>X86_64</td>
    <td>IM Repository File</td>
    <td><br>com.ibm.websphere.BASE.v90_9.0.4.20170523_1327</br><br>com.ibm.websphere.IHS.v90_9.0.4.20170523_1327</br><br>com.ibm.websphere.ND.v90_9.0.4.20170523_1327</br><br>com.ibm.websphere.PLG.v90_9.0.4.20170523_1327</br><br>com.ibm.websphere.WCT.v90_9.0.4.20170523_1327</br></td>
  </tr>
</table>

## IBM HTTP Server 

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>8.5.5</td>
    <td>X86_64</td>
    <td>IM Repository File</td>
    <td><br>com.ibm.websphere.IHS.v85_8.5.5012.20170627_1018</br><br>com.ibm.websphere.PLG.v85_8.5.5012.20170627_1018</br></td>
  </tr>
  <tr>
    <td>9.0.0</td>
    <td>X86_64</td>
    <td>IM Repository File</td>
    <td><br>com.ibm.websphere.IHS.v90_9.0.4.20170523_1327</br><br>com.ibm.websphere.PLG.v90_9.0.4.20170523_1327</br></td>
  </tr>
</table>


# Cloud Specific Requirements

The following is required prior to deploying the template on the target cloud. These details will either be required by the deployer or injected by the platform at runtime.

<table>
  <tr>
    <th>Terraform Provider Variable</th>
    <th>Terraform Provider Variable Description.</th>
  </tr>
  <tr>
    <td>user</th>
    <td>The user name for vSphere API operations.</th>
  </tr>
  <tr>
    <td>password</code></td>
    <td>The user password for vSphere API operations.</td>
  </tr>
  <tr>
    <td>vsphere_server</code></td>
    <td>The vSphere Server name for vSphere API operations.</td>
  </tr>
  <tr>
    <td>allow_unverified_ssl</code></td>
    <td>Set True, VMware vSphere client will permit unverifiable SSL certificates.</td>
  </tr>
</table>

These variables are typically defined when creating a Cloud Connection.

