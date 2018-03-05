# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from oracle_database_v12c_standalone

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


##### Environment variables #####
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
}


##### OracleDBNode01 variables #####
#Variable : OracleDBNode01-image
variable "OracleDBNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : OracleDBNode01-name
variable "OracleDBNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : OracleDBNode01-os_admin_user
variable "OracleDBNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : OracleDBNode01_oracledb_SID
variable "OracleDBNode01_oracledb_SID" {
  type = "string"
  description = "Name to identify a specific instance of a running Oracle database"
}

#Variable : OracleDBNode01_oracledb_port
variable "OracleDBNode01_oracledb_port" {
  type = "string"
  description = "Listening port to be configured in Oracle"
}

#Variable : OracleDBNode01_oracledb_release_patchset
variable "OracleDBNode01_oracledb_release_patchset" {
  type = "string"
  description = "Identifier of patch set to apply to Oracle for improvement and bug fix"
}

#Variable : OracleDBNode01_oracledb_security_sys_pw
variable "OracleDBNode01_oracledb_security_sys_pw" {
  type = "string"
  description = "Change the password for SYS user"
}

#Variable : OracleDBNode01_oracledb_security_system_pw
variable "OracleDBNode01_oracledb_security_system_pw" {
  type = "string"
  description = "Change the password for SYSTEM user"
}

#Variable : OracleDBNode01_oracledb_version
variable "OracleDBNode01_oracledb_version" {
  type = "string"
  description = "Version of Oracle DB to be installed"
}


##### virtualmachine variables #####
#Variable : OracleDBNode01-mgmt-network-public
variable "OracleDBNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
}


##### ungrouped variables #####
##### domain name #####
variable "runtime_domain" {
  description = "domain name"
}


#########################################################
##### Resource : OracleDBNode01
#########################################################


#Parameter : OracleDBNode01_datacenter
variable "OracleDBNode01_datacenter" {
  type = "string"
  description = "IBMCloud datacenter where infrastructure resources will be deployed"
}


#Parameter : OracleDBNode01_private_network_only
variable "OracleDBNode01_private_network_only" {
  type = "string"
  description = "Provision the virtual machine with only private IP"
}


#Parameter : OracleDBNode01_number_of_cores
variable "OracleDBNode01_number_of_cores" {
  type = "string"
  description = "Number of CPU cores, which is required to be a positive Integer"
}


#Parameter : OracleDBNode01_memory
variable "OracleDBNode01_memory" {
  type = "string"
  description = "Amount of Memory (MBs), which is required to be one or more times of 1024"
}


#Parameter : OracleDBNode01_network_speed
variable "OracleDBNode01_network_speed" {
  type = "string"
  description = "Bandwidth of network communication applied to the virtual machine"
}


#Parameter : OracleDBNode01_hourly_billing
variable "OracleDBNode01_hourly_billing" {
  type = "string"
  description = "Billing cycle: hourly billed or monthly billed"
}


#Parameter : OracleDBNode01_dedicated_acct_host_only
variable "OracleDBNode01_dedicated_acct_host_only" {
  type = "string"
  description = "Shared or dedicated host, where dedicated host usually means higher performance and cost"
}


#Parameter : OracleDBNode01_local_disk
variable "OracleDBNode01_local_disk" {
  type = "string"
  description = "User local disk or SAN disk"
}

variable "OracleDBNode01_root_disk_size" {
  type = "string"
  description = "Root Disk Size - OracleDBNode01"
}

resource "ibm_compute_vm_instance" "OracleDBNode01" {
  hostname = "${var.OracleDBNode01-name}"
  os_reference_code = "${var.OracleDBNode01-image}"
  domain = "${var.runtime_domain}"
  datacenter = "${var.OracleDBNode01_datacenter}"
  network_speed = "${var.OracleDBNode01_network_speed}"
  hourly_billing = "${var.OracleDBNode01_hourly_billing}"
  private_network_only = "${var.OracleDBNode01_private_network_only}"
  cores = "${var.OracleDBNode01_number_of_cores}"
  memory = "${var.OracleDBNode01_memory}"
  disks = ["${var.OracleDBNode01_root_disk_size}"]
  dedicated_acct_host_only = "${var.OracleDBNode01_dedicated_acct_host_only}"
  local_disk = "${var.OracleDBNode01_local_disk}"
  ssh_key_ids = ["${data.ibm_compute_ssh_key.ibm_pm_public_key.id}"]
  # Specify the ssh connection
  connection {
    user = "${var.OracleDBNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "OracleDBNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x OracleDBNode01_add_ssh_key.sh'",
      "bash -c './OracleDBNode01_add_ssh_key.sh  \"${var.OracleDBNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> OracleDBNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : OracleDBNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "OracleDBNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","ibm_compute_vm_instance.OracleDBNode01"]
  name = "OracleDBNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.OracleDBNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.OracleDBNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.OracleDBNode01.ipv4_address_private : ibm_compute_vm_instance.OracleDBNode01.ipv4_address}",
  "node_name": "${var.OracleDBNode01-name}",
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
##### Resource : OracleDBNode01_oracledb_create_database
#########################################################

resource "camc_softwaredeploy" "OracleDBNode01_oracledb_create_database" {
  depends_on = ["camc_softwaredeploy.OracleDBNode01_oracledb_v12c_install"]
  name = "OracleDBNode01_oracledb_create_database"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.OracleDBNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.OracleDBNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.OracleDBNode01.ipv4_address_private : ibm_compute_vm_instance.OracleDBNode01.ipv4_address}",
  "node_name": "${var.OracleDBNode01-name}",
  "runlist": "role[oracledb_create_database]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[oracledb_create_database]"
    },
    "oracledb": {
      "SID": "${var.OracleDBNode01_oracledb_SID}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "oracledb": {
        "security": {
          "sys_pw": "${var.OracleDBNode01_oracledb_security_sys_pw}",
          "system_pw": "${var.OracleDBNode01_oracledb_security_system_pw}"
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}


#########################################################
##### Resource : OracleDBNode01_oracledb_v12c_install
#########################################################

resource "camc_softwaredeploy" "OracleDBNode01_oracledb_v12c_install" {
  depends_on = ["camc_bootstrap.OracleDBNode01_chef_bootstrap_comp"]
  name = "OracleDBNode01_oracledb_v12c_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.OracleDBNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.OracleDBNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.OracleDBNode01.ipv4_address_private : ibm_compute_vm_instance.OracleDBNode01.ipv4_address}",
  "node_name": "${var.OracleDBNode01-name}",
  "runlist": "role[oracledb_v12c_install]",
  "node_attributes": {
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_auth": "true",
      "sw_repo_self_signed_cert": "true",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[oracledb_v12c_install]"
    },
    "oracledb": {
      "port": "${var.OracleDBNode01_oracledb_port}",
      "release_patchset": "${var.OracleDBNode01_oracledb_release_patchset}",
      "version": "${var.OracleDBNode01_oracledb_version}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
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

output "OracleDBNode01_ip" {
  value = "Private : ${ibm_compute_vm_instance.OracleDBNode01.ipv4_address_private} & Public : ${ibm_compute_vm_instance.OracleDBNode01.ipv4_address}"
}

output "OracleDBNode01_name" {
  value = "${var.OracleDBNode01-name}"
}

output "OracleDBNode01_roles" {
  value = "oracledb_create_database,oracledb_v12c_install"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

