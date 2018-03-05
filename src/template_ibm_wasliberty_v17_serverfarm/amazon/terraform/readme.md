# Template - IBM WebSphere Application Server Liberty V17 server farm
Template Version - 1.0

## Description

This template deploys a server farm topology of WebSphere Application Server Liberty V17 on 2 Linux virtual machines.<br>

## Features

### Clouds

 Amazon<br>
<br>
### Template Version

V1.0<br>
<br>
### Operating Systems Supported

Red Hat Enterprise Linux 7<br>
Red Hat Enterprise Linux 6<br>
Ubuntu 16.04 LTS<br>
Ubuntu 14.04 LTS<br>
<br>
### Topology

1) Liberty server - Central Node<br>
2) Liberty server - Application Node<br>
<br>
### Software Deployed

IBM WebSphere Application Server Liberty V17<br>
<br>
### Default Virtual Machine Settings

 t2.medium, vCPU 2, Mem (GiB) 4, EBS (GB) 100<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. Installation is via Installation Manager, please ensure this has been correctly installed on the repo server.<br>
3. Modify the libertynode_was_liberty_edition variable in CAM variables to change the installation type to base, core or nd.<br>
4. The plugin is generated on all nodes and merged on the Central node.<br>
5. IBM Knowledge Center for WAS Liberty - <a href=\"https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/as_ditamaps/was900_welcome_liberty.html\" target=\"_blank\">https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/as_ditamaps/was900_welcome_liberty.html</a><br>
6. IBM Support Portal - <a href=\"https://www.ibm.com/support/home/\" target=\"_blank\">https://www.ibm.com/support/home/</a><br>
<br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

Amazon EC2

### Software Deployed

- IBM WebSphere Liberty

### Major Versions

- IBM WebSphere Liberty 16.0.4
- IBM WebSphere Liberty 17.0.1
- IBM WebSphere Liberty 17.0.2


### Minor Versions

- IBM WebSphere Liberty 16.0.4
- IBM WebSphere Liberty 17.0.1
- IBM WebSphere Liberty 17.0.2


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
    <td>LibertyNode01</code></td>
    <td>liberty_plugin_merge</code></td>
    <td>create and configure a liberty server farm</code></td>
  </tr>
  <tr>
    <td>LibertyNode01</code></td>
    <td>liberty_plugin_generate</code></td>
    <td>create and configure a liberty server farm</code></td>
  </tr>
  <tr>
    <td>LibertyNode01</code></td>
    <td>liberty_plugin_merge_setup</code></td>
    <td>create and configure a liberty server farm</code></td>
  </tr>
  <tr>
    <td>LibertyNode01</code></td>
    <td>liberty_install</code></td>
    <td>installs WAS Liberty Base</code></td>
  </tr>
  <tr>
    <td>LibertyNode01</code></td>
    <td>liberty_create_server</code></td>
    <td>create and configure a liberty server instance</code></td>
  </tr>
  <tr>
    <td>CentralNode01</code></td>
    <td>liberty_plugin_generate</code></td>
    <td>create and configure a liberty server farm</code></td>
  </tr>
  <tr>
    <td>CentralNode01</code></td>
    <td>liberty_install</code></td>
    <td>installs WAS Liberty Base</code></td>
  </tr>
  <tr>
    <td>CentralNode01</code></td>
    <td>liberty_create_server</code></td>
    <td>create and configure a liberty server instance</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

### IBM WebSphere Liberty
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

### IBM WebSphere Liberty
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
    <td>/opt/IBM</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/tmp</td>
    <td>2048</td>
  </tr>
</table>



## Software Repository Libraries

The following standard operating system libraries are required in the relevant Operating System library for each Operating System.

### IBM WebSphere Liberty
<table>
  <tr>
    <td>debian</td>
    <td>x86_64</td>
    <td>None</td>
  </tr>
  <tr>
    <td>redhat</td>
    <td>x86_64</td>
    <td>None</td>
  </tr>
</table>



## Network Connectivity and Security Groups

Network connectivity is required from the deployed nodes to standard infrastructure. The following is a description of the network Ports required on each node based on the software deployed on that node.

### IBM WebSphere Liberty
<table>
  <tr>
    <td>Http port</td>
    <td>9080</td>
  </tr>
  <tr>
    <td>Https port</td>
    <td>9443</td>
  </tr>
</table>



# Software Repository Requirements

The following files are neccessary on the Software Repository to successfully install this product. Please refer to the document on managing software repositories for the correct method to load  and manage files on the Software Repository.


## IBM WebSphere Liberty

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>17.0.2</td>
    <td>X86_64</td>
    <td>Installed from IM Repository</td>
    <td><br>com.ibm.websphere.liberty.BASE_17.0.2.20170523_1818</br><br>com.ibm.websphere.liberty.CORE_17.0.2.20170523_1818</br><br>com.ibm.websphere.liberty.ND_17.0.2.20170523_1818</br></td>
  </tr>
  <tr>
    <td>17.0.1</td>
    <td>X86_64</td>
    <td>Installed from IM Repository</td>
    <td><br>com.ibm.websphere.liberty.BASE_17.0.1.20170227_0221</br><br>com.ibm.websphere.liberty.CORE_17.0.1.20170227_0221</br><br>com.ibm.websphere.liberty.ND_17.0.1.20170227_0221</br></td>
  </tr>
  <tr>
    <td>16.0.4</td>
    <td>X86_64</td>
    <td>Installed from IM Repository</td>
    <td><br>com.ibm.websphere.liberty.BASE_16.0.4.20161113_0220</br><br>com.ibm.websphere.liberty.BASE_16.0.4.20161113_0220</br><br>com.ibm.websphere.liberty.BASE_16.0.4.20161113_0220</br></td>
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
    <td>access_key</td>
    <td>The AWS API access key used to connect to Amazon EC2</td>
  </tr>
  <tr>
    <td>secret_key</code></td>
    <td>The AWS Secret Key associated with the API User</td>
  </tr>
  <tr>
    <td>region</code></td>
    <td>The AWS region which you wish to connect to.</td>
  </tr>
</table>

These variables are typically defined when creating a Cloud Connection.

