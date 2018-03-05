# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from apache_tomcat_v8_standalone

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
  default = "repouser"
}


##### TomcatNode01 variables #####
#Variable : TomcatNode01-image
variable "TomcatNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
  default = "REDHAT_7_64"
}

#Variable : TomcatNode01-name
variable "TomcatNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : TomcatNode01-os_admin_user
variable "TomcatNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : TomcatNode01_tomcat_http_port
variable "TomcatNode01_tomcat_http_port" {
  type = "string"
  description = "The Tomcat port to service HTTP requests."
  default = "8080"
}

#Variable : TomcatNode01_tomcat_install_dir
variable "TomcatNode01_tomcat_install_dir" {
  type = "string"
  description = "Specifies the directory to install Tomcat."
  default = "/opt/tomcat8"
}

#Variable : TomcatNode01_tomcat_instance_dirs_log_dir
variable "TomcatNode01_tomcat_instance_dirs_log_dir" {
  type = "string"
  description = "Specifies the directory for Tomcat log files."
  default = "/var/log/tomcat8"
}

#Variable : TomcatNode01_tomcat_instance_dirs_temp_dir
variable "TomcatNode01_tomcat_instance_dirs_temp_dir" {
  type = "string"
  description = "Specifies the temporary directory for Tomcat."
  default = "/var/tmp/tomcat8/temp"
}

#Variable : TomcatNode01_tomcat_instance_dirs_webapps_dir
variable "TomcatNode01_tomcat_instance_dirs_webapps_dir" {
  type = "string"
  description = "Specifies the Tomcat directory for web applications."
  default = "/var/lib/tomcat8/webapps"
}

#Variable : TomcatNode01_tomcat_instance_dirs_work_dir
variable "TomcatNode01_tomcat_instance_dirs_work_dir" {
  type = "string"
  description = "Specifies the Tomcat working directory."
  default = "/var/tmp/tomcat8/work"
}

#Variable : TomcatNode01_tomcat_java_java_sdk
variable "TomcatNode01_tomcat_java_java_sdk" {
  type = "string"
  description = "Specifies the use of a Java Development Kit (false) or Runtime Environment (true)."
  default = "false"
}

#Variable : TomcatNode01_tomcat_java_vendor
variable "TomcatNode01_tomcat_java_vendor" {
  type = "string"
  description = "Currently only openjdk is supported as the Tomcat java vendor."
  default = "openjdk"
}

#Variable : TomcatNode01_tomcat_java_version
variable "TomcatNode01_tomcat_java_version" {
  type = "string"
  description = "The version of Java to be used for Tomcat."
  default = "1.8.0"
}

#Variable : TomcatNode01_tomcat_os_users_daemon_gid
variable "TomcatNode01_tomcat_os_users_daemon_gid" {
  type = "string"
  description = "Specifies the name of the Operating System group for Tomcat daemon users."
  default = "tomcat"
}

#Variable : TomcatNode01_tomcat_os_users_daemon_ldap_user
variable "TomcatNode01_tomcat_os_users_daemon_ldap_user" {
  type = "string"
  description = "Specifies whether the Tomcat daemon user is stored in LDAP."
  default = "false"
}

#Variable : TomcatNode01_tomcat_os_users_daemon_name
variable "TomcatNode01_tomcat_os_users_daemon_name" {
  type = "string"
  description = "Specifies the user for the Tomcat daemon."
  default = "tomcat"
}

#Variable : TomcatNode01_tomcat_ssl_enabled
variable "TomcatNode01_tomcat_ssl_enabled" {
  type = "string"
  description = "Indicates whether to enable the Tomcat SSL connector."
  default = "true"
}

#Variable : TomcatNode01_tomcat_ssl_keystore_password
variable "TomcatNode01_tomcat_ssl_keystore_password" {
  type = "string"
  description = "The keystore password used in Tomcat for SSL configuration."
}

#Variable : TomcatNode01_tomcat_ssl_port
variable "TomcatNode01_tomcat_ssl_port" {
  type = "string"
  description = "Tomcat port for SSL communication"
  default = "8443"
}

#Variable : TomcatNode01_tomcat_ui_control_all_roles_admin-gui
variable "TomcatNode01_tomcat_ui_control_all_roles_admin-gui" {
  type = "string"
  description = "Tomcat roles: admin-gui"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_all_roles_manager-gui
variable "TomcatNode01_tomcat_ui_control_all_roles_manager-gui" {
  type = "string"
  description = "Tomcat roles: manager-gui"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_all_roles_manager-jmx
variable "TomcatNode01_tomcat_ui_control_all_roles_manager-jmx" {
  type = "string"
  description = "Tomcat roles: manager-jmx"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_all_roles_manager-script
variable "TomcatNode01_tomcat_ui_control_all_roles_manager-script" {
  type = "string"
  description = "Tomcat roles: manager-script"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_all_roles_manager-status
variable "TomcatNode01_tomcat_ui_control_all_roles_manager-status" {
  type = "string"
  description = "Tomcat roles: manager-status"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_name
variable "TomcatNode01_tomcat_ui_control_users_administrator_name" {
  type = "string"
  description = "Name of the admin user to be configured in Tomcat."
  default = "admin"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_password
variable "TomcatNode01_tomcat_ui_control_users_administrator_password" {
  type = "string"
  description = "Password of the admin user to be configured in Tomcat."
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_status
variable "TomcatNode01_tomcat_ui_control_users_administrator_status" {
  type = "string"
  description = "Specifies whether to enable the admin user in the Tomcat configuration."
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_user_roles_admin-gui
variable "TomcatNode01_tomcat_ui_control_users_administrator_user_roles_admin-gui" {
  type = "string"
  description = "Tomcat users administrator roles: admin-gui"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-gui
variable "TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-gui" {
  type = "string"
  description = "Tomcat users administrator roles: manager-gui"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-jmx
variable "TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-jmx" {
  type = "string"
  description = "Tomcat users administrator roles: manager-jmx"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-script
variable "TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-script" {
  type = "string"
  description = "Tomcat users administrator roles: manager-script"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-status
variable "TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-status" {
  type = "string"
  description = "Tomcat users administrator roles: manager-status"
  default = "enabled"
}

#Variable : TomcatNode01_tomcat_version
variable "TomcatNode01_tomcat_version" {
  type = "string"
  description = "The version of Tomcat to be installed."
  default = "8.0.15"
}


##### virtualmachine variables #####
#Variable : TomcatNode01-mgmt-network-public
variable "TomcatNode01-mgmt-network-public" {
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
##### Resource : TomcatNode01
#########################################################


#Parameter : TomcatNode01_datacenter
variable "TomcatNode01_datacenter" {
  type = "string"
  description = "IBMCloud datacenter where infrastructure resources will be deployed"
  default = "dal05"
}


#Parameter : TomcatNode01_private_network_only
variable "TomcatNode01_private_network_only" {
  type = "string"
  description = "Provision the virtual machine with only private IP"
  default = "false"
}


#Parameter : TomcatNode01_number_of_cores
variable "TomcatNode01_number_of_cores" {
  type = "string"
  description = "Number of CPU cores, which is required to be a positive Integer"
  default = "2"
}


#Parameter : TomcatNode01_memory
variable "TomcatNode01_memory" {
  type = "string"
  description = "Amount of Memory (MBs), which is required to be one or more times of 1024"
  default = "4096"
}


#Parameter : TomcatNode01_network_speed
variable "TomcatNode01_network_speed" {
  type = "string"
  description = "Bandwidth of network communication applied to the virtual machine"
  default = "10"
}


#Parameter : TomcatNode01_hourly_billing
variable "TomcatNode01_hourly_billing" {
  type = "string"
  description = "Billing cycle: hourly billed or monthly billed"
  default = "true"
}


#Parameter : TomcatNode01_dedicated_acct_host_only
variable "TomcatNode01_dedicated_acct_host_only" {
  type = "string"
  description = "Shared or dedicated host, where dedicated host usually means higher performance and cost"
  default = "false"
}


#Parameter : TomcatNode01_local_disk
variable "TomcatNode01_local_disk" {
  type = "string"
  description = "User local disk or SAN disk"
  default = "false"
}

variable "TomcatNode01_root_disk_size" {
  type = "string"
  description = "Root Disk Size - TomcatNode01"
  default = "25"
}

resource "ibm_compute_vm_instance" "TomcatNode01" {
  hostname = "${var.TomcatNode01-name}"
  os_reference_code = "${var.TomcatNode01-image}"
  domain = "${var.runtime_domain}"
  datacenter = "${var.TomcatNode01_datacenter}"
  network_speed = "${var.TomcatNode01_network_speed}"
  hourly_billing = "${var.TomcatNode01_hourly_billing}"
  private_network_only = "${var.TomcatNode01_private_network_only}"
  cores = "${var.TomcatNode01_number_of_cores}"
  memory = "${var.TomcatNode01_memory}"
  disks = ["${var.TomcatNode01_root_disk_size}"]
  dedicated_acct_host_only = "${var.TomcatNode01_dedicated_acct_host_only}"
  local_disk = "${var.TomcatNode01_local_disk}"
  ssh_key_ids = ["${data.ibm_compute_ssh_key.ibm_pm_public_key.id}"]
  # Specify the ssh connection
  connection {
    user = "${var.TomcatNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "TomcatNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x TomcatNode01_add_ssh_key.sh'",
      "bash -c './TomcatNode01_add_ssh_key.sh  \"${var.TomcatNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> TomcatNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : TomcatNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "TomcatNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","ibm_compute_vm_instance.TomcatNode01"]
  name = "TomcatNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.TomcatNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.TomcatNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.TomcatNode01.ipv4_address_private : ibm_compute_vm_instance.TomcatNode01.ipv4_address}",
  "node_name": "${var.TomcatNode01-name}",
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
##### Resource : TomcatNode01_tomcat
#########################################################

resource "camc_softwaredeploy" "TomcatNode01_tomcat" {
  depends_on = ["camc_bootstrap.TomcatNode01_chef_bootstrap_comp"]
  name = "TomcatNode01_tomcat"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.TomcatNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.TomcatNode01-mgmt-network-public == "false" ? ibm_compute_vm_instance.TomcatNode01.ipv4_address_private : ibm_compute_vm_instance.TomcatNode01.ipv4_address}",
  "node_name": "${var.TomcatNode01-name}",
  "runlist": "role[tomcat]",
  "node_attributes": {
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[tomcat]"
    },
    "tomcat": {
      "http": {
        "port": "${var.TomcatNode01_tomcat_http_port}"
      },
      "install_dir": "${var.TomcatNode01_tomcat_install_dir}",
      "instance_dirs": {
        "log_dir": "${var.TomcatNode01_tomcat_instance_dirs_log_dir}",
        "temp_dir": "${var.TomcatNode01_tomcat_instance_dirs_temp_dir}",
        "webapps_dir": "${var.TomcatNode01_tomcat_instance_dirs_webapps_dir}",
        "work_dir": "${var.TomcatNode01_tomcat_instance_dirs_work_dir}"
      },
      "java": {
        "java_sdk": "${var.TomcatNode01_tomcat_java_java_sdk}",
        "vendor": "${var.TomcatNode01_tomcat_java_vendor}",
        "version": "${var.TomcatNode01_tomcat_java_version}"
      },
      "os_users": {
        "daemon": {
          "gid": "${var.TomcatNode01_tomcat_os_users_daemon_gid}",
          "ldap_user": "${var.TomcatNode01_tomcat_os_users_daemon_ldap_user}",
          "name": "${var.TomcatNode01_tomcat_os_users_daemon_name}"
        }
      },
      "ssl": {
        "enabled": "${var.TomcatNode01_tomcat_ssl_enabled}",
        "port": "${var.TomcatNode01_tomcat_ssl_port}"
      },
      "ui_control": {
        "all_roles": {
          "admin-gui": "${var.TomcatNode01_tomcat_ui_control_all_roles_admin-gui}",
          "manager-gui": "${var.TomcatNode01_tomcat_ui_control_all_roles_manager-gui}",
          "manager-jmx": "${var.TomcatNode01_tomcat_ui_control_all_roles_manager-jmx}",
          "manager-script": "${var.TomcatNode01_tomcat_ui_control_all_roles_manager-script}",
          "manager-status": "${var.TomcatNode01_tomcat_ui_control_all_roles_manager-status}"
        },
        "users": {
          "administrator": {
            "name": "${var.TomcatNode01_tomcat_ui_control_users_administrator_name}",
            "status": "${var.TomcatNode01_tomcat_ui_control_users_administrator_status}",
            "user_roles": {
              "admin-gui": "${var.TomcatNode01_tomcat_ui_control_users_administrator_user_roles_admin-gui}",
              "manager-gui": "${var.TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-gui}",
              "manager-jmx": "${var.TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-jmx}",
              "manager-script": "${var.TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-script}",
              "manager-status": "${var.TomcatNode01_tomcat_ui_control_users_administrator_user_roles_manager-status}"
            }
          }
        }
      },
      "version": "${var.TomcatNode01_tomcat_version}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "ibm": {
        "sw_repo_password": "${var.ibm_sw_repo_password}"
      },
      "tomcat": {
        "ssl": {
          "keystore": {
            "password": "${var.TomcatNode01_tomcat_ssl_keystore_password}"
          }
        },
        "ui_control": {
          "users": {
            "administrator": {
              "password": "${var.TomcatNode01_tomcat_ui_control_users_administrator_password}"
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

output "TomcatNode01_ip" {
  value = "Private : ${ibm_compute_vm_instance.TomcatNode01.ipv4_address_private} & Public : ${ibm_compute_vm_instance.TomcatNode01.ipv4_address}"
}

output "TomcatNode01_name" {
  value = "${var.TomcatNode01-name}"
}

output "TomcatNode01_roles" {
  value = "tomcat"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

