# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from oracle_mysql_v57_standalone

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

variable "aws_ami_owner_id" {
  description = "AWS AMI Owner ID"
}

variable "aws_region" {
  description = "AWS Region Name"
}

##############################################################
# Define the aws provider 
##############################################################
provider "aws" {
  region = "${var.aws_region}"
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
    name = "tag:Name"
    values = ["${var.aws_vpc_name}"]
  }
}

#Parameter : aws_vpc_name
variable "aws_vpc_name" {
  description = "AWS VPC Name"
}

data "aws_security_group" "aws_sg_camc_name_selected" {
  name = "${var.aws_sg_camc_name}"
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


##### MySQLNode01 variables #####
data "aws_ami" "MySQLNode01_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.MySQLNode01-image}*"]
  }
  owners = ["${var.aws_ami_owner_id}"]
}

#Variable : MySQLNode01-image
variable "MySQLNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : MySQLNode01-name
variable "MySQLNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : MySQLNode01-os_admin_user
variable "MySQLNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : MySQLNode01_mysql_config_data_dir
variable "MySQLNode01_mysql_config_data_dir" {
  type = "string"
  description = "Directory to store information managed by MySQL server"
}

#Variable : MySQLNode01_mysql_config_databases_database_1_database_name
variable "MySQLNode01_mysql_config_databases_database_1_database_name" {
  type = "string"
  description = "Create a sample database in MySQL"
}

#Variable : MySQLNode01_mysql_config_databases_database_1_users_user_1_name
variable "MySQLNode01_mysql_config_databases_database_1_users_user_1_name" {
  type = "string"
  description = "Name of the first user which is created and allowed to access the created sample database "
}

#Variable : MySQLNode01_mysql_config_databases_database_1_users_user_1_password
variable "MySQLNode01_mysql_config_databases_database_1_users_user_1_password" {
  type = "string"
  description = "Name of the second user which is created and allowed to access the created sample database"
}

#Variable : MySQLNode01_mysql_config_databases_database_1_users_user_2_password
variable "MySQLNode01_mysql_config_databases_database_1_users_user_2_password" {
  type = "string"
  description = "Password of the second user"
}

#Variable : MySQLNode01_mysql_config_log_file
variable "MySQLNode01_mysql_config_log_file" {
  type = "string"
  description = "Log file configured in MySQL"
}

#Variable : MySQLNode01_mysql_config_port
variable "MySQLNode01_mysql_config_port" {
  type = "string"
  description = "Listen port to be configured in MySQL"
}

#Variable : MySQLNode01_mysql_install_from_repo
variable "MySQLNode01_mysql_install_from_repo" {
  type = "string"
  description = "Install MySQL from secure repository server or yum repo"
}

#Variable : MySQLNode01_mysql_os_users_daemon_gid
variable "MySQLNode01_mysql_os_users_daemon_gid" {
  type = "string"
  description = "Group ID of the default OS user to be used to configure MySQL"
}

#Variable : MySQLNode01_mysql_os_users_daemon_home
variable "MySQLNode01_mysql_os_users_daemon_home" {
  type = "string"
  description = "Home directory of the default OS user to be used to configure MySQL"
}

#Variable : MySQLNode01_mysql_os_users_daemon_ldap_user
variable "MySQLNode01_mysql_os_users_daemon_ldap_user" {
  type = "string"
  description = "A flag which indicates whether to create the MQ USer locally, or utilise an LDAP based user."
}

#Variable : MySQLNode01_mysql_os_users_daemon_name
variable "MySQLNode01_mysql_os_users_daemon_name" {
  type = "string"
  description = "User Name of the default OS user to be used to configure MySQL"
}

#Variable : MySQLNode01_mysql_os_users_daemon_shell
variable "MySQLNode01_mysql_os_users_daemon_shell" {
  type = "string"
  description = "Default shell configured on Linux server"
}

#Variable : MySQLNode01_mysql_root_password
variable "MySQLNode01_mysql_root_password" {
  type = "string"
  description = "The password for the MySQL root user"
}

#Variable : MySQLNode01_mysql_version
variable "MySQLNode01_mysql_version" {
  type = "string"
  description = "MySQL Version to be installed"
}


##### virtualmachine variables #####
#Variable : MySQLNode01-flavor
variable "MySQLNode01-flavor" {
  type = "string"
  description = "MySQLNode01 Flavor"
}

#Variable : MySQLNode01-mgmt-network-public
variable "MySQLNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
}

##### domain name #####
variable "runtime_domain" {
  description = "domain name"
}


#########################################################
##### Resource : MySQLNode01
#########################################################


#Parameter : MySQLNode01_subnet_name
data "aws_subnet" "MySQLNode01_selected_subnet" {
  filter {
    name = "tag:Name"
    values = ["${var.MySQLNode01_subnet_name}"]
  }
}

variable "MySQLNode01_subnet_name" {
  type = "string"
  description = "AWS Subnet Name"
}


#Parameter : MySQLNode01_associate_public_ip_address
variable "MySQLNode01_associate_public_ip_address" {
  type = "string"
  description = "AWS assign a public IP to instance"
}


#Parameter : MySQLNode01_root_block_device_volume_type
variable "MySQLNode01_root_block_device_volume_type" {
  type = "string"
  description = "AWS Root Block Device Volume Type"
}


#Parameter : MySQLNode01_root_block_device_volume_size
variable "MySQLNode01_root_block_device_volume_size" {
  type = "string"
  description = "AWS Root Block Device Volume Size"
}


#Parameter : MySQLNode01_root_block_device_delete_on_termination
variable "MySQLNode01_root_block_device_delete_on_termination" {
  type = "string"
  description = "AWS Root Block Device Delete on Termination"
}

resource "aws_instance" "MySQLNode01" {
  ami = "${data.aws_ami.MySQLNode01_ami.id}"
  instance_type = "${var.MySQLNode01-flavor}"
  key_name = "${var.ibm_pm_public_ssh_key_name}"
  vpc_security_group_ids = ["${data.aws_security_group.aws_sg_camc_name_selected.id}"]
  subnet_id = "${data.aws_subnet.MySQLNode01_selected_subnet.id}"
  associate_public_ip_address = "${var.MySQLNode01_associate_public_ip_address}"
  tags {
    Name = "${var.MySQLNode01-name}"
  }

  # Specify the ssh connection
  connection {
    user = "${var.MySQLNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "MySQLNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x MySQLNode01_add_ssh_key.sh'",
      "bash -c './MySQLNode01_add_ssh_key.sh  \"${var.MySQLNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> MySQLNode01_add_ssh_key.log 2>&1'"
    ]
  }

  root_block_device {
    volume_type = "${var.MySQLNode01_root_block_device_volume_type}"
    volume_size = "${var.MySQLNode01_root_block_device_volume_size}"
    #iops = "${var.MySQLNode01_root_block_device_iops}"
    delete_on_termination = "${var.MySQLNode01_root_block_device_delete_on_termination}"
  }

  user_data = "${data.template_cloudinit_config.MySQLNode01_init.rendered}"
}
data "template_cloudinit_config" "MySQLNode01_init"  {
  part {
    content_type = "text/cloud-config"
    content = <<EOF
hostname: ${var.MySQLNode01-name}.${var.runtime_domain}
fqdn: ${var.MySQLNode01-name}.${var.runtime_domain}
manage_etc_hosts: false
EOF
  }
}

#########################################################
##### Resource : MySQLNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "MySQLNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","aws_instance.MySQLNode01"]
  name = "MySQLNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.MySQLNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.MySQLNode01-mgmt-network-public == "false" ? aws_instance.MySQLNode01.private_ip : aws_instance.MySQLNode01.public_ip}",
  "node_name": "${var.MySQLNode01-name}",
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
##### Resource : MySQLNode01_oracle_mysql_base
#########################################################

resource "camc_softwaredeploy" "MySQLNode01_oracle_mysql_base" {
  depends_on = ["camc_bootstrap.MySQLNode01_chef_bootstrap_comp"]
  name = "MySQLNode01_oracle_mysql_base"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.MySQLNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.MySQLNode01-mgmt-network-public == "false" ? aws_instance.MySQLNode01.private_ip : aws_instance.MySQLNode01.public_ip}",
  "node_name": "${var.MySQLNode01-name}",
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
        "data_dir": "${var.MySQLNode01_mysql_config_data_dir}",
        "databases": {
          "database_1": {
            "database_name": "${var.MySQLNode01_mysql_config_databases_database_1_database_name}",
            "users": {
              "user_1": {
                "name": "${var.MySQLNode01_mysql_config_databases_database_1_users_user_1_name}"
              }
            }
          }
        },
        "log_file": "${var.MySQLNode01_mysql_config_log_file}",
        "port": "${var.MySQLNode01_mysql_config_port}"
      },
      "install_from_repo": "${var.MySQLNode01_mysql_install_from_repo}",
      "os_users": {
        "daemon": {
          "gid": "${var.MySQLNode01_mysql_os_users_daemon_gid}",
          "home": "${var.MySQLNode01_mysql_os_users_daemon_home}",
          "ldap_user": "${var.MySQLNode01_mysql_os_users_daemon_ldap_user}",
          "name": "${var.MySQLNode01_mysql_os_users_daemon_name}",
          "shell": "${var.MySQLNode01_mysql_os_users_daemon_shell}"
        }
      },
      "version": "${var.MySQLNode01_mysql_version}"
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
                  "password": "${var.MySQLNode01_mysql_config_databases_database_1_users_user_1_password}"
                },
                "user_2": {
                  "password": "${var.MySQLNode01_mysql_config_databases_database_1_users_user_2_password}"
                }
              }
            }
          }
        },
        "root_password": "${var.MySQLNode01_mysql_root_password}"
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

output "MySQLNode01_ip" {
  value = "Private : ${aws_instance.MySQLNode01.private_ip} & Public : ${aws_instance.MySQLNode01.public_ip}"
}

output "MySQLNode01_name" {
  value = "${var.MySQLNode01-name}"
}

output "MySQLNode01_roles" {
  value = "oracle_mysql_base"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

