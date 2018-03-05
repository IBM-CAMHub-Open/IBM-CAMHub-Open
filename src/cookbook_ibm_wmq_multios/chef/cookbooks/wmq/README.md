Wmq Cookbook
============

## DESCRIPTION

The wmq cookbook contains features and functions to support the installation and management of IBM WebSphere MQSeries.

## Platforms Support

* RHEL 6.x (NOTE, MQ8 is not supported on RHEL6)
* RHEL 7.x
* Ubuntu Server 14.04 or greater

## Versions

* IBM WebSphere MQSeries V8.0
* IBM WebSphere MQSeries V9.0

## Use Cases

Currently on single node (non HA) only.

* Single installation with no configuration. This will entail configuring the kernel, installing pre-requisite libraries, installing the base and fixpack for IBM MQSeries. This pattern is relevant on a single node only.
* Single installation with 1..n queue managers defined. Queue Managers are defined using the following structure.
```python

    "wmq": {
      "qmgr": {
          "qmgr1": {
            "name": "QMGR1",
            "description": "Default Queue Manager",
            "listener_port": "1414",
            "loggingtype": "lc",
            "primarylogs": "10",
            "secondarylogs": "20",
            "logsize": "16384",
            "dlq": "SYSTEM.DEAD.LETTER.QUEUE"
          }
       }
```
## Platform Pre-Requisites

* Linux YUM Repository - An onsite linux YUM Repsoitory is required.

## Software Repository

SW_REPO_ROOT -> Stored in the ['ibm']['sw_repo'] attribute.

Relative to the software repository, the installation files must be stored in the following location.

* BASE FILES   -> /mq/[v80|v90]/base
* FIXPACK FILES -> /mq/[v80|v90]/maint

The following is a description of files needed on the REPO Server depending on version and architecture.

```python

Base Install Files
==================

case node['wmq]['version']
when '8.0'
  case os
  when 'linux'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq]['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176'}
      }
    when 'powerpc'
      force_default['wmq]['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_FOR_AIX_V8.0_EIMAGE.tar.tgz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176'}
      }
    when 's390x'
      force_default['wmq]['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_SYS_Z_64B_V8.0_IMG.tar.gz',
                    'sha256' =>  '6d1db6949a2a97606eb62cc7f43977bbdf61bdd229f1a1085ad05b6fb800f176'}
      }
    end
  end
when '9.0'
  case os
  when 'linux'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq]['archive_names'] = {
        'base' => { 'filename' => 'IBM_MQ_9.0.0.0_LINUX_X86-64.tar.gz', 
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a'}
      }
    when 'powerpc'
      force_default['wmq]['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_FOR_AIX_V9.0.0_EIMAGE.tar.tgz',
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a'}
      }
    when 's390x'
      force_default['wmq]['archive_names'] = {
        'base' => { 'filename' => 'WS_MQ_LINUX_SYS_Z_64B_V9.0.0_IMG.tar.gz',
                    'sha256' =>  'd16efd8113bede1439c1be4865befe7f3193648b70f08646a0fa0ad1a42a996a'}
      }
    end
  end
end

Fixpack Files
=============

case node['wmq']['version']
when '8.0'
  case node['os']
  when 'linux'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => '8.0.0-WS-MQ-LinuxX64-FP000{node['wmq']['fixpack']}.tar.gz' }
      }
    when 'powerpc'
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => '8.0.0-WS-MQ-LinuxPPC64-FP000{node['wmq']['fixpack']}.tar.gz' }
      }
    when 's390x'
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => '8.0.0-WS-MQ-LinuxS390X-FP000{node['wmq']['fixpack']}.tar.gz' }
      }
    end
  end
when '9.0'
  case node['os']
  when 'linux'
    case node['kernel']['machine']
    when 'x86_64'
      force_default['wmq']['fixpack_names'] = {
        'fixpack' => { 'filename' => '9.0.0-WS-MQ-LinuxX64-FP000{node['wmq']['fixpack']}.tar.gz' }
      }
  end
end

```
## Environment Variables

```python
default['ibm']['sw_repo']                 - URL of the Software Repository.
default['ibm']['sw_repo_user']                    - User to access the software Repository.
default['ibm']['sw_repo_password']                - Password for the software repository, note, will exist in VAULT.
default['ibm']['sw_repo_self_signed_cert']     - Boolean indicating whether the repo uses a self signed certificate.
default['ibm']['sw_repo_auth']                 - Boolean indicating whether the software repo is secured.
default['ibm_internal']['stack_id']            - Unique ID referencing all nodes in a deployment.
default['ibm_internal']['stack_name']          - Common name for the deployed stack.
default['ibm_internal']['vault']['name']       - Name of the Vault, will be generated by the environment.
default['ibm_internal']['vault']['item']       - Vault Item to reference, will be  generated by the environment.
```


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
    <td><code>node['wmq']['advanced']</code></td>
    <td>Install IBM MQ Advanced components: File Transfer, IBM MQ Telemetry, and Advanced Message Security.</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['data_dir']</code></td>
    <td>The directory to install IBM MQ Data files, recommended /var/mqm</td>
    <td><code>/var/mqm</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['fixpack']</code></td>
    <td>The fixpack of IBM MQ to install.</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['global_mq_service']</code></td>
    <td>Option to defined service for all IBM MQ Queue Manager</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['install_dir']</code></td>
    <td>The directory to install IBM MQ Binaries, recommended /opt/mqm</td>
    <td><code>/opt/mqm</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['log_dir']</code></td>
    <td>The directory to install IBM MQ Log Directory, recommended -> node[wmq][data_dir]/log</td>
    <td><code>/var/mqm/log</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_core_rmem_default']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_core_rmem_default</td>
    <td><code>262144</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_core_rmem_max']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_core_rmem_max</td>
    <td><code>4194304</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_core_wmem_default']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_core_wmem_default</td>
    <td><code>262144</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_core_wmem_max']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_core_wmem_max</td>
    <td><code>1048576</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_fin_timeout']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_fin_timeout</td>
    <td><code>60</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_keepalive_intvl']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_intvl</td>
    <td><code>75</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_keepalive_time']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_time</td>
    <td><code>7200</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_rmem']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_rmem</td>
    <td><code>4096    87380   4194304</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_sack']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_sack</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_timestamps']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_timestamps</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_window_scaling']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_window_scaling</td>
    <td><code>1</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['net_ipv4_tcp_wmem']</code></td>
    <td>WebSphere MQ Server Kernel Configuration net_ipv4_tcp_wmem</td>
    <td><code>4096    87380   4194304</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['nofile_value']</code></td>
    <td>WebSphere MQ Server Ulimit Nofile Value</td>
    <td><code>10240</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['os_users']['mqm']['comment']</code></td>
    <td>Comment associated with the IBM MQ User</td>
    <td><code>IBM MQ User</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['os_users']['mqm']['gid']</code></td>
    <td>Group ID of the Unix OS User for IBM MQ</td>
    <td><code>mqm</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['os_users']['mqm']['home']</code></td>
    <td>Home Directory of Default OS User for IBM MQ User.</td>
    <td><code>/home/mqm</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['os_users']['mqm']['ldap_user']</code></td>
    <td>A flag which indicates whether to create the MQ USer locally, or utilise an LDAP based user.</td>
    <td><code>false</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['os_users']['mqm']['name']</code></td>
    <td>Name of the Unix OS User that owns and controls IBM MQ</td>
    <td><code>mqm</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['os_users']['mqm']['shell']</code></td>
    <td>Location of the IBM MQ User Shell</td>
    <td><code>/bin/bash</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['perms']</code></td>
    <td>Default permissions for IBM MQ files on Unix</td>
    <td><code>775</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['description']</code></td>
    <td>Description of the Queue Manager</td>
    <td><code>Queue Manager 1</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['dlq']</code></td>
    <td>Queue Manager dead letter queue</td>
    <td><code>SYSTEM.DEAD.LETTER.QUEUE</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['listener_port']</code></td>
    <td>Port the Queue Manager listens on.</td>
    <td><code>1414</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['loggingtype']</code></td>
    <td>Type of logging to use ll(Linear), lc(Circular)</td>
    <td><code>lc</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['logsize']</code></td>
    <td>Size of the IBM MQ Logs</td>
    <td><code>16384</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['name']</code></td>
    <td>Name of the Queue Manager to Create</td>
    <td><code>qmgr1</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['primarylogs']</code></td>
    <td>Number of primary logs to create.</td>
    <td><code>10</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr']['qmgr($INDEX)']['secondarylogs']</code></td>
    <td>Number of Secondary Logs</td>
    <td><code>20</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['qmgr_dir']</code></td>
    <td>The directory to install IBM MQ Queue Manager Directory, recommended node[wmq][data_dir]/qmgrs</td>
    <td><code>/var/mqm/qmgrs</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['service_name']</code></td>
    <td>WebSphere MQ service name</td>
    <td><code>mq</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['swap_file']</code></td>
    <td>Swap file name</td>
    <td><code>/swapfile</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['swap_file_size']</code></td>
    <td>UNIX Swap size in megabytes</td>
    <td><code>512</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['version']</code></td>
    <td>The Version of IBM MQ to install, eg, 8.0</td>
    <td><code>9.0</code></td>
  </tr>
  <tr>
    <td><code>node['wmq']['vm_swappiness']</code></td>
    <td>WebSphere MQ Server Kernel Configuration vm_swappiness</td>
    <td><code>0</code></td>
  </tr>
</table>

Recipes
-------

### wmq::cleanup.rb


Cleanup recipe (cleanup.rb)
Perform post-install cleanup


### wmq::config_qmgr_single.rb


Create one or more queue managers if they do not already exist.


### wmq::default.rb


Default recipe


### wmq::fixpack.rb


Installation recipe (fixpack.rb)
This recipe performs the fixpack installation for the product


### wmq::gather_evidence.rb


Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.


### wmq::install.rb


Installation recipe (install.rb)
This recipe performs the product installation.


### wmq::prereq.rb


Prerequisites recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.


### wmq::prereq_check.rb


Prerequisite Check Recipe (preq_check.rb)
This recipe wil check the target platform to ensure installation is possible


### wmq::service.rb


Create the MQ service and enables it on RHEL 7
Determine Service Type, systemd or not
Create the MQ service file
Create Upstart Service File
Create the MQ service script
Enable and start the httpd service
Enable and start the httpd service
Enable the MQ service
Start the MQ service


### wmq::start_qmgr.rb


Start all queue managers defined for the target node.


### wmq::stop_qmgr.rb


Stop all queue managers defined for the target node.



License and Author
------------------

Author:: IBM Corp (<>)

Copyright:: 2017, IBM Corp

License:: Copyright IBM Corp. 2012, 2017

