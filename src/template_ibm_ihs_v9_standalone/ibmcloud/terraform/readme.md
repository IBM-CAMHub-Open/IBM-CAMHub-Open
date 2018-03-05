# Template - IBM HTTP Server V9 on a single virtual machine
Template Version - 1.0

## Description

This template deploys a standalone instance of IBM HTTP Server 9 on a Linux virtual machine.<br>

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
Ubuntu 16.04 LTS<br>
Ubuntu 14.04 LTS<br>
<br>
### Topology

1 virtual machine:<br>
  IBM HTTP Server instance<br>
<br>
### Software Deployed

IBM HTTP Server for WebSphere Application Server V9<br>
Web Server Plug-ins for IBM WebSphere Application Server V9<br>
IBM SDK, Java Technology Edition V8<br>
<br>
### Default Virtual Machine Settings

 Cores 1, RAM (GB) 2, SAN Disk (GB) 25<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. Detailed system requirements for IBM HTTP Server 9 - <a href=\"https://www.ibm.com/software/reports/compatibility/clarity/index.html\" target=\"_blank\">https://www.ibm.com/software/reports/compatibility/clarity/index.html</a><br>
3. IBM Knowledge Center for IBM HTTP Server 9 - <a href=\"https://www.ibm.com/support/knowledgecenter/en/SSEQTJ_9.0.0\" target=\"_blank\">https://www.ibm.com/support/knowledgecenter/en/SSEQTJ_9.0.0</a><br>
4. IBM Support Portal - <a href=\"https://www.ibm.com/support/home/\" target=\"_blank\">https://www.ibm.com/support/home/</a><br>
<br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

IBM

### Software Deployed

- IBM HTTP Server 

### Major Versions

- IBM HTTP Server  8.5.5
- IBM HTTP Server  9.0.0


### Minor Versions

- IBM HTTP Server  8.5.5.12
- IBM HTTP Server  9.0.0.4


*Note, these represent base versions only, explicit fixpacks may also be added.*

### Platforms Supported

The following Operating Systems are supported for software defined in this template.

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
    <td>IHSNode01</code></td>
    <td>ihs-wasmode-nonadmin</code></td>
    <td>IHS frontend for WAS, nonAdmin install mode</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

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

