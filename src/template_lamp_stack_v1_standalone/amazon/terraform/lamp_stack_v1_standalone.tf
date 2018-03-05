# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from lamp_stack_v1_standalone

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
  type        = "string"
  description = "User defined public SSH key used to connect to the virtual machine. The format must be in openSSH."
  default     = "None"
}

variable "aws_ami_owner_id" {
  description = "AWS AMI Owner ID"
  default     = "309956199498"
}

variable "aws_region" {
  description = "AWS Region Name"
  default     = "us-east-1"
}

##############################################################
# Define the aws provider
##############################################################
provider "aws" {
  region  = "${var.aws_region}"
  version = "~> 1.2"
}

provider "camc" {
  version = "~> 0.1"
}

provider "template" {
  version = "~> 1.0"
}

provider "random" {
  version = "~> 1.0"
}

data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.aws_vpc_name}"]
  }
}

#Parameter : aws_vpc_name
variable "aws_vpc_name" {
  description = "AWS VPC Name"
}

data "aws_security_group" "aws_sg_camc_name_selected" {
  name   = "${var.aws_sg_camc_name}"
  vpc_id = "${data.aws_vpc.selected_vpc.id}"
}

#Parameter : aws_sg_camc_name
variable "aws_sg_camc_name" {
  description = "AWS Security Group Name"
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
  type        = "string"
  description = "IBM Pattern Manager Access Token"
}

#Variable : ibm_pm_service
variable "ibm_pm_service" {
  type        = "string"
  description = "IBM Pattern Manager Service"
}

#Variable : ibm_sw_repo
variable "ibm_sw_repo" {
  type        = "string"
  description = "IBM Software Repo Root (https://<hostname>:<port>)"
}

#Variable : ibm_sw_repo_password
variable "ibm_sw_repo_password" {
  type        = "string"
  description = "IBM Software Repo Password"
}

#Variable : ibm_sw_repo_user
variable "ibm_sw_repo_user" {
  type        = "string"
  description = "IBM Software Repo Username"
  default     = "repouser"
}

##### LAMPNode01 variables #####
data "aws_ami" "LAMPNode01_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.LAMPNode01-image}*"]
  }

  owners = ["${var.aws_ami_owner_id}"]
}

#Variable : LAMPNode01-image
variable "LAMPNode01-image" {
  type        = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
  default     = "RHEL-7.4_HVM_GA"
}

#Variable : LAMPNode01-name
variable "LAMPNode01-name" {
  type        = "string"
  description = "Short hostname of virtual machine"
}

#Variable : LAMPNode01-os_admin_user
variable "LAMPNode01-os_admin_user" {
  type        = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : LAMPNode01_httpd_data_dir_mode
variable "LAMPNode01_httpd_data_dir_mode" {
  type        = "string"
  description = "OS Permisssions of data folders"
  default     = "0755"
}

#Variable : LAMPNode01_httpd_document_root
variable "LAMPNode01_httpd_document_root" {
  type        = "string"
  description = "File System Location of the Document Root"
  default     = "/var/www/html5"
}

#Variable : LAMPNode01_httpd_listen
variable "LAMPNode01_httpd_listen" {
  type        = "string"
  description = "Listening port to be configured in HTTP server"
  default     = "8080"
}

#Variable : LAMPNode01_httpd_log_dir
variable "LAMPNode01_httpd_log_dir" {
  type        = "string"
  description = "Directory where HTTP Server logs will be sent"
  default     = "/var/log/httpd"
}

#Variable : LAMPNode01_httpd_log_level
variable "LAMPNode01_httpd_log_level" {
  type        = "string"
  description = "Log levels of the http process"
  default     = "info"
}

#Variable : LAMPNode01_httpd_os_users_web_content_owner_gid
variable "LAMPNode01_httpd_os_users_web_content_owner_gid" {
  type        = "string"
  description = "Group ID of web content owner to be configured in HTTP server"
  default     = "webmaster"
}

#Variable : LAMPNode01_httpd_os_users_web_content_owner_home
variable "LAMPNode01_httpd_os_users_web_content_owner_home" {
  type        = "string"
  description = "Home directory of web content owner to be configured in HTTP server"
  default     = "/home/webmaster"
}

#Variable : LAMPNode01_httpd_os_users_web_content_owner_ldap_user
variable "LAMPNode01_httpd_os_users_web_content_owner_ldap_user" {
  type        = "string"
  description = "Use LDAP to authenticate Web Content Owner account on Linux HTTP server as well as web site logins"
  default     = "false"
}

#Variable : LAMPNode01_httpd_os_users_web_content_owner_name
variable "LAMPNode01_httpd_os_users_web_content_owner_name" {
  type        = "string"
  description = "User ID of web content owner to be configured in HTTP server"
  default     = "webmaster"
}

#Variable : LAMPNode01_httpd_os_users_web_content_owner_shell
variable "LAMPNode01_httpd_os_users_web_content_owner_shell" {
  type        = "string"
  description = "Default shell configured on Linux server"
  default     = "/bin/bash"
}

#Variable : LAMPNode01_httpd_php_mod_enabled
variable "LAMPNode01_httpd_php_mod_enabled" {
  type        = "string"
  description = "Enable PHP in Apache on Linux by Loading the Module"
  default     = "true"
}

#Variable : LAMPNode01_httpd_server_admin
variable "LAMPNode01_httpd_server_admin" {
  type        = "string"
  description = "Email Address of the Webmaster"
  default     = "webmaster@orpheus.ibm.com"
}

#Variable : LAMPNode01_httpd_server_name
variable "LAMPNode01_httpd_server_name" {
  type        = "string"
  description = "The Name of the HTTP Server, normally the FQDN of server."
  default     = "orpheus.ibm.com"
}

#Variable : LAMPNode01_httpd_version
variable "LAMPNode01_httpd_version" {
  type        = "string"
  description = "Version of HTTP Server to be installed."
  default     = "2.4"
}

#Variable : LAMPNode01_httpd_vhosts_enabled
variable "LAMPNode01_httpd_vhosts_enabled" {
  type        = "string"
  description = "Allow to configure virtual hosts to run multiple websites on the same HTTP server"
  default     = "false"
}

#Variable : LAMPNode01_mysql_config_data_dir
variable "LAMPNode01_mysql_config_data_dir" {
  type        = "string"
  description = "Directory to store information managed by MySQL server"
  default     = "/var/lib/mysql"
}

#Variable : LAMPNode01_mysql_config_databases_database_1_database_name
variable "LAMPNode01_mysql_config_databases_database_1_database_name" {
  type        = "string"
  description = "Create a sample database in MySQL"
  default     = "default_database"
}

#Variable : LAMPNode01_mysql_config_databases_database_1_users_user_1_name
variable "LAMPNode01_mysql_config_databases_database_1_users_user_1_name" {
  type        = "string"
  description = "Name of the first user which is created and allowed to access the created sample database "
  default     = "defaultUser"
}

#Variable : LAMPNode01_mysql_config_databases_database_1_users_user_1_password
variable "LAMPNode01_mysql_config_databases_database_1_users_user_1_password" {
  type        = "string"
  description = "Name of the first user which is created and allowed to access the created sample database"
}

#Variable : LAMPNode01_mysql_config_databases_database_1_users_user_2_password
variable "LAMPNode01_mysql_config_databases_database_1_users_user_2_password" {
  type        = "string"
  description = "Password of the second user"
}

#Variable : LAMPNode01_mysql_config_log_file
variable "LAMPNode01_mysql_config_log_file" {
  type        = "string"
  description = "Log file configured in MySQL"
  default     = "/var/log/mysqld.log"
}

#Variable : LAMPNode01_mysql_config_port
variable "LAMPNode01_mysql_config_port" {
  type        = "string"
  description = "Listen port to be configured in MySQL"
  default     = "3306"
}

#Variable : LAMPNode01_mysql_install_from_repo
variable "LAMPNode01_mysql_install_from_repo" {
  type        = "string"
  description = "Install MySQL from secure repository server or yum repo"
  default     = "true"
}

#Variable : LAMPNode01_mysql_os_users_daemon_gid
variable "LAMPNode01_mysql_os_users_daemon_gid" {
  type        = "string"
  description = "Group ID of the default OS user to be used to configure MySQL"
  default     = "mysql"
}

#Variable : LAMPNode01_mysql_os_users_daemon_home
variable "LAMPNode01_mysql_os_users_daemon_home" {
  type        = "string"
  description = "Home directory of the default OS user to be used to configure MySQL"
  default     = "/home/mysql"
}

#Variable : LAMPNode01_mysql_os_users_daemon_ldap_user
variable "LAMPNode01_mysql_os_users_daemon_ldap_user" {
  type        = "string"
  description = "A flag which indicates whether to create the MQ USer locally, or utilise an LDAP based user."
  default     = "false"
}

#Variable : LAMPNode01_mysql_os_users_daemon_name
variable "LAMPNode01_mysql_os_users_daemon_name" {
  type        = "string"
  description = "User Name of the default OS user to be used to configure MySQL"
  default     = "mysql"
}

#Variable : LAMPNode01_mysql_os_users_daemon_shell
variable "LAMPNode01_mysql_os_users_daemon_shell" {
  type        = "string"
  description = "Default shell configured on Linux server"
  default     = "/bin/bash"
}

#Variable : LAMPNode01_mysql_root_password
variable "LAMPNode01_mysql_root_password" {
  type        = "string"
  description = "The password for the MySQL root user"
}

#Variable : LAMPNode01_mysql_version
variable "LAMPNode01_mysql_version" {
  type        = "string"
  description = "MySQL Version to be installed"
  default     = "5.7.17"
}

##### virtualmachine variables #####
#Variable : LAMPNode01-flavor
variable "LAMPNode01-flavor" {
  type        = "string"
  description = "LAMPNode01 Flavor"
  default     = "t2.medium"
}

#Variable : LAMPNode01-mgmt-network-public
variable "LAMPNode01-mgmt-network-public" {
  type        = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
  default     = "true"
}

##### domain name #####
variable "runtime_domain" {
  description = "domain name"
  default     = "cam.ibm.com"
}

#########################################################
##### Resource : LAMPNode01
#########################################################

#Parameter : LAMPNode01_subnet_name
data "aws_subnet" "LAMPNode01_selected_subnet" {
  filter {
    name   = "tag:Name"
    values = ["${var.LAMPNode01_subnet_name}"]
  }
}

variable "LAMPNode01_subnet_name" {
  type        = "string"
  description = "AWS Subnet Name"
}

#Parameter : LAMPNode01_associate_public_ip_address
variable "LAMPNode01_associate_public_ip_address" {
  type        = "string"
  description = "AWS assign a public IP to instance"
  default     = "true"
}

#Parameter : LAMPNode01_root_block_device_volume_type
variable "LAMPNode01_root_block_device_volume_type" {
  type        = "string"
  description = "AWS Root Block Device Volume Type"
  default     = "gp2"
}

#Parameter : LAMPNode01_root_block_device_volume_size
variable "LAMPNode01_root_block_device_volume_size" {
  type        = "string"
  description = "AWS Root Block Device Volume Size"
  default     = "100"
}

#Parameter : LAMPNode01_root_block_device_delete_on_termination
variable "LAMPNode01_root_block_device_delete_on_termination" {
  type        = "string"
  description = "AWS Root Block Device Delete on Termination"
  default     = "true"
}

resource "aws_instance" "LAMPNode01" {
  ami                         = "${data.aws_ami.LAMPNode01_ami.id}"
  instance_type               = "${var.LAMPNode01-flavor}"
  key_name                    = "${var.ibm_pm_public_ssh_key_name}"
  vpc_security_group_ids      = ["${data.aws_security_group.aws_sg_camc_name_selected.id}"]
  subnet_id                   = "${data.aws_subnet.LAMPNode01_selected_subnet.id}"
  associate_public_ip_address = "${var.LAMPNode01_associate_public_ip_address}"

  tags {
    Name = "${var.LAMPNode01-name}"
  }

  # Specify the ssh connection
  connection {
    user        = "${var.LAMPNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "LAMPNode01_add_ssh_key.sh"

    content = <<EOF
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
      "bash -c 'chmod +x LAMPNode01_add_ssh_key.sh'",
      "bash -c './LAMPNode01_add_ssh_key.sh  \"${var.LAMPNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> LAMPNode01_add_ssh_key.log 2>&1'",
    ]
  }

  root_block_device {
    volume_type = "${var.LAMPNode01_root_block_device_volume_type}"
    volume_size = "${var.LAMPNode01_root_block_device_volume_size}"

    #iops = "${var.LAMPNode01_root_block_device_iops}"
    delete_on_termination = "${var.LAMPNode01_root_block_device_delete_on_termination}"
  }

  user_data = "${data.template_cloudinit_config.LAMPNode01_init.rendered}"
}

data "template_cloudinit_config" "LAMPNode01_init" {
  part {
    content_type = "text/cloud-config"

    content = <<EOF
hostname: ${var.LAMPNode01-name}.${var.runtime_domain}
fqdn: ${var.LAMPNode01-name}.${var.runtime_domain}
manage_etc_hosts: false
EOF
  }
}

#########################################################
##### Resource : LAMPNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "LAMPNode01_chef_bootstrap_comp" {
  depends_on      = ["camc_vaultitem.VaultItem", "aws_instance.LAMPNode01"]
  name            = "LAMPNode01_chef_bootstrap_comp"
  camc_endpoint   = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

  data = <<EOT
{
  "os_admin_user": "${var.LAMPNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.LAMPNode01-mgmt-network-public == "false" ? aws_instance.LAMPNode01.private_ip : aws_instance.LAMPNode01.public_ip}",
  "node_name": "${var.LAMPNode01-name}",
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
##### Resource : LAMPNode01_httpd24-base-install
#########################################################

resource "camc_softwaredeploy" "LAMPNode01_httpd24-base-install" {
  depends_on      = ["camc_bootstrap.LAMPNode01_chef_bootstrap_comp"]
  name            = "LAMPNode01_httpd24-base-install"
  camc_endpoint   = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

  data = <<EOT
{
  "os_admin_user": "${var.LAMPNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.LAMPNode01-mgmt-network-public == "false" ? aws_instance.LAMPNode01.private_ip : aws_instance.LAMPNode01.public_ip}",
  "node_name": "${var.LAMPNode01-name}",
  "runlist": "role[httpd24-base-install]",
  "node_attributes": {
    "httpd": {
      "data_dir_mode": "${var.LAMPNode01_httpd_data_dir_mode}",
      "document_root": "${var.LAMPNode01_httpd_document_root}",
      "listen": "${var.LAMPNode01_httpd_listen}",
      "log_dir": "${var.LAMPNode01_httpd_log_dir}",
      "log_level": "${var.LAMPNode01_httpd_log_level}",
      "os_users": {
        "web_content_owner": {
          "gid": "${var.LAMPNode01_httpd_os_users_web_content_owner_gid}",
          "home": "${var.LAMPNode01_httpd_os_users_web_content_owner_home}",
          "ldap_user": "${var.LAMPNode01_httpd_os_users_web_content_owner_ldap_user}",
          "name": "${var.LAMPNode01_httpd_os_users_web_content_owner_name}",
          "shell": "${var.LAMPNode01_httpd_os_users_web_content_owner_shell}"
        }
      },
      "php_mod_enabled": "${var.LAMPNode01_httpd_php_mod_enabled}",
      "server_admin": "${var.LAMPNode01_httpd_server_admin}",
      "server_name": "${var.LAMPNode01_httpd_server_name}",
      "version": "${var.LAMPNode01_httpd_version}",
      "vhosts_enabled": "${var.LAMPNode01_httpd_vhosts_enabled}"
    },
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[httpd24-base-install]"
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
##### Resource : LAMPNode01_oracle_mysql_base
#########################################################

resource "camc_softwaredeploy" "LAMPNode01_oracle_mysql_base" {
  depends_on      = ["camc_softwaredeploy.LAMPNode01_httpd24-base-install"]
  name            = "LAMPNode01_oracle_mysql_base"
  camc_endpoint   = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

  data = <<EOT
{
  "os_admin_user": "${var.LAMPNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.LAMPNode01-mgmt-network-public == "false" ? aws_instance.LAMPNode01.private_ip : aws_instance.LAMPNode01.public_ip}",
  "node_name": "${var.LAMPNode01-name}",
  "runlist": "role[oracle_mysql_base]",
  "node_attributes": {
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[oracle_mysql_base]"
    },
    "mysql": {
      "config": {
        "data_dir": "${var.LAMPNode01_mysql_config_data_dir}",
        "databases": {
          "database_1": {
            "database_name": "${var.LAMPNode01_mysql_config_databases_database_1_database_name}",
            "users": {
              "user_1": {
                "name": "${var.LAMPNode01_mysql_config_databases_database_1_users_user_1_name}"
              }
            }
          }
        },
        "log_file": "${var.LAMPNode01_mysql_config_log_file}",
        "port": "${var.LAMPNode01_mysql_config_port}"
      },
      "install_from_repo": "${var.LAMPNode01_mysql_install_from_repo}",
      "os_users": {
        "daemon": {
          "gid": "${var.LAMPNode01_mysql_os_users_daemon_gid}",
          "home": "${var.LAMPNode01_mysql_os_users_daemon_home}",
          "ldap_user": "${var.LAMPNode01_mysql_os_users_daemon_ldap_user}",
          "name": "${var.LAMPNode01_mysql_os_users_daemon_name}",
          "shell": "${var.LAMPNode01_mysql_os_users_daemon_shell}"
        }
      },
      "version": "${var.LAMPNode01_mysql_version}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "ibm": {
        "sw_repo_password": "${var.ibm_sw_repo_password}"
      },
      "mysql": {
        "config": {
          "databases": {
            "database_1": {
              "users": {
                "user_1": {
                  "password": "${var.LAMPNode01_mysql_config_databases_database_1_users_user_1_password}"
                },
                "user_2": {
                  "password": "${var.LAMPNode01_mysql_config_databases_database_1_users_user_2_password}"
                }
              }
            }
          }
        },
        "root_password": "${var.LAMPNode01_mysql_root_password}"
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
  camc_endpoint   = "${var.ibm_pm_service}/v1/vault_item/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

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

output "LAMPNode01_ip" {
  value = "Private : ${aws_instance.LAMPNode01.private_ip} & Public : ${aws_instance.LAMPNode01.public_ip}"
}

output "LAMPNode01_name" {
  value = "${var.LAMPNode01-name}"
}

output "LAMPNode01_roles" {
  value = "httpd24-base-install,oracle_mysql_base"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}
