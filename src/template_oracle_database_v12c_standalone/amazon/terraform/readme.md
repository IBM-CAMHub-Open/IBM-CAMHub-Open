# Template - Oracle Database 12c Enterprise Edition on a single virtual machine
Template Version - 1.0

## Description

This template deploys Oracle Enterprise Database V12c with a raw database on a Linux virtual machine.<br>

## Features

### Clouds

 Amazon<br>
<br>
### Template Version

1.0<br>
<br>
### Operating Systems Supported

Red Hat Enterprise Linux 7<br>
<br>
### Topology

1 virtual machine:<br>
  Oracle Database 12c instance<br>
<br>
### Software Deployed

Oracle Database 12c Enterprise Edition<br>
<br>
### Default Virtual Machine Settings

 t2.large, vCPU 2, Mem (GiB) 8, EBS (GB) 100<br>
<br>
### Usage and Special Notes

1. The user is responsible for obtaining appropriate software licenses and downloads prior to template deployment.<br>
2. Detailed system requirements for Oracle Database 12c - <a href=\"https://docs.oracle.com/en/database\" target=\"_blank\">https://docs.oracle.com/en/database</a><br>
<br>


## Overview

### License and Maintainer

Copyright IBM Corp. 2016, 2017 

### Target Cloud Type

Amazon EC2

### Software Deployed

- Oracle Enterprise Database

### Major Versions

- Oracle Enterprise Database v12c


### Minor Versions

- Oracle Enterprise Database 12.1.0.1.0
- Oracle Enterprise Database 12.1.0.2.0
- Oracle Enterprise Database 12.2.0.1.0


*Note, these represent base versions only, explicit fixpacks may also be added.*

### Platforms Supported

The following Operating Systems are supported for software defined in this template.

- RHEL 6.x
- RHEL 7.x


### Nodes Description

The following table describes the nodes and relevant software component deployed on each node.

<table>
  <tr>
    <th>Node Name</th>
    <th>Component</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>OracleDBNode01</code></td>
    <td>oracledb_create_database</code></td>
    <td>Oracle Database role that creates a new database</code></td>
  </tr>
  <tr>
    <td>OracleDBNode01</code></td>
    <td>oracledb_v12c_install</code></td>
    <td>Oracle Database v12c role for default installation and configuration</code></td>
  </tr>
</table>


### Autoscaling Support

Nil

## Software Resource Minimal Requirements

The following is a summary of the minimal requirements available to the base operating system to support a successful deployment.

### Oracle Enterprise Database
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

### Oracle Enterprise Database
<table>
  <tr>
    <td>/var</td>
    <td>1024</td>
  </tr>
  <tr>
    <td>/tmp/ibm_cloud</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/u01</td>
    <td>2048</td>
  </tr>
  <tr>
    <td>/tmp</td>
    <td>1024</td>
  </tr>
</table>



## Software Repository Libraries

The following standard operating system libraries are required in the relevant Operating System library for each Operating System.

### Oracle Enterprise Database
<table>
  <tr>
    <td>RHEL 6.x</td>
    <td>x86_64</td>
    <td>binutils, compat-libcap1.x86_64, compat-libstdc++-33, gcc, gcc-c++, glibc, glibc-devel, ksh, libgcc, libstdc++, libstdc++-devel, libaio, libaio-devel, libXext, libXtst, libX11, libXau, libxcb, libXi, make, sysstat, unzip, net-tools</td>
  </tr>
  <tr>
    <td>RHEL 7.x</td>
    <td>x86_64</td>
    <td>binutils, compat-libcap1.x86_64, compat-libstdc++-33, gcc, gcc-c++, glibc, glibc-devel, ksh, libgcc, libstdc++, libstdc++-devel, libaio, libaio-devel, libXtst, libXi, make, sysstat, unzip, net-tools</td>
  </tr>
</table>



## Network Connectivity and Security Groups

Network connectivity is required from the deployed nodes to standard infrastructure. The following is a description of the network Ports required on each node based on the software deployed on that node.

### Oracle Enterprise Database
<table>
  <tr>
    <td>Min CPU</td>
    <td>1</td>
  </tr>
  <tr>
    <td>Oracle Listener Port</td>
    <td>1521</td>
  </tr>
</table>



# Software Repository Requirements

The following files are neccessary on the Software Repository to successfully install this product. Please refer to the document on managing software repositories for the correct method to load  and manage files on the Software Repository.


## Oracle Enterprise Database

### Installation
<table>
  <tr>
    <th>Version</th>
    <th>Arch</th>
    <th>Repository Root</th>
    <th>File</th>
  </tr>
  <tr>
    <td>12.2.0.1.0</td>
    <td>X86_64</td>
    <td>/oracle/ee/v12c/base</td>
    <td><br>V839960-01.zip</br><br>V840012-01.zip</br></td>
  </tr>
  <tr>
    <td>12.1.0.1.0</td>
    <td>X86_64</td>
    <td>/oracle/ee/v12c/base</td>
    <td><br>V38500-01_1of2.zip</br><br>V38500-01_2of2.zip</br><br>V38501-01_1of2.zip</br><br>V38501-01_2of2.zip</br></td>
  </tr>
  <tr>
    <td>12.1.0.2.0</td>
    <td>X86_64</td>
    <td>/oracle/ee/v12c/base</td>
    <td><br>V46095-01_1of2.zip</br><br>V46095-01_2of2.zip</br><br>V46096-01_1of2.zip</br><br>V46096-01_2of2.zip</br></td>
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

