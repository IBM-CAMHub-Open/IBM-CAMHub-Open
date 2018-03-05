# Template - IBM MQ V8 on a single virtual machine
Template Version - 1.0

## Description

Install and configure IBM MQ on a single Linux virtual machine.<br>

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
Ubuntu 14.04 LTS<br>
<br>
### Topology

1 virtual machine:<br>
 IBM MQ instance<br>
<br>
### Software Deployed

IBM MQ V8.0<br>
<br>
### Default Virtual Machine Settings

 vCPU 2, Memory (GB) 4<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. IBM Knowledge Center for IBM MQ V8.0 - <a href=\"https://www.ibm.com/support/knowledgecenter/SSFKSJ_8.0.0/com.ibm.mq.helphome.v80.doc/WelcomePagev8r0.htm\" target=\"_blank\">https://www.ibm.com/support/knowledgecenter/SSFKSJ_8.0.0/com.ibm.mq.helphome.v80.doc/WelcomePagev8r0.htm</a><br>
3. IBM Support Portal - <a href=\"https://www.ibm.com/support/home/\" target=\"_blank\">https://www.ibm.com/support/home/</a><br>
<br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

VMware vSphere

### Software Deployed

- IBM WebSphere MQSeries

### Major Versions

- IBM WebSphere MQSeries 8.0
- IBM WebSphere MQSeries 9.0


### Minor Versions

- IBM WebSphere MQSeries 8.0.04
- IBM WebSphere MQSeries 8.0.05
- IBM WebSphere MQSeries 8.0.06
- IBM WebSphere MQSeries 9.0.0.1


*Note, these represent base versions only, explicit fixpacks may also be added.*

### Platforms Supported

The following Operating Systems are supported for software defined in this template.

- RHEL 6.x (Not for MQ9)
- RHEL 7.x
- Ubuntu 14.0.4
- Ubuntu 16


### Nodes Description

The following table describes the nodes and relevant software component deployed on each node.

<table>
  <tr>
    <th>Node Name</th>
    <th>Component</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>MQNode01</code></td>
    <td>wmq_v8_install</code></td>
    <td>WMQ V8 Install on Linux</code></td>
  </tr>
  <tr>
    <td>MQNode01</code></td>
    <td>wmq_create_qmgrs</code></td>
    <td>WMQ Configure Queue Manager</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

### IBM WebSphere MQSeries
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

### IBM WebSphere MQSeries
<table>
  <tr>
    <td>/opt/mqm</td>
    <td>5GB</td>
  </tr>
  <tr>
    <td>/tmp/ibm_cloud</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/var/mqm</td>
    <td>5GB</td>
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

### IBM WebSphere MQSeries
<table>
  <tr>
    <td>redhat WMQ8.0</td>
    <td>x86_64</td>
    <td>ksh, binutils, gcc, glibc, libgcc, openssl, gtk2, libstdc++.x86_64, libstdc++.i686, redhat-lsb-core</td>
  </tr>
  <tr>
    <td>debian WMQ8.0</td>
    <td>x86_64</td>
    <td>ksh, binutils, gcc, gcc-multilib, openssl, libgtk2.0-0, rpm, lsb-core</td>
  </tr>
  <tr>
    <td>debian WMQ9.0</td>
    <td>x86_64</td>
    <td>ksh, binutils, gcc, gcc-multilib, openssl, libgtk2.0-0, rpm, lsb-core</td>
  </tr>
  <tr>
    <td>redhat WMQ9.0</td>
    <td>x86_64</td>
    <td>ksh, binutils, gcc, glibc, libgcc, openssl, gtk2, libstdc++.x86_64, libstdc++.i686, redhat-lsb-core</td>
  </tr>
</table>



## Network Connectivity and Security Groups

Network connectivity is required from the deployed nodes to standard infrastructure. The following is a description of the network Ports required on each node based on the software deployed on that node.

### IBM WebSphere MQSeries
<table>
  <tr>
    <td>Default QMGR Port</td>
    <td>1414</td>
  </tr>
</table>



# Software Repository Requirements

The following files are neccessary on the Software Repository to successfully install this product. Please refer to the document on managing software repositories for the correct method to load  and manage files on the Software Repository.


## IBM WebSphere MQSeries

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>8.0</td>
    <td>Redhat X86_64</td>
    <td>/wmq/v8.0/base</td>
    <td><br>WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz</br></td>
  </tr>
  <tr>
    <td>8.0</td>
    <td>Debian X86_64</td>
    <td>/wmq/v8.0/base</td>
    <td><br>WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz</br></td>
  </tr>
  <tr>
    <td>9.0</td>
    <td>Redhat X86_64</td>
    <td>/wmq/v9.0/base</td>
    <td><br>IBM_MQ_9.0.0.0_LINUX_X86-64.tar.gz</br></td>
  </tr>
  <tr>
    <td>9.0</td>
    <td>Debian X86_64</td>
    <td>/wmq/v9.0/base</td>
    <td><br>IBM_MQ_9.0.0.0_LINUX_X86-64.tar.gz</br></td>
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
    <td>9.0.X</td>
    <td>Redhat X86_64</td>
    <td>/wmq/v90/maint</td>
    <td><br>9.0.0-IBM-MQ-LinuxX64-FP000#X.tar.gz</br></td>
  </tr>
  <tr>
    <td>9.0.X</td>
    <td>Debian X86_64</td>
    <td>/wmq/v90/maint</td>
    <td><br>9.0.0-IBM-MQ-LinuxX64-FP000#X.tar.gz</br></td>
  </tr>
  <tr>
    <td>8.0.0.X</td>
    <td>Redhat X86_64</td>
    <td>/wmq/v80/maint</td>
    <td><br>8.0.0-WS-MQ-LinuxX64-FP000#{node['wmq']['fixpack']}.tar.gz</br></td>
  </tr>
  <tr>
    <td>8.0.0.X</td>
    <td>Debiant X86_64</td>
    <td>/wmq/v80/maint</td>
    <td><br>8.0.0-WS-MQ-LinuxX64-FP000#{node['wmq']['fixpack']}.tar.gz</br></td>
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

