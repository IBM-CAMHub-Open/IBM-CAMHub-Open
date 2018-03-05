# Template - IBM DB2 Enterprise Server Edition V10.5 on a single virtual machine
Template Version - 1.0

## Description

This template deploys a standalone instance of IBM DB2 Enterprise Server Edition V10.5 on a Linux virtual machine.<br>

## Features

### Clouds

 IBM<br>
<br>
### Template Version

1.0<br>
<br>
### Operating Systems Supported

Red Hat Enterprise Linux 7<br>
Red Hat Enterprise Linux 6<br>
Ubuntu 14.04 LTS<br>
<br>
### Topology

1 virtual machine:<br>
  IBM DB2 Enterprise Server Edition - one instance, one database<br>
<br>
### Software Deployed

IBM DB2 Enterprise Server Edition V10.5<br>
<br>
### Default Virtual Machine Settings

 Cores 2, RAM (GB) 4, SAN Disk (GB) 25<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. Detailed system requirements for DB2 V10.5 - <a href=\"https://www.ibm.com/software/reports/compatibility/clarity/index.html\" target=\"_blank\">https://www.ibm.com/software/reports/compatibility/clarity/index.html</a><br>
3. IBM Knowledge Center for DB2 V10.5 - <a href=\"https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0\" target=\"_blank\">https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0</a><br>
4. IBM Support Portal - <a href=\"https://www.ibm.com/support/home/\" target=\"_blank\">https://www.ibm.com/support/home/</a><br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

IBM

### Software Deployed

- IBM DB2 Enterprise Server

### Major Versions

- IBM DB2 Enterprise Server 10.5
- IBM DB2 Enterprise Server 11.1


### Minor Versions

- IBM DB2 Enterprise Server 10.5.0.3
- IBM DB2 Enterprise Server 10.5.0.8
- IBM DB2 Enterprise Server 11.1.0.0


*Note, these represent base versions only, explicit fixpacks may also be added.*

### Platforms Supported

The following Operating Systems are supported for software defined in this template.

- RHEL 6.x
- RHEL 7.x
- Ubuntu 14.0.4


### Nodes Description

The following table describes the nodes and relevant software component deployed on each node.

<table>
  <tr>
    <th>Node Name</th>
    <th>Component</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>DB2Node01</code></td>
    <td>db2_v105_install</code></td>
    <td>DB2 v10.5 role for default installation and configuration</code></td>
  </tr>
  <tr>
    <td>DB2Node01</code></td>
    <td>db2_create_db</code></td>
    <td>Creates a new DB2 instance and database over an existing DB2 installation</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

### IBM DB2 Enterprise Server
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

### IBM DB2 Enterprise Server
<table>
  <tr>
    <td>/tmp/ibm_cloud</td>
    <td>1536</td>
  </tr>
  <tr>
    <td>/opt/ibm/db2</td>
    <td>500</td>
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



## Software Repository Libraries

The following standard operating system libraries are required in the relevant Operating System library for each Operating System.

### IBM DB2 Enterprise Server
<table>
  <tr>
    <td>debian</td>
    <td>x86_64</td>
    <td>cpp, compat-libstdc++-33, gcc, gcc-c++, libaio, libstdc++, kernel-devel, ksh, nfs-utils, openssh, openssh-server, pam, redhat-lsb, sg3_utils</td>
  </tr>
  <tr>
    <td>redhat</td>
    <td>x86_64</td>
    <td>cpp, gcc, ksh, openssh-server, rpm, unzip, binutils, libaio1</td>
  </tr>
</table>



## Network Connectivity and Security Groups

Network connectivity is required from the deployed nodes to standard infrastructure. The following is a description of the network Ports required on each node based on the software deployed on that node.

### IBM DB2 Enterprise Server
<table>
  <tr>
    <td>DB2 Port</td>
    <td>50000</td>
  </tr>
  <tr>
    <td>FCM Port</td>
    <td>60000</td>
  </tr>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
</table>



# Software Repository Requirements

The following files are neccessary on the Software Repository to successfully install this product. Please refer to the document on managing software repositories for the correct method to load  and manage files on the Software Repository.


## IBM DB2 Enterprise Server

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>11</td>
    <td>X86_64</td>
    <td>/db2/v111/base</td>
    <td><br>DB2_Svr_11.0.0.0_Linux_linuxx64.tar.gz</br></td>
  </tr>
  <tr>
    <td>10</td>
    <td>X86_64</td>
    <td>/db2/v105/base</td>
    <td><br>DB2_Svr_10.5.0.0_Linux_linuxx64.tar.gz</br></td>
  </tr>
</table>

### Fixpack
<table>
  <tr>
    <th>Fixpack Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>10.5.0.3</td>
    <td>X86_64</td>
    <td>/db2/v105/maint</td>
    <td><br>DB2_Svr_10.5.0.3_Linux_linuxx64.tar.gz</br></td>
  </tr>
  <tr>
    <td>11.1</td>
    <td>X86_64</td>
    <td>/db2/v111/base</td>
    <td><br>DB2_Svr_11.1.0.0_Linux_linuxx64.tar.gz</br></td>
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
    <td>softlayer_username</td>
    <td>The API Username used to connect to IBM Softlayer</td>
  </tr>
  <tr>
    <td>softlayer_api_key</code></td>
    <td>The Softlayer API Key associated with the API User</td>
  </tr>
  <tr>
    <td>softlayer_endpoint_url</code></td>
    <td>The URL Associated with the Softlayer connection</td>
  </tr>
</table>

These variables are typically defined when creating a Cloud Connection.

