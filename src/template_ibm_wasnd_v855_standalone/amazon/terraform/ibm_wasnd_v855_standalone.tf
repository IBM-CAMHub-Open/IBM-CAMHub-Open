# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from ibm_wasnd_v855_standalone

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


##### virtualmachine variables #####
#Variable : WASNode01-flavor
variable "WASNode01-flavor" {
  type = "string"
  description = "WASNode01 Flavor"
}

#Variable : WASNode01-mgmt-network-public
variable "WASNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
}


##### WASNode01 variables #####
data "aws_ami" "WASNode01_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.WASNode01-image}*"]
  }
  owners = ["${var.aws_ami_owner_id}"]
}

#Variable : WASNode01-image
variable "WASNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : WASNode01-name
variable "WASNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : WASNode01-os_admin_user
variable "WASNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : WASNode01_was_install_dir
variable "WASNode01_was_install_dir" {
  type = "string"
  description = "The installation root directory for the WebSphere Application Server product binaries"
}

#Variable : WASNode01_was_java_version
variable "WASNode01_was_java_version" {
  type = "string"
  description = "The Java SDK version that should be installed with the WebSphere Application Server. Example format is 8.0.4.70"
}

#Variable : WASNode01_was_os_users_was_comment
variable "WASNode01_was_os_users_was_comment" {
  type = "string"
  description = "Comment that will be added when creating the userid"
}

#Variable : WASNode01_was_os_users_was_gid
variable "WASNode01_was_os_users_was_gid" {
  type = "string"
  description = "Operating system group name that will be assigned to the product installation"
}

#Variable : WASNode01_was_os_users_was_home
variable "WASNode01_was_os_users_was_home" {
  type = "string"
  description = "Home directory location for operating system user that is used for product installation"
}

#Variable : WASNode01_was_os_users_was_ldap_user
variable "WASNode01_was_os_users_was_ldap_user" {
  type = "string"
  description = "A flag which indicates whether to create the WebSphere user locally, or utilize an LDAP based user"
}

#Variable : WASNode01_was_os_users_was_name
variable "WASNode01_was_os_users_was_name" {
  type = "string"
  description = "Operating system userid that will be used to install the product. Userid will be created if it does not exist"
}

#Variable : WASNode01_was_profile_dir
variable "WASNode01_was_profile_dir" {
  type = "string"
  description = "The directory path that contains WebSphere Application Server profiles"
}

#Variable : WASNode01_was_profiles_standalone_profiles_standalone1_cell
variable "WASNode01_was_profiles_standalone_profiles_standalone1_cell" {
  type = "string"
  description = "Cell name for the application server"
}

#Variable : WASNode01_was_profiles_standalone_profiles_standalone1_keystorepassword
variable "WASNode01_was_profiles_standalone_profiles_standalone1_keystorepassword" {
  type = "string"
  description = "Specifies the password to use on all keystore files created during profile creation"
}

#Variable : WASNode01_was_profiles_standalone_profiles_standalone1_profile
variable "WASNode01_was_profiles_standalone_profiles_standalone1_profile" {
  type = "string"
  description = "Application server profile name"
}

#Variable : WASNode01_was_profiles_standalone_profiles_standalone1_server
variable "WASNode01_was_profiles_standalone_profiles_standalone1_server" {
  type = "string"
  description = "Name of the application server"
}

#Variable : WASNode01_was_security_admin_user
variable "WASNode01_was_security_admin_user" {
  type = "string"
  description = "The username for securing the WebSphere adminstrative console"
}

#Variable : WASNode01_was_security_admin_user_pwd
variable "WASNode01_was_security_admin_user_pwd" {
  type = "string"
  description = "The password for the WebSphere administrative account"
}

#Variable : WASNode01_was_version
variable "WASNode01_was_version" {
  type = "string"
  description = "The release and fixpack level of WebSphere Application Server to be installed. Example formats are 8.5.5.12 or 9.0.0.4"
}

#Variable : WASNode01_was_wsadmin_standalone_jvmproperty_property_value_initial
variable "WASNode01_was_wsadmin_standalone_jvmproperty_property_value_initial" {
  type = "string"
  description = "Minimum JVM heap size"
}

#Variable : WASNode01_was_wsadmin_standalone_jvmproperty_property_value_maximum
variable "WASNode01_was_wsadmin_standalone_jvmproperty_property_value_maximum" {
  type = "string"
  description = "Maximum JVM heap size"
}

##### domain name #####
variable "runtime_domain" {
  description = "domain name"
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


#########################################################
##### Resource : WASNode01
#########################################################


#Parameter : WASNode01_subnet_name
data "aws_subnet" "WASNode01_selected_subnet" {
  filter {
    name = "tag:Name"
    values = ["${var.WASNode01_subnet_name}"]
  }
}

variable "WASNode01_subnet_name" {
  type = "string"
  description = "AWS Subnet Name"
}


#Parameter : WASNode01_associate_public_ip_address
variable "WASNode01_associate_public_ip_address" {
  type = "string"
  description = "AWS assign a public IP to instance"
}


#Parameter : WASNode01_root_block_device_volume_type
variable "WASNode01_root_block_device_volume_type" {
  type = "string"
  description = "AWS Root Block Device Volume Type"
}


#Parameter : WASNode01_root_block_device_volume_size
variable "WASNode01_root_block_device_volume_size" {
  type = "string"
  description = "AWS Root Block Device Volume Size"
}


#Parameter : WASNode01_root_block_device_delete_on_termination
variable "WASNode01_root_block_device_delete_on_termination" {
  type = "string"
  description = "AWS Root Block Device Delete on Termination"
}

resource "aws_instance" "WASNode01" {
  ami = "${data.aws_ami.WASNode01_ami.id}"
  instance_type = "${var.WASNode01-flavor}"
  key_name = "${var.ibm_pm_public_ssh_key_name}"
  vpc_security_group_ids = ["${data.aws_security_group.aws_sg_camc_name_selected.id}"]
  subnet_id = "${data.aws_subnet.WASNode01_selected_subnet.id}"
  associate_public_ip_address = "${var.WASNode01_associate_public_ip_address}"
  tags {
    Name = "${var.WASNode01-name}"
  }

  # Specify the ssh connection
  connection {
    user = "${var.WASNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "WASNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x WASNode01_add_ssh_key.sh'",
      "bash -c './WASNode01_add_ssh_key.sh  \"${var.WASNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> WASNode01_add_ssh_key.log 2>&1'"
    ]
  }

  root_block_device {
    volume_type = "${var.WASNode01_root_block_device_volume_type}"
    volume_size = "${var.WASNode01_root_block_device_volume_size}"
    #iops = "${var.WASNode01_root_block_device_iops}"
    delete_on_termination = "${var.WASNode01_root_block_device_delete_on_termination}"
  }

  user_data = "${data.template_cloudinit_config.WASNode01_init.rendered}"
}
data "template_cloudinit_config" "WASNode01_init"  {
  part {
    content_type = "text/cloud-config"
    content = <<EOF
hostname: ${var.WASNode01-name}.${var.runtime_domain}
fqdn: ${var.WASNode01-name}.${var.runtime_domain}
manage_etc_hosts: false
EOF
  }
}

#########################################################
##### Resource : WASNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "WASNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","aws_instance.WASNode01"]
  name = "WASNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.WASNode01-mgmt-network-public == "false" ? aws_instance.WASNode01.private_ip : aws_instance.WASNode01.public_ip}",
  "node_name": "${var.WASNode01-name}",
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
##### Resource : WASNode01_was_create_standalone
#########################################################

resource "camc_softwaredeploy" "WASNode01_was_create_standalone" {
  depends_on = ["camc_softwaredeploy.WASNode01_was_v855_install"]
  name = "WASNode01_was_create_standalone"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.WASNode01-mgmt-network-public == "false" ? aws_instance.WASNode01.private_ip : aws_instance.WASNode01.public_ip}",
  "node_name": "${var.WASNode01-name}",
  "runlist": "role[was_create_standalone]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_standalone]"
    },
    "was": {
      "profiles": {
        "standalone_profiles": {
          "standalone1": {
            "cell": "${var.WASNode01_was_profiles_standalone_profiles_standalone1_cell}",
            "profile": "${var.WASNode01_was_profiles_standalone_profiles_standalone1_profile}",
            "server": "${var.WASNode01_was_profiles_standalone_profiles_standalone1_server}"
          }
        }
      },
      "wsadmin": {
        "standalone": {
          "jvmproperty": {
            "property_value_initial": "${var.WASNode01_was_wsadmin_standalone_jvmproperty_property_value_initial}",
            "property_value_maximum": "${var.WASNode01_was_wsadmin_standalone_jvmproperty_property_value_maximum}"
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
              "keystorepassword": "${var.WASNode01_was_profiles_standalone_profiles_standalone1_keystorepassword}"
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
##### Resource : WASNode01_was_v855_install
#########################################################

resource "camc_softwaredeploy" "WASNode01_was_v855_install" {
  depends_on = ["camc_bootstrap.WASNode01_chef_bootstrap_comp"]
  name = "WASNode01_was_v855_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.WASNode01-mgmt-network-public == "false" ? aws_instance.WASNode01.private_ip : aws_instance.WASNode01.public_ip}",
  "node_name": "${var.WASNode01-name}",
  "runlist": "role[was_v855_install]",
  "node_attributes": {
    "ibm": {
      "im_repo": "${var.ibm_im_repo}",
      "im_repo_user": "${var.ibm_im_repo_user}",
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[was_v855_install]"
    },
    "was": {
      "install_dir": "${var.WASNode01_was_install_dir}",
      "java_version": "${var.WASNode01_was_java_version}",
      "os_users": {
        "was": {
          "comment": "${var.WASNode01_was_os_users_was_comment}",
          "gid": "${var.WASNode01_was_os_users_was_gid}",
          "home": "${var.WASNode01_was_os_users_was_home}",
          "ldap_user": "${var.WASNode01_was_os_users_was_ldap_user}",
          "name": "${var.WASNode01_was_os_users_was_name}"
        }
      },
      "profile_dir": "${var.WASNode01_was_profile_dir}",
      "security": {
        "admin_user": "${var.WASNode01_was_security_admin_user}"
      },
      "version": "${var.WASNode01_was_version}"
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
          "admin_user_pwd": "${var.WASNode01_was_security_admin_user_pwd}"
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}

output "WASNode01_ip" {
  value = "Private : ${aws_instance.WASNode01.private_ip} & Public : ${aws_instance.WASNode01.public_ip}"
}

output "WASNode01_name" {
  value = "${var.WASNode01-name}"
}

output "WASNode01_roles" {
  value = "was_create_standalone,was_v855_install"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

