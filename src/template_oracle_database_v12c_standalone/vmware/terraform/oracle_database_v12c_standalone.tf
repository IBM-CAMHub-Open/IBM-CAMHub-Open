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
variable "user_public_ssh_key" {
  type = "string"
  description = "User defined public SSH key used to connect to the virtual machine. The format must be in openSSH."
}

variable "ibm_pm_public_ssh_key" {
  description = "Public CAMC SSH key value which is used to connect to a guest, used on VMware only."
}

variable "ibm_pm_private_ssh_key" {
  description = "Private CAMC SSH key (base64 encoded) used to connect to the virtual guest."
}

variable "allow_unverified_ssl" {
  description = "Communication with vsphere server with self signed certificate"
}

##############################################################
# Define the vsphere provider 
##############################################################
provider "vsphere" {
  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  version = "~> 0.4"
}

provider "camc" {
  version = "~> 0.1"
}

provider "random" {
  version = "~> 1.0"
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

#########################################################
##### Resource : OracleDBNode01
#########################################################

variable "OracleDBNode01-os_password" {
  type = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "OracleDBNode01_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "OracleDBNode01_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "OracleDBNode01_domain" {
  description = "Domain Name of virtual machine"
}

variable "OracleDBNode01_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
}

variable "OracleDBNode01_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
}

variable "OracleDBNode01_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "OracleDBNode01_dns_suffixes" {
  type = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "OracleDBNode01_dns_servers" {
  type = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "OracleDBNode01_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "OracleDBNode01_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "OracleDBNode01_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "OracleDBNode01_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "OracleDBNode01_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
}

variable "OracleDBNode01_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "OracleDBNode01_root_disk_type" {
  type = "string"
  description = "Type of template disk volume"
}

variable "OracleDBNode01_root_disk_controller_type" {
  type = "string"
  description = "Type of template disk controller"
}

variable "OracleDBNode01_root_disk_keep_on_remove" {
  type = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
}

# vsphere vm
resource "vsphere_virtual_machine" "OracleDBNode01" {
  name = "${var.OracleDBNode01-name}"
  domain = "${var.OracleDBNode01_domain}"
  folder = "${var.OracleDBNode01_folder}"
  datacenter = "${var.OracleDBNode01_datacenter}"
  vcpu = "${var.OracleDBNode01_number_of_vcpu}"
  memory = "${var.OracleDBNode01_memory}"
  cluster = "${var.OracleDBNode01_cluster}"
  dns_suffixes = "${var.OracleDBNode01_dns_suffixes}"
  dns_servers = "${var.OracleDBNode01_dns_servers}"

  network_interface {
    label = "${var.OracleDBNode01_network_interface_label}"
    ipv4_gateway = "${var.OracleDBNode01_ipv4_gateway}"
    ipv4_address = "${var.OracleDBNode01_ipv4_address}"
    ipv4_prefix_length = "${var.OracleDBNode01_ipv4_prefix_length}"
    adapter_type = "${var.OracleDBNode01_adapter_type}"
  }

  disk {
    type = "${var.OracleDBNode01_root_disk_type}"
    template = "${var.OracleDBNode01-image}"
    datastore = "${var.OracleDBNode01_root_disk_datastore}"
    keep_on_remove = "${var.OracleDBNode01_root_disk_keep_on_remove}"
    controller_type = "${var.OracleDBNode01_root_disk_controller_type}"
  }

  # Specify the connection
  connection {
    type = "ssh"
    user = "${var.OracleDBNode01-os_admin_user}"
    password = "${var.OracleDBNode01-os_password}"
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

if (( $# != 3 )); then
echo "usage: arg 1 is user, arg 2 is public key, arg3 is CAMC Public Key"
exit -1
fi

userid="$1"
ssh_key="$2"
camc_ssh_key="$3"

user_home=$(eval echo "~$userid")
user_auth_key_file=$user_home/.ssh/authorized_keys
echo "$user_auth_key_file"
if ! [ -f $user_auth_key_file ]; then
echo "$user_auth_key_file does not exist on this system, creating."
mkdir $user_home/.ssh
chmod 700 $user_home/.ssh
touch $user_home/.ssh/authorized_keys
chmod 600 $user_home/.ssh/authorized_keys
else
echo "user_home : $user_home"
fi

if [[ $ssh_key = 'None' ]]; then
echo "skipping user key add, 'None' specified"
else
echo "$user_auth_key_file"
echo "$ssh_key" >> "$user_auth_key_file"
if [ $? -ne 0 ]; then
echo "failed to add to $user_auth_key_file"
exit -1
else
echo "updated $user_auth_key_file"
fi
fi

echo "$camc_ssh_key" >> "$user_auth_key_file"
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
      "bash -c './OracleDBNode01_add_ssh_key.sh  \"${var.OracleDBNode01-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> OracleDBNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : OracleDBNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "OracleDBNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","vsphere_virtual_machine.OracleDBNode01"]
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
  "host_ip": "${vsphere_virtual_machine.OracleDBNode01.network_interface.0.ipv4_address}",
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
  "host_ip": "${vsphere_virtual_machine.OracleDBNode01.network_interface.0.ipv4_address}",
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
  "host_ip": "${vsphere_virtual_machine.OracleDBNode01.network_interface.0.ipv4_address}",
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
  value = "VM IP Address : ${vsphere_virtual_machine.OracleDBNode01.network_interface.0.ipv4_address}"
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

