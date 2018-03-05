# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from ibm_wasliberty_v17_standalone

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
}


##### LibertyNode01 variables #####
#Variable : LibertyNode01-image
variable "LibertyNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : LibertyNode01-name
variable "LibertyNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : LibertyNode01-os_admin_user
variable "LibertyNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : LibertyNode01_was_liberty_base_version
variable "LibertyNode01_was_liberty_base_version" {
  type = "string"
  description = "The release and fixpack level for WebSphere Liberty to be installed. Example formats are 8.5.5.11 or 17.0.2"
}

#Variable : LibertyNode01_was_liberty_edition
variable "LibertyNode01_was_liberty_edition" {
  type = "string"
  description = "Indicates which Liberty offering should be installed. Valid values are: base, core, nd"
}

#Variable : LibertyNode01_was_liberty_install_dir
variable "LibertyNode01_was_liberty_install_dir" {
  type = "string"
  description = "The installation root directory for the WebSphere Liberty product binaries"
}

#Variable : LibertyNode01_was_liberty_install_grp
variable "LibertyNode01_was_liberty_install_grp" {
  type = "string"
  description = "Operating system group name that will be assigned to the product installation"
}

#Variable : LibertyNode01_was_liberty_install_user
variable "LibertyNode01_was_liberty_install_user" {
  type = "string"
  description = "Operating system userid that will be used to install the product. Userid will be created if it does not exist"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_feature
variable "LibertyNode01_was_liberty_liberty_servers_server1_feature" {
  type = "string"
  description = "Lists the Liberty features that should be included in the feature manager list. For example, webProfile-7.0 adminCenter-1.0"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_httpport
variable "LibertyNode01_was_liberty_liberty_servers_server1_httpport" {
  type = "string"
  description = "HTTP Transport value that will be set in the defaultHttpEndpoint endpoint in server.xml"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_httpsport
variable "LibertyNode01_was_liberty_liberty_servers_server1_httpsport" {
  type = "string"
  description = "Secure HTTP Transport value that will be set in the defaultHttpEndpoint endpoint in server.xml"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_keystore_id
variable "LibertyNode01_was_liberty_liberty_servers_server1_keystore_id" {
  type = "string"
  description = "Keystore id that will be used when setting up the keyStore attribute in the server.xml"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_keystore_password
variable "LibertyNode01_was_liberty_liberty_servers_server1_keystore_password" {
  type = "string"
  description = "Liberty keystore password used to protect the Liberty keystore id, this value will be stored in Chef Vault"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_name
variable "LibertyNode01_was_liberty_liberty_servers_server1_name" {
  type = "string"
  description = "Name of the initial Liberty server to be created during provisioning"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_name
variable "LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_name" {
  type = "string"
  description = "Administrative console username used for accessing the console, the associated password is the admin_user password"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_password
variable "LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_password" {
  type = "string"
  description = "Password for the Liberty administrative user name, this value to be stored in the Chef Vault"
}

#Variable : LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_role
variable "LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_role" {
  type = "string"
  description = "Liberty role for which administrative users are to be added to, the admin_user will be added to this role by default"
}

#Variable : LibertyNode01_was_liberty_wlp_user_dir
variable "LibertyNode01_was_liberty_wlp_user_dir" {
  type = "string"
  description = "Liberty directory which product configuration will be written"
}


##### virtualmachine variables #####

#########################################################
##### Resource : LibertyNode01
#########################################################

variable "LibertyNode01-os_password" {
  type = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "LibertyNode01_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "LibertyNode01_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "LibertyNode01_domain" {
  description = "Domain Name of virtual machine"
}

variable "LibertyNode01_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
}

variable "LibertyNode01_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
}

variable "LibertyNode01_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "LibertyNode01_dns_suffixes" {
  type = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "LibertyNode01_dns_servers" {
  type = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "LibertyNode01_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "LibertyNode01_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "LibertyNode01_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "LibertyNode01_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "LibertyNode01_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
}

variable "LibertyNode01_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "LibertyNode01_root_disk_type" {
  type = "string"
  description = "Type of template disk volume"
}

variable "LibertyNode01_root_disk_controller_type" {
  type = "string"
  description = "Type of template disk controller"
}

variable "LibertyNode01_root_disk_keep_on_remove" {
  type = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
}

# vsphere vm
resource "vsphere_virtual_machine" "LibertyNode01" {
  name = "${var.LibertyNode01-name}"
  domain = "${var.LibertyNode01_domain}"
  folder = "${var.LibertyNode01_folder}"
  datacenter = "${var.LibertyNode01_datacenter}"
  vcpu = "${var.LibertyNode01_number_of_vcpu}"
  memory = "${var.LibertyNode01_memory}"
  cluster = "${var.LibertyNode01_cluster}"
  dns_suffixes = "${var.LibertyNode01_dns_suffixes}"
  dns_servers = "${var.LibertyNode01_dns_servers}"

  network_interface {
    label = "${var.LibertyNode01_network_interface_label}"
    ipv4_gateway = "${var.LibertyNode01_ipv4_gateway}"
    ipv4_address = "${var.LibertyNode01_ipv4_address}"
    ipv4_prefix_length = "${var.LibertyNode01_ipv4_prefix_length}"
    adapter_type = "${var.LibertyNode01_adapter_type}"
  }

  disk {
    type = "${var.LibertyNode01_root_disk_type}"
    template = "${var.LibertyNode01-image}"
    datastore = "${var.LibertyNode01_root_disk_datastore}"
    keep_on_remove = "${var.LibertyNode01_root_disk_keep_on_remove}"
    controller_type = "${var.LibertyNode01_root_disk_controller_type}"
  }

  # Specify the connection
  connection {
    type = "ssh"
    user = "${var.LibertyNode01-os_admin_user}"
    password = "${var.LibertyNode01-os_password}"
  }

  provisioner "file" {
    destination = "LibertyNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x LibertyNode01_add_ssh_key.sh'",
      "bash -c './LibertyNode01_add_ssh_key.sh  \"${var.LibertyNode01-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> LibertyNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : LibertyNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "LibertyNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","vsphere_virtual_machine.LibertyNode01"]
  name = "LibertyNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.LibertyNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.LibertyNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.LibertyNode01-name}",
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
##### Resource : LibertyNode01_liberty_create_server
#########################################################

resource "camc_softwaredeploy" "LibertyNode01_liberty_create_server" {
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_install"]
  name = "LibertyNode01_liberty_create_server"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.LibertyNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.LibertyNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.LibertyNode01-name}",
  "runlist": "role[liberty_create_server]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[liberty_create_server]"
    },
    "was_liberty": {
      "install_dir": "${var.LibertyNode01_was_liberty_install_dir}",
      "liberty_servers": {
        "server1": {
          "feature": "${var.LibertyNode01_was_liberty_liberty_servers_server1_feature}",
          "httpport": "${var.LibertyNode01_was_liberty_liberty_servers_server1_httpport}",
          "httpsport": "${var.LibertyNode01_was_liberty_liberty_servers_server1_httpsport}",
          "jvm_params": "-Xms256m -Xmx2048m",
          "keystore_id": "${var.LibertyNode01_was_liberty_liberty_servers_server1_keystore_id}",
          "name": "${var.LibertyNode01_was_liberty_liberty_servers_server1_name}",
          "users": {
            "admin_user": {
              "name": "${var.LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_name}",
              "role": "${var.LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_role}"
            }
          }
        }
      },
      "wlp_user_dir": "${var.LibertyNode01_was_liberty_wlp_user_dir}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "was_liberty": {
        "liberty_servers": {
          "server1": {
            "keystore_password": "${var.LibertyNode01_was_liberty_liberty_servers_server1_keystore_password}",
            "users": {
              "admin_user": {
                "password": "${var.LibertyNode01_was_liberty_liberty_servers_server1_users_admin_user_password}"
              }
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
##### Resource : LibertyNode01_liberty_install
#########################################################

resource "camc_softwaredeploy" "LibertyNode01_liberty_install" {
  depends_on = ["camc_bootstrap.LibertyNode01_chef_bootstrap_comp"]
  name = "LibertyNode01_liberty_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.LibertyNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.LibertyNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.LibertyNode01-name}",
  "runlist": "role[liberty_install]",
  "node_attributes": {
    "ibm": {
      "im_repo": "${var.ibm_im_repo}",
      "im_repo_user": "${var.ibm_im_repo_user}",
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[liberty_install]"
    },
    "was_liberty": {
      "base_version": "${var.LibertyNode01_was_liberty_base_version}",
      "edition": "${var.LibertyNode01_was_liberty_edition}",
      "install_dir": "${var.LibertyNode01_was_liberty_install_dir}",
      "install_grp": "${var.LibertyNode01_was_liberty_install_grp}",
      "install_user": "${var.LibertyNode01_was_liberty_install_user}",
      "wlp_user_dir": "${var.LibertyNode01_was_liberty_wlp_user_dir}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "ibm": {
        "im_repo_password": "${var.ibm_im_repo_password}",
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

output "LibertyNode01_ip" {
  value = "VM IP Address : ${vsphere_virtual_machine.LibertyNode01.network_interface.0.ipv4_address}"
}

output "LibertyNode01_name" {
  value = "${var.LibertyNode01-name}"
}

output "LibertyNode01_roles" {
  value = "liberty_create_server,liberty_install"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

