# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from ibm_mq_v9_standalone

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


##### MQNode01 variables #####
data "aws_ami" "MQNode01_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.MQNode01-image}*"]
  }
  owners = ["${var.aws_ami_owner_id}"]
}

#Variable : MQNode01-image
variable "MQNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : MQNode01-name
variable "MQNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : MQNode01-os_admin_user
variable "MQNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : MQNode01_wmq_advanced
variable "MQNode01_wmq_advanced" {
  type = "string"
  description = "Install IBM MQ Advanced components: File Transfer, IBM MQ Telemetry, and Advanced Message Security."
}

#Variable : MQNode01_wmq_fixpack
variable "MQNode01_wmq_fixpack" {
  type = "string"
  description = "The fixpack of IBM MQ to install."
}

#Variable : MQNode01_wmq_net_core_rmem_default
variable "MQNode01_wmq_net_core_rmem_default" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_core_rmem_default"
}

#Variable : MQNode01_wmq_net_core_rmem_max
variable "MQNode01_wmq_net_core_rmem_max" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_core_rmem_max"
}

#Variable : MQNode01_wmq_net_core_wmem_default
variable "MQNode01_wmq_net_core_wmem_default" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_core_wmem_default"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_fin_timeout
variable "MQNode01_wmq_net_ipv4_tcp_fin_timeout" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_fin_timeout"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_keepalive_intvl
variable "MQNode01_wmq_net_ipv4_tcp_keepalive_intvl" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_intvl"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_keepalive_time
variable "MQNode01_wmq_net_ipv4_tcp_keepalive_time" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_keepalive_time"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_rmem
variable "MQNode01_wmq_net_ipv4_tcp_rmem" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_rmem"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_sack
variable "MQNode01_wmq_net_ipv4_tcp_sack" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_sack"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_timestamps
variable "MQNode01_wmq_net_ipv4_tcp_timestamps" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_timestamps"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_window_scaling
variable "MQNode01_wmq_net_ipv4_tcp_window_scaling" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_window_scaling"
}

#Variable : MQNode01_wmq_net_ipv4_tcp_wmem
variable "MQNode01_wmq_net_ipv4_tcp_wmem" {
  type = "string"
  description = "WebSphere MQ Server Kernel Configuration net_ipv4_tcp_wmem"
}

#Variable : MQNode01_wmq_perms
variable "MQNode01_wmq_perms" {
  type = "string"
  description = "Default permissions for IBM MQ files on Unix"
}

#Variable : MQNode01_wmq_qmgr_qmgr1_description
variable "MQNode01_wmq_qmgr_qmgr1_description" {
  type = "string"
  description = "Description of the Queue Manager"
}

#Variable : MQNode01_wmq_qmgr_qmgr1_dlq
variable "MQNode01_wmq_qmgr_qmgr1_dlq" {
  type = "string"
  description = "Queue Manager dead letter queue"
}

#Variable : MQNode01_wmq_qmgr_qmgr1_listener_port
variable "MQNode01_wmq_qmgr_qmgr1_listener_port" {
  type = "string"
  description = "Port the Queue Manager listens on."
}

#Variable : MQNode01_wmq_qmgr_qmgr1_loggingtype
variable "MQNode01_wmq_qmgr_qmgr1_loggingtype" {
  type = "string"
  description = "Type of logging to use ll(Linear), lc(Circular)"
}

#Variable : MQNode01_wmq_qmgr_qmgr1_logsize
variable "MQNode01_wmq_qmgr_qmgr1_logsize" {
  type = "string"
  description = "Size of the IBM MQ Logs"
}

#Variable : MQNode01_wmq_qmgr_qmgr1_name
variable "MQNode01_wmq_qmgr_qmgr1_name" {
  type = "string"
  description = "Name of the Queue Manager to Create"
}

#Variable : MQNode01_wmq_qmgr_qmgr1_primarylogs
variable "MQNode01_wmq_qmgr_qmgr1_primarylogs" {
  type = "string"
  description = "Number of primary logs to create."
}

#Variable : MQNode01_wmq_qmgr_qmgr1_secondarylogs
variable "MQNode01_wmq_qmgr_qmgr1_secondarylogs" {
  type = "string"
  description = "Number of Secondary Logs"
}

#Variable : MQNode01_wmq_service_name
variable "MQNode01_wmq_service_name" {
  type = "string"
  description = "WebSphere MQ service name"
}

#Variable : MQNode01_wmq_swap_file
variable "MQNode01_wmq_swap_file" {
  type = "string"
  description = "Swap file name"
}

#Variable : MQNode01_wmq_swap_file_size
variable "MQNode01_wmq_swap_file_size" {
  type = "string"
  description = "UNIX Swap size in megabytes"
}

#Variable : MQNode01_wmq_version
variable "MQNode01_wmq_version" {
  type = "string"
  description = "The Version of IBM MQ to install, eg, 8.0"
}


##### virtualmachine variables #####
#Variable : MQNode01-flavor
variable "MQNode01-flavor" {
  type = "string"
  description = "MQNode01 Flavor"
}

#Variable : MQNode01-mgmt-network-public
variable "MQNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
}

##### domain name #####
variable "runtime_domain" {
  description = "domain name"
}


#########################################################
##### Resource : MQNode01
#########################################################


#Parameter : MQNode01_subnet_name
data "aws_subnet" "MQNode01_selected_subnet" {
  filter {
    name = "tag:Name"
    values = ["${var.MQNode01_subnet_name}"]
  }
}

variable "MQNode01_subnet_name" {
  type = "string"
  description = "AWS Subnet Name"
}


#Parameter : MQNode01_associate_public_ip_address
variable "MQNode01_associate_public_ip_address" {
  type = "string"
  description = "AWS assign a public IP to instance"
}


#Parameter : MQNode01_root_block_device_volume_type
variable "MQNode01_root_block_device_volume_type" {
  type = "string"
  description = "AWS Root Block Device Volume Type"
}


#Parameter : MQNode01_root_block_device_volume_size
variable "MQNode01_root_block_device_volume_size" {
  type = "string"
  description = "AWS Root Block Device Volume Size"
}


#Parameter : MQNode01_root_block_device_delete_on_termination
variable "MQNode01_root_block_device_delete_on_termination" {
  type = "string"
  description = "AWS Root Block Device Delete on Termination"
}

resource "aws_instance" "MQNode01" {
  ami = "${data.aws_ami.MQNode01_ami.id}"
  instance_type = "${var.MQNode01-flavor}"
  key_name = "${var.ibm_pm_public_ssh_key_name}"
  vpc_security_group_ids = ["${data.aws_security_group.aws_sg_camc_name_selected.id}"]
  subnet_id = "${data.aws_subnet.MQNode01_selected_subnet.id}"
  associate_public_ip_address = "${var.MQNode01_associate_public_ip_address}"
  tags {
    Name = "${var.MQNode01-name}"
  }

  # Specify the ssh connection
  connection {
    user = "${var.MQNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "MQNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x MQNode01_add_ssh_key.sh'",
      "bash -c './MQNode01_add_ssh_key.sh  \"${var.MQNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> MQNode01_add_ssh_key.log 2>&1'"
    ]
  }

  root_block_device {
    volume_type = "${var.MQNode01_root_block_device_volume_type}"
    volume_size = "${var.MQNode01_root_block_device_volume_size}"
    #iops = "${var.MQNode01_root_block_device_iops}"
    delete_on_termination = "${var.MQNode01_root_block_device_delete_on_termination}"
  }

  user_data = "${data.template_cloudinit_config.MQNode01_init.rendered}"
}
data "template_cloudinit_config" "MQNode01_init"  {
  part {
    content_type = "text/cloud-config"
    content = <<EOF
hostname: ${var.MQNode01-name}.${var.runtime_domain}
fqdn: ${var.MQNode01-name}.${var.runtime_domain}
manage_etc_hosts: false
EOF
  }
}

#########################################################
##### Resource : MQNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "MQNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","aws_instance.MQNode01"]
  name = "MQNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.MQNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.MQNode01-mgmt-network-public == "false" ? aws_instance.MQNode01.private_ip : aws_instance.MQNode01.public_ip}",
  "node_name": "${var.MQNode01-name}",
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
##### Resource : MQNode01_wmq_create_qmgrs
#########################################################

resource "camc_softwaredeploy" "MQNode01_wmq_create_qmgrs" {
  depends_on = ["camc_softwaredeploy.MQNode01_wmq_v9_install"]
  name = "MQNode01_wmq_create_qmgrs"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.MQNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.MQNode01-mgmt-network-public == "false" ? aws_instance.MQNode01.private_ip : aws_instance.MQNode01.public_ip}",
  "node_name": "${var.MQNode01-name}",
  "runlist": "role[wmq_create_qmgrs]",
  "node_attributes": {
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[wmq_create_qmgrs]"
    },
    "wmq": {
      "qmgr": {
        "qmgr1": {
          "description": "${var.MQNode01_wmq_qmgr_qmgr1_description}",
          "dlq": "${var.MQNode01_wmq_qmgr_qmgr1_dlq}",
          "listener_port": "${var.MQNode01_wmq_qmgr_qmgr1_listener_port}",
          "loggingtype": "${var.MQNode01_wmq_qmgr_qmgr1_loggingtype}",
          "logsize": "${var.MQNode01_wmq_qmgr_qmgr1_logsize}",
          "name": "${var.MQNode01_wmq_qmgr_qmgr1_name}",
          "primarylogs": "${var.MQNode01_wmq_qmgr_qmgr1_primarylogs}",
          "secondarylogs": "${var.MQNode01_wmq_qmgr_qmgr1_secondarylogs}"
        }
      }
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
##### Resource : MQNode01_wmq_v9_install
#########################################################

resource "camc_softwaredeploy" "MQNode01_wmq_v9_install" {
  depends_on = ["camc_bootstrap.MQNode01_chef_bootstrap_comp"]
  name = "MQNode01_wmq_v9_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.MQNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.MQNode01-mgmt-network-public == "false" ? aws_instance.MQNode01.private_ip : aws_instance.MQNode01.public_ip}",
  "node_name": "${var.MQNode01-name}",
  "runlist": "role[wmq_v9_install]",
  "node_attributes": {
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_auth": "true",
      "sw_repo_self_signed_cert": "true",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[wmq_v9_install]"
    },
    "wmq": {
      "advanced": "${var.MQNode01_wmq_advanced}",
      "fixpack": "${var.MQNode01_wmq_fixpack}",
      "net_core_rmem_default": "${var.MQNode01_wmq_net_core_rmem_default}",
      "net_core_rmem_max": "${var.MQNode01_wmq_net_core_rmem_max}",
      "net_core_wmem_default": "${var.MQNode01_wmq_net_core_wmem_default}",
      "net_ipv4_tcp_fin_timeout": "${var.MQNode01_wmq_net_ipv4_tcp_fin_timeout}",
      "net_ipv4_tcp_keepalive_intvl": "${var.MQNode01_wmq_net_ipv4_tcp_keepalive_intvl}",
      "net_ipv4_tcp_keepalive_time": "${var.MQNode01_wmq_net_ipv4_tcp_keepalive_time}",
      "net_ipv4_tcp_rmem": "${var.MQNode01_wmq_net_ipv4_tcp_rmem}",
      "net_ipv4_tcp_sack": "${var.MQNode01_wmq_net_ipv4_tcp_sack}",
      "net_ipv4_tcp_timestamps": "${var.MQNode01_wmq_net_ipv4_tcp_timestamps}",
      "net_ipv4_tcp_window_scaling": "${var.MQNode01_wmq_net_ipv4_tcp_window_scaling}",
      "net_ipv4_tcp_wmem": "${var.MQNode01_wmq_net_ipv4_tcp_wmem}",
      "perms": "${var.MQNode01_wmq_perms}",
      "service_name": "${var.MQNode01_wmq_service_name}",
      "swap_file": "${var.MQNode01_wmq_swap_file}",
      "swap_file_size": "${var.MQNode01_wmq_swap_file_size}",
      "version": "${var.MQNode01_wmq_version}"
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

output "MQNode01_ip" {
  value = "Private : ${aws_instance.MQNode01.private_ip} & Public : ${aws_instance.MQNode01.public_ip}"
}

output "MQNode01_name" {
  value = "${var.MQNode01-name}"
}

output "MQNode01_roles" {
  value = "wmq_create_qmgrs,wmq_v9_install"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

