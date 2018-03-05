# Template - Apache Tomcat on a single virtual machine
Template Version - 1.0

## Description

This template deploys Apache Tomcat on a Linux virtual machine.<br>

## Features

### Clouds

 VMware<br>
<br>
### Template Version

1.0<br>
<br>
### Operating Systems Supported

Red Hat Enterprise Linux 7<br>
Ubuntu 16.04<br>
<br>
### Topology

1 virtual machine:<br>
  Linux Virual Machine with Apache Tomcat Server<br>
<br>
### Software Deployed

Apache Tomcat Server Version 8<br>
<br>
### Default Virtual Machine Settings

 vCPU 2, Memory (GB) 4<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. Detailed system requirements for Apache Tomcat - <a href=\"http://tomcat.apache.org/\" target=\"_blank\">http://tomcat.apache.org</a><br>
<br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

VMware vSphere

### Software Deployed

- Apache Tomcat

### Major Versions

- Apache Tomcat 8.0.15


### Minor Versions

- Apache Tomcat 8.0.15


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
    <td>TomcatNode01</code></td>
    <td>tomcat</code></td>
    <td>Tomcat installation and configuration with SSL and admin user enabled.</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

### Apache Tomcat
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

### Apache Tomcat
<table>
  <tr>
    <td>/var</td>
    <td>1024</td>
  </tr>
  <tr>
    <td>/tmp/ibm_cloud</td>
    <td>1024</td>
  </tr>
  <tr>
    <td>/tmp</td>
    <td>1024</td>
  </tr>
  <tr>
    <td>/opt/tomcat</td>
    <td>1024</td>
  </tr>
</table>



## Software Repository Libraries

The following standard operating system libraries are required in the relevant Operating System library for each Operating System.

### Apache Tomcat
<table>
  <tr>
    <td>debian</td>
    <td>x86_64</td>
    <td>nil</td>
  </tr>
  <tr>
    <td>redhat</td>
    <td>x86_64</td>
    <td>nil</td>
  </tr>
</table>



## Network Connectivity and Security Groups

Network connectivity is required from the deployed nodes to standard infrastructure. The following is a description of the network Ports required on each node based on the software deployed on that node.

### Apache Tomcat
<table>
  <tr>
    <td>Http Port</td>
    <td>8080</td>
  </tr>
  <tr>
    <td>AJP Port</td>
    <td>8009</td>
  </tr>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
  <tr>
    <td>Server Port</td>
    <td>8005</td>
  </tr>
</table>



# Software Repository Requirements

The following files are neccessary on the Software Repository to successfully install this product. Please refer to the document on managing software repositories for the correct method to load  and manage files on the Software Repository.


## Apache Tomcat

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>8.0.5</td>
    <td>X86_64</td>
    <td>/apache/tomcat/v8/base</td>
    <td><br>apache-tomcat-8.0.5.tar.gz</br></td>
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

