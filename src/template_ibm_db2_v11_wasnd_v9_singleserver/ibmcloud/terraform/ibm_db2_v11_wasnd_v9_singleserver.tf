# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from ibm_db2_v11_wasnd_v9_singleserver

##############################################################
# Keys - CAMC (public/private) & optional User Key (public) 
##############################################################
variable "ibm_pm_public_ssh_key_name" {
  description = "Public CAMC SSH key name used to connect to the virtual guest."
}

variable "ibm_pm_private_ssh_key" {
  description = "Private CAMC SSH key (base64 encoded) used to connect to the virtual guest."
}

variable "user_public_ssh_key" {
  type = "string"
  description = "User defined public SSH key used to connect to the virtual machine. The format must be in openSSH."
  default = "None"
}

##############################################################
# Define the ibm provider 
##############################################################
#define the ibm provider
provider "ibm" {
  version = "~> 0.5"
}

provider "camc" {
  version = "~> 0.1"
}

provider "random" {
  version = "~> 1.0"
}

##############################################################
# Reference public key in Devices>Manage>SSH Keys in SL console) 
##############################################################
data "ibm_compute_ssh_key" "ibm_pm_public_key" {
  label = "${var.ibm_pm_public_ssh_key_name}"
  most_recent = "true"
}

resource "random_id" "stack_id" {
  byte_length = "16"
}

##############################################################
# Define pattern variables 
##############################################################
##### unique stack name #####
variable "ibm_stack_name" {
  description = "A unique stack name."
}


##### DB2WASNode01 variables #####
#Variable : DB2WASNode01-image
variable "DB2WASNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
  default = "REDHAT_7_64"
}

#Variable : DB2WASNode01-name
variable "DB2WASNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : DB2WASNode01-os_admin_user
variable "DB2WASNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : DB2WASNode01_db2_base_version
variable "DB2WASNode01_db2_base_version" {
  type = "string"
  description = "The base version of DB2 to install. Set to none if installing from fix package."
  default = "none"
}

#Variable : DB2WASNode01_db2_das_password
variable "DB2WASNode01_db2_das_password" {
  type = "string"
  description = "DB2 Administration Server (DAS) password"
}

#Variable : DB2WASNode01_db2_das_username
variable "DB2WASNode01_db2_das_username" {
  type = "string"
  description = "DB2 Administration Server (DAS) username"
  default = "db2das1"
}

#Variable : DB2WASNode01_db2_fp_version
variable "DB2WASNode01_db2_fp_version" {
  type = "string"
  description = "The version of DB2 fix pack to install. If no fix pack is required, set this value the same as DB2 base version."
  default = "11.1.2.2"
}

#Variable : DB2WASNode01_db2_install_dir
variable "DB2WASNode01_db2_install_dir" {
  type = "string"
  description = "The directory to install DB2. Recommended: /opt/ibm/db2/V<db2_version>"
  default = "/opt/ibm/db2/V11.1"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_codeset
variable "DB2WASNode01_db2_instances_instance1_databases_database1_codeset" {
  type = "string"
  description = "Codeset is used by the database manager to determine codepage parameter values."
  default = "UTF-8"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_update_FAILARCHPATH
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_update_FAILARCHPATH" {
  type = "string"
  description = "The path to be used for archiving log files."
  default = "default"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGARCHMETH1
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGARCHMETH1" {
  type = "string"
  description = "Specifies the media type of the primary destination for logs that are archived."
  default = "default"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGFILSIZ
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGFILSIZ" {
  type = "string"
  description = "Specifies the size of log files."
  default = "default"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGSECOND
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGSECOND" {
  type = "string"
  description = "Specifies the number of secondary log files that are created and used for recovery log files."
  default = "default"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_update_NEWLOGPATH
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_update_NEWLOGPATH" {
  type = "string"
  description = "The path to be used for database logging."
  default = "default"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_ldap_user
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_ldap_user" {
  type = "string"
  description = "This parameter indicates whether the database user is stored in LDAP. If the value set to true, the user is not created on the operating system."
  default = "false"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_access
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_access" {
  type = "string"
  description = "The database access granted to the user. Example: DBADM WITH DATAACCESS WITHOUT ACCESSCTRL"
  default = "none"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_gid
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_gid" {
  type = "string"
  description = "Specifies the name of the operating system group for database users."
  default = "dbgroup1"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_home
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_home" {
  type = "string"
  description = "The DB2 database user home directory."
  default = "default"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_name
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_name" {
  type = "string"
  description = "The user name to be granted database access."
  default = "dbuser1"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_password
variable "DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_password" {
  type = "string"
  description = "The password for the database user name."
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_db_collate
variable "DB2WASNode01_db2_instances_instance1_databases_database1_db_collate" {
  type = "string"
  description = "Collate determines ordering for a set of characters."
  default = "SYSTEM"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_db_data_path
variable "DB2WASNode01_db2_instances_instance1_databases_database1_db_data_path" {
  type = "string"
  description = "Specifies the DB2 database data path."
  default = "/home/db2inst1"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_db_name
variable "DB2WASNode01_db2_instances_instance1_databases_database1_db_name" {
  type = "string"
  description = "The name of the database to be created."
  default = "db01"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_db_path
variable "DB2WASNode01_db2_instances_instance1_databases_database1_db_path" {
  type = "string"
  description = "Specifies the DB2 database path."
  default = "/home/db2inst1"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_pagesize
variable "DB2WASNode01_db2_instances_instance1_databases_database1_pagesize" {
  type = "string"
  description = "Specifies the page size in bytes."
  default = "4096"
}

#Variable : DB2WASNode01_db2_instances_instance1_databases_database1_territory
variable "DB2WASNode01_db2_instances_instance1_databases_database1_territory" {
  type = "string"
  description = "Territory is used by the database manager when processing data that is territory sensitive."
  default = "US"
}

#Variable : DB2WASNode01_db2_instances_instance1_fcm_port
variable "DB2WASNode01_db2_instances_instance1_fcm_port" {
  type = "string"
  description = "The port for the DB2 Fast Communications Manager (FCM)."
  default = "60000"
}

#Variable : DB2WASNode01_db2_instances_instance1_fenced_groupname
variable "DB2WASNode01_db2_instances_instance1_fenced_groupname" {
  type = "string"
  description = "The group name for the DB2 fenced user."
  default = "db2fenc1"
}

#Variable : DB2WASNode01_db2_instances_instance1_fenced_password
variable "DB2WASNode01_db2_instances_instance1_fenced_password" {
  type = "string"
  description = "The password for the DB2 fenced username."
}

#Variable : DB2WASNode01_db2_instances_instance1_fenced_username
variable "DB2WASNode01_db2_instances_instance1_fenced_username" {
  type = "string"
  description = "The fenced user is used to run user defined functions and stored procedures outside of the address space used by the DB2 database."
  default = "db2fenc1"
}

#Variable : DB2WASNode01_db2_instances_instance1_instance_dir
variable "DB2WASNode01_db2_instances_instance1_instance_dir" {
  type = "string"
  description = "The DB2 instance directory stores all information that pertains to a database instance."
  default = "/home/db2inst1"
}

#Variable : DB2WASNode01_db2_instances_instance1_instance_groupname
variable "DB2WASNode01_db2_instances_instance1_instance_groupname" {
  type = "string"
  description = "The group name for the DB2 instance user."
  default = "db2iadm1"
}

#Variable : DB2WASNode01_db2_instances_instance1_instance_password
variable "DB2WASNode01_db2_instances_instance1_instance_password" {
  type = "string"
  description = "The password for the DB2 instance username."
}

#Variable : DB2WASNode01_db2_instances_instance1_instance_prefix
variable "DB2WASNode01_db2_instances_instance1_instance_prefix" {
  type = "string"
  description = "Specifies the DB2 instance prefix"
  default = "INST1"
}

#Variable : DB2WASNode01_db2_instances_instance1_instance_type
variable "DB2WASNode01_db2_instances_instance1_instance_type" {
  type = "string"
  description = "The type of DB2 instance to create."
  default = "ESE"
}

#Variable : DB2WASNode01_db2_instances_instance1_instance_username
variable "DB2WASNode01_db2_instances_instance1_instance_username" {
  type = "string"
  description = "The DB2 instance username controls all DB2 processes and owns all filesystems and devices."
  default = "db2inst1"
}

#Variable : DB2WASNode01_db2_instances_instance1_port
variable "DB2WASNode01_db2_instances_instance1_port" {
  type = "string"
  description = "The port to connect to the DB2 instance."
  default = "50000"
}

#Variable : DB2WASNode01_was_install_dir
variable "DB2WASNode01_was_install_dir" {
  type = "string"
  description = "The installation root directory for the WebSphere Application Server product binaries"
  default = "/opt/IBM/WebSphere/AppServer"
}

#Variable : DB2WASNode01_was_java_version
variable "DB2WASNode01_was_java_version" {
  type = "string"
  description = "The Java SDK version that should be installed with the WebSphere Application Server. Example format is 8.0.4.70"
  default = "8.0.4.70"
}

#Variable : DB2WASNode01_was_os_users_was_gid
variable "DB2WASNode01_was_os_users_was_gid" {
  type = "string"
  description = "Operating system group name that will be assigned to the product installation"
  default = "wasgrp"
}

#Variable : DB2WASNode01_was_os_users_was_home
variable "DB2WASNode01_was_os_users_was_home" {
  type = "string"
  description = "Home directory location for operating system user that is used for product installation"
  default = "/home/wasadmin"
}

#Variable : DB2WASNode01_was_os_users_was_ldap_user
variable "DB2WASNode01_was_os_users_was_ldap_user" {
  type = "string"
  description = "A flag which indicates whether to create the WebSphere user locally, or utilize an LDAP based user"
  default = "false"
}

#Variable : DB2WASNode01_was_os_users_was_name
variable "DB2WASNode01_was_os_users_was_name" {
  type = "string"
  description = "Operating system userid that will be used to install the product. Userid will be created if it does not exist"
  default = "wasadmin"
}

#Variable : DB2WASNode01_was_profile_dir
variable "DB2WASNode01_was_profile_dir" {
  type = "string"
  description = "The directory path that contains WebSphere Application Server profiles"
  default = "/opt/IBM/WebSphere/AppServer/profiles"
}

#Variable : DB2WASNode01_was_profiles_standalone_profiles_standalone1_cell
variable "DB2WASNode01_was_profiles_standalone_profiles_standalone1_cell" {
  type = "string"
  description = "Cell name for the application server"
  default = "cell01"
}

#Variable : DB2WASNode01_was_profiles_standalone_profiles_standalone1_keystorepassword
variable "DB2WASNode01_was_profiles_standalone_profiles_standalone1_keystorepassword" {
  type = "string"
  description = "Specifies the password to use on all keystore files created during profile creation"
}

#Variable : DB2WASNode01_was_profiles_standalone_profiles_standalone1_profile
variable "DB2WASNode01_was_profiles_standalone_profiles_standalone1_profile" {
  type = "string"
  description = "Application server profile name"
  default = "AppSrv01"
}

#Variable : DB2WASNode01_was_profiles_standalone_profiles_standalone1_server
variable "DB2WASNode01_was_profiles_standalone_profiles_standalone1_server" {
  type = "string"
  description = "Name of the application server"
  default = "server1"
}

#Variable : DB2WASNode01_was_security_admin_user
variable "DB2WASNode01_was_security_admin_user" {
  type = "string"
  description = "The username for securing the WebSphere adminstrative console"
  default = "wasadmin"
}

#Variable : DB2WASNode01_was_security_admin_user_pwd
variable "DB2WASNode01_was_security_admin_user_pwd" {
  type = "string"
  description = "The password for the WebSphere administrative account"
}

#Variable : DB2WASNode01_was_version
variable "DB2WASNode01_was_version" {
  type = "string"
  description = "The release and fixpack level of WebSphere Application Server to be installed. Example formats are 8.5.5.12 or 9.0.0.4"
  default = "9.0.0.4"
}

#Variable : DB2WASNode01_was_wsadmin_standalone_jvmproperty_property_value_initial
variable "DB2WASNode01_was_wsadmin_standalone_jvmproperty_property_value_initial" {
  type = "string"
  description = "Minimum JVM heap size"
  default = "256"
}

#Variable : DB2WASNode01_was_wsadmin_standalone_jvmproperty_property_value_maximum
variable "DB2WASNode01_was_wsadmin_standalone_jvmproperty_property_value_maximum" {
  type = "string"
  description = "Maximum JVM heap size"
  default = "512"
}


##### Environment variables #####
#Variable : ibm_im_repo
variable "ibm_im_repo" {
  type = "string"
  description = "IBM Software  Installation Manager Repository URL (https://<hostname/IP>:<port>/IMRepo) "
}

#Variable : ibm_im_repo_password
variable "ibm_im_repo_password" {
  type = "string"
  description = "IBM Software  Installation Manager Repository Password"
}

#Variable : ibm_im_repo_user
variable "ibm_im_repo_user" {
  type = "string"
  description = "IBM Software  Installation Manager Repository username"
  default = "repouser"
}

#Variable : ibm_pm_access_token
variable "ibm_pm_access_token" {
  type = "string"
  description = "IBM Pattern Manager Access Token"
}

#Variable : ibm_pm_service
variable "ibm_pm_service" {
  type = "string"
  description = "IBM Pattern Manager Service"
}

#Variable : ibm_sw_repo
variable "ibm_sw_repo" {
  type = "string"
  description = "IBM Software Repo Root (https://<hostname>:<port>)"
}

#Variable : ibm_sw_repo_password
variable "ibm_sw_repo_password" {
  type = "string"
  description = "IBM Software Repo Password"
}

#Variable : ibm_sw_repo_user
variable "ibm_sw_repo_user" {
  type = "string"
  description = "IBM Software Repo Username"
  default = "repouser"
}


##### virtualmachine variables #####
#Variable : DB2WASNode01-mgmt-network-public
variable "DB2WASNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
  default = "true"
}


##### ungrouped variables #####
##### domain name #####
variable "runtime_domain" {
  description = "domain name"
  default = "cam.ibm.com"
}


#########################################################
##### Resource : DB2WASNode01
#########################################################


#Parameter : DB2WASNode01_datacenter
variable "DB2WASNode01_datacenter" {
  type = "string"
  description = "IBMCloud datacenter where infrastructure resources will be deployed"
  default = "dal05"
}


#Parameter : DB2WASNode01_private_network_only
variable "DB2WASNode01_private_network_only" {
  type = "string"
  description = "Provision the virtual machine with only private IP"
  default = "false"
}


#Parameter : DB2WASNode01_number_of_cores
variable "DB2WASNode01_number_of_cores" {
  type = "string"
  description = "Number of CPU cores, which is required to be a positive Integer"
  default = "4"
}


#Parameter : DB2WASNode01_memory
variable "DB2WASNode01_memory" {
  type = "string"
  description = "Amount of Memory (MBs), which is required to be one or more times of 1024"
  default = "8192"
}


#Parameter : DB2WASNode01_network_speed
variable "DB2WASNode01_network_speed" {
  type = "string"
  description = "Bandwidth of network communication applied to the virtual machine"
  default = "10"
}


#Parameter : DB2WASNode01_hourly_billing
variable "DB2WASNode01_hourly_billing" {
  type = "string"
  description = "Billing cycle: hourly billed or monthly billed"
  default = "true"
}


#Parameter : DB2WASNode01_dedicated_acct_host_only
variable "DB2WASNode01_dedicated_acct_host_only" {
  type = "string"
  description = "Shared or dedicated host, where dedicated host usually means higher performance and cost"
  default = "false"
}


#Parameter : DB2WASNode01_local_disk
variable "DB2WASNode01_local_disk" {
  type = "string"
  description = "User local disk or SAN disk"
  default = "false"
}

variable "DB2WASNode01_root_disk_size" {
  type = "string"
  description = "Root Disk Size - DB2WASNode01"
  default = "25"
}

resource "ibm_compute_vm_instance" "DB2WASNode01" {
  hostname = "${var.DB2WASNode01-name}"
  os_reference_code = "${var.DB2WASNode01-image}"
  domain = "${var.runtime_domain}"
  datacenter = "${var.DB2WASNode01_datacenter}"
  network_speed = "${var.DB2WASNode01_network_speed}"
  hourly_billing = "${var.DB2WASNode01_hourly_billing}"
  private_network_only = "${var.DB2WASNode01_private_network_only}"
  cores = "${var.DB2WASNode01_number_of_cores}"
  memory = "${var.DB2WASNode01_memory}"
  disks = ["${var.DB2WASNode01_root_disk_size}"]
  dedicated_acct_host_only = "${var.DB2WASNode01_dedicated_acct_host_only}"
  local_disk = "${var.DB2WASNode01_local_disk}"
  ssh_key_ids = ["${data.ibm_compute_ssh_key.ibm_pm_public_key.id}"]
  # Specify the ssh connection
  connection {
    user = "${var.DB2WASNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "DB2WASNode01_add_ssh_key.sh"
    content     = <<EOF
# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================
#!/bin/bash

if (( $# != 2 )); then
    echo "usage: arg 1 is user, arg 2 is public key"
    exit -1
fi

userid=$1
ssh_key=$2

if [[ $ssh_key = 'None' ]]; then
  echo "skipping add, 'None' specified"
  exit 0
fi

user_home=$(eval echo "~$userid")
user_auth_key_file=$user_home/.ssh/authorized_keys
if ! [ -f $user_auth_key_file ]; then
  echo "$user_auth_key_file does not exist on this system"
  exit -1
else
  echo "user_home --> $user_home"
fi

echo $ssh_key >> $user_auth_key_file
if [ $? -ne 0 ]; then
  echo "failed to add to $user_auth_key_file"
  exit -1
else
  echo "updated $user_auth_key_file"
fi

EOF
  }

  # Execute the script remotely
  provisioner "remote-exec" {
    inline = [
      "bash -c 'chmod +x DB2WASNode01_add_ssh_key.sh'",
      "bash -c './DB2WASNode01_add_ssh_key.sh  \"${var.DB2WASNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> DB2WASNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : DB2WASNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "DB2WASNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","ibm_compute_vm_instance.DB2WASNode01"]
  name = "DB2WASNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.DB2WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.DB2WASNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.DB2WASNode01.ipv4_address_private : ibm_compute_vm_instance.DB2WASNode01.ipv4_address}",
  "node_name": "${var.DB2WASNode01-name}",
  "node_attributes": {
    "ibm_internal": {
      "stack_id": "${random_id.stack_id.hex}",
      "stack_name": "${var.ibm_stack_name}",
      "vault": {
        "item": "secrets",
        "name": "${random_id.stack_id.hex}"
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : DB2WASNode01_db2_create_db
#########################################################

resource "camc_softwaredeploy" "DB2WASNode01_db2_create_db" {
  depends_on = ["camc_softwaredeploy.DB2WASNode01_db2_v111_install"]
  name = "DB2WASNode01_db2_create_db"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.DB2WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.DB2WASNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.DB2WASNode01.ipv4_address_private : ibm_compute_vm_instance.DB2WASNode01.ipv4_address}",
  "node_name": "${var.DB2WASNode01-name}",
  "runlist": "role[db2_create_db]",
  "node_attributes": {
    "db2": {
      "instances": {
        "instance1": {
          "databases": {
            "database1": {
              "codeset": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_codeset}",
              "database_update": {
                "FAILARCHPATH": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_update_FAILARCHPATH}",
                "LOGARCHMETH1": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGARCHMETH1}",
                "LOGFILSIZ": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGFILSIZ}",
                "LOGSECOND": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_update_LOGSECOND}",
                "NEWLOGPATH": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_update_NEWLOGPATH}"
              },
              "database_users": {
                "db_user1": {
                  "ldap_user": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_ldap_user}",
                  "user_access": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_access}",
                  "user_gid": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_gid}",
                  "user_home": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_home}",
                  "user_name": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_name}"
                }
              },
              "db_collate": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_db_collate}",
              "db_data_path": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_db_data_path}",
              "db_name": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_db_name}",
              "db_path": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_db_path}",
              "pagesize": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_pagesize}",
              "territory": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_territory}"
            }
          },
          "fcm_port": "${var.DB2WASNode01_db2_instances_instance1_fcm_port}",
          "fenced_groupname": "${var.DB2WASNode01_db2_instances_instance1_fenced_groupname}",
          "fenced_username": "${var.DB2WASNode01_db2_instances_instance1_fenced_username}",
          "instance_dir": "${var.DB2WASNode01_db2_instances_instance1_instance_dir}",
          "instance_groupname": "${var.DB2WASNode01_db2_instances_instance1_instance_groupname}",
          "instance_prefix": "${var.DB2WASNode01_db2_instances_instance1_instance_prefix}",
          "instance_type": "${var.DB2WASNode01_db2_instances_instance1_instance_type}",
          "instance_username": "${var.DB2WASNode01_db2_instances_instance1_instance_username}",
          "port": "${var.DB2WASNode01_db2_instances_instance1_port}"
        }
      }
    },
    "ibm_internal": {
      "roles": "[db2_create_db]"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "db2": {
        "instances": {
          "instance1": {
            "databases": {
              "database1": {
                "database_users": {
                  "db_user1": {
                    "user_password": "${var.DB2WASNode01_db2_instances_instance1_databases_database1_database_users_db_user1_user_password}"
                  }
                }
              }
            },
            "fenced_password": "${var.DB2WASNode01_db2_instances_instance1_fenced_password}",
            "instance_password": "${var.DB2WASNode01_db2_instances_instance1_instance_password}"
          }
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}


#########################################################
##### Resource : DB2WASNode01_db2_v111_install
#########################################################

resource "camc_softwaredeploy" "DB2WASNode01_db2_v111_install" {
  depends_on = ["camc_bootstrap.DB2WASNode01_chef_bootstrap_comp"]
  name = "DB2WASNode01_db2_v111_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.DB2WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.DB2WASNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.DB2WASNode01.ipv4_address_private : ibm_compute_vm_instance.DB2WASNode01.ipv4_address}",
  "node_name": "${var.DB2WASNode01-name}",
  "runlist": "role[db2_v111_install]",
  "node_attributes": {
    "db2": {
      "base_version": "${var.DB2WASNode01_db2_base_version}",
      "das_username": "${var.DB2WASNode01_db2_das_username}",
      "fp_version": "${var.DB2WASNode01_db2_fp_version}",
      "install_dir": "${var.DB2WASNode01_db2_install_dir}"
    },
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_auth": "true",
      "sw_repo_self_signed_cert": "true",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[db2_v111_install]"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "db2": {
        "das_password": "${var.DB2WASNode01_db2_das_password}"
      },
      "ibm": {
        "sw_repo_password": "${var.ibm_sw_repo_password}"
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}


#########################################################
##### Resource : DB2WASNode01_was_create_standalone
#########################################################

resource "camc_softwaredeploy" "DB2WASNode01_was_create_standalone" {
  depends_on = ["camc_softwaredeploy.DB2WASNode01_was_v9_install"]
  name = "DB2WASNode01_was_create_standalone"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.DB2WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.DB2WASNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.DB2WASNode01.ipv4_address_private : ibm_compute_vm_instance.DB2WASNode01.ipv4_address}",
  "node_name": "${var.DB2WASNode01-name}",
  "runlist": "role[was_create_standalone]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_standalone]"
    },
    "was": {
      "profiles": {
        "standalone_profiles": {
          "standalone1": {
            "cell": "${var.DB2WASNode01_was_profiles_standalone_profiles_standalone1_cell}",
            "profile": "${var.DB2WASNode01_was_profiles_standalone_profiles_standalone1_profile}",
            "server": "${var.DB2WASNode01_was_profiles_standalone_profiles_standalone1_server}"
          }
        }
      },
      "wsadmin": {
        "standalone": {
          "jvmproperty": {
            "property_value_initial": "${var.DB2WASNode01_was_wsadmin_standalone_jvmproperty_property_value_initial}",
            "property_value_maximum": "${var.DB2WASNode01_was_wsadmin_standalone_jvmproperty_property_value_maximum}"
          }
        }
      }
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "was": {
        "profiles": {
          "standalone_profiles": {
            "standalone1": {
              "keystorepassword": "${var.DB2WASNode01_was_profiles_standalone_profiles_standalone1_keystorepassword}"
            }
          }
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}


#########################################################
##### Resource : DB2WASNode01_was_v9_install
#########################################################

resource "camc_softwaredeploy" "DB2WASNode01_was_v9_install" {
  depends_on = ["camc_softwaredeploy.DB2WASNode01_db2_create_db"]
  name = "DB2WASNode01_was_v9_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.DB2WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.DB2WASNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.DB2WASNode01.ipv4_address_private : ibm_compute_vm_instance.DB2WASNode01.ipv4_address}",
  "node_name": "${var.DB2WASNode01-name}",
  "runlist": "role[was_v9_install]",
  "node_attributes": {
    "ibm": {
      "im_repo": "${var.ibm_im_repo}",
      "im_repo_user": "${var.ibm_im_repo_user}",
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[was_v9_install]"
    },
    "was": {
      "install_dir": "${var.DB2WASNode01_was_install_dir}",
      "java_version": "${var.DB2WASNode01_was_java_version}",
      "os_users": {
        "was": {
          "gid": "${var.DB2WASNode01_was_os_users_was_gid}",
          "home": "${var.DB2WASNode01_was_os_users_was_home}",
          "ldap_user": "${var.DB2WASNode01_was_os_users_was_ldap_user}",
          "name": "${var.DB2WASNode01_was_os_users_was_name}"
        }
      },
      "profile_dir": "${var.DB2WASNode01_was_profile_dir}",
      "security": {
        "admin_user": "${var.DB2WASNode01_was_security_admin_user}"
      },
      "version": "${var.DB2WASNode01_was_version}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "ibm": {
        "im_repo_password": "${var.ibm_im_repo_password}",
        "sw_repo_password": "${var.ibm_sw_repo_password}"
      },
      "was": {
        "security": {
          "admin_user_pwd": "${var.DB2WASNode01_was_security_admin_user_pwd}"
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}


#########################################################
##### Resource : VaultItem
#########################################################

resource "camc_vaultitem" "VaultItem" {
  camc_endpoint = "${var.ibm_pm_service}/v1/vault_item/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "vault_content": {
    "item": "secrets",
    "values": {},
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}

output "DB2WASNode01_ip" {
  value = "Private : ${ibm_compute_vm_instance.DB2WASNode01.ipv4_address_private} & Public : ${ibm_compute_vm_instance.DB2WASNode01.ipv4_address}"
}

output "DB2WASNode01_name" {
  value = "${var.DB2WASNode01-name}"
}

output "DB2WASNode01_roles" {
  value = "db2_create_db,db2_v111_install,was_create_standalone,was_v9_install"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

