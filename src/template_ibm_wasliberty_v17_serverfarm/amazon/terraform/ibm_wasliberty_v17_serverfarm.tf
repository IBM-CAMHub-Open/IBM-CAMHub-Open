# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from ibm_wasliberty_v17_serverfarm

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


##### CentralNode01 variables #####
data "aws_ami" "CentralNode01_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.CentralNode01-image}*"]
  }
  owners = ["${var.aws_ami_owner_id}"]
}

#Variable : CentralNode01-image
variable "CentralNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : CentralNode01-name
variable "CentralNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : CentralNode01-os_admin_user
variable "CentralNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : CentralNode01_ssh_private_key_path
variable "CentralNode01_ssh_private_key_path" {
  type = "string"
  description = "Absolute path of the Liberty private key"
}

#Variable : CentralNode01_was_liberty_base_version
variable "CentralNode01_was_liberty_base_version" {
  type = "string"
  description = "The release and fixpack level for WebSphere Liberty to be installed. Example formats are 8.5.5.11 or 17.0.2"
}

#Variable : CentralNode01_was_liberty_edition
variable "CentralNode01_was_liberty_edition" {
  type = "string"
  description = "Indicates which Liberty offering should be installed. Valid values are: base, core, nd"
}

#Variable : CentralNode01_was_liberty_farm_central_node
variable "CentralNode01_was_liberty_farm_central_node" {
  type = "string"
  description = "Hostname/IP of the liberty node which will gather and merge the plugins. Leave empty when deploying the central node itself"
}

#Variable : CentralNode01_was_liberty_farm_logFileName
variable "CentralNode01_was_liberty_farm_logFileName" {
  type = "string"
  description = "Name of the Liberty farm log file"
}

#Variable : CentralNode01_was_liberty_farm_pluginInstallRoot
variable "CentralNode01_was_liberty_farm_pluginInstallRoot" {
  type = "string"
  description = "pluginInstallRoot"
}

#Variable : CentralNode01_was_liberty_farm_sslCertlabel
variable "CentralNode01_was_liberty_farm_sslCertlabel" {
  type = "string"
  description = "Name of the ssl Cert label which will be added to the keystore"
}

#Variable : CentralNode01_was_liberty_farm_sslKeyringLocation
variable "CentralNode01_was_liberty_farm_sslKeyringLocation" {
  type = "string"
  description = "Full path to the liberty farm ssl Keyring, path must not include the name of the Keyring file"
}

#Variable : CentralNode01_was_liberty_farm_sslStashfileLocation
variable "CentralNode01_was_liberty_farm_sslStashfileLocation" {
  type = "string"
  description = "Full path to the Liberty farm ssl Stashfile, path must not include the name of the stash file"
}

#Variable : CentralNode01_was_liberty_farm_webserverName
variable "CentralNode01_was_liberty_farm_webserverName" {
  type = "string"
  description = "A descriptive name for the web server"
}

#Variable : CentralNode01_was_liberty_farm_webserverPort
variable "CentralNode01_was_liberty_farm_webserverPort" {
  type = "string"
  description = "HTTP Transport port that the webserver is listening on"
}

#Variable : CentralNode01_was_liberty_install_dir
variable "CentralNode01_was_liberty_install_dir" {
  type = "string"
  description = "The installation root directory for the WebSphere Liberty product binaries"
}

#Variable : CentralNode01_was_liberty_install_grp
variable "CentralNode01_was_liberty_install_grp" {
  type = "string"
  description = "Operating system group name that will be assigned to the product installation"
}

#Variable : CentralNode01_was_liberty_install_user
variable "CentralNode01_was_liberty_install_user" {
  type = "string"
  description = "Operating system userid that will be used to install the product. Userid will be created if it does not exist"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_feature
variable "CentralNode01_was_liberty_liberty_servers_server1_feature" {
  type = "string"
  description = "Lists the Liberty features that should be included in the feature manager list. For example, webProfile-7.0 adminCenter-1.0"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_httpport
variable "CentralNode01_was_liberty_liberty_servers_server1_httpport" {
  type = "string"
  description = "HTTP Transport value that will be set in the defaultHttpEndpoint endpoint in server.xml"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_httpsport
variable "CentralNode01_was_liberty_liberty_servers_server1_httpsport" {
  type = "string"
  description = "Secure HTTP Transport value that will be set in the defaultHttpEndpoint endpoint in server.xml"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_keystore_id
variable "CentralNode01_was_liberty_liberty_servers_server1_keystore_id" {
  type = "string"
  description = "Keystore id that will be used when setting up the keyStore attribute in the server.xml"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_keystore_password
variable "CentralNode01_was_liberty_liberty_servers_server1_keystore_password" {
  type = "string"
  description = "Liberty keystore password used to protect the Liberty keystore id, this value will be stored in Chef Vault"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_name
variable "CentralNode01_was_liberty_liberty_servers_server1_name" {
  type = "string"
  description = "Name of the initial Liberty server to be created during provisioning"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_name
variable "CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_name" {
  type = "string"
  description = "Administrative console username used for accessing the console, the associated password is the admin_user password"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_password
variable "CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_password" {
  type = "string"
  description = "Password for the Liberty administrative user name, this value to be stored in the Chef Vault"
}

#Variable : CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_role
variable "CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_role" {
  type = "string"
  description = "Liberty role for which administrative users are to be added to, the admin_user will be added to this role by default"
}

#Variable : CentralNode01_was_liberty_wlp_user_dir
variable "CentralNode01_was_liberty_wlp_user_dir" {
  type = "string"
  description = "Liberty directory which product configuration will be written"
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


##### Image Parameters variables #####

##### LibertyNode01 variables #####
data "aws_ami" "LibertyNode01_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.LibertyNode01-image}*"]
  }
  owners = ["${var.aws_ami_owner_id}"]
}

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

#Variable : LibertyNode01_ssh_private_key_path
variable "LibertyNode01_ssh_private_key_path" {
  type = "string"
  description = "Absolute path of the Liberty private key"
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

#Variable : LibertyNode01_was_liberty_farm_central_node
variable "LibertyNode01_was_liberty_farm_central_node" {
  type = "string"
  description = "Hostname/IP of the liberty node which will gather and merge the plugins. Leave empty when deploying the central node itself"
}

#Variable : LibertyNode01_was_liberty_farm_httpd_user
variable "LibertyNode01_was_liberty_farm_httpd_user" {
  type = "string"
  description = "None"
}

#Variable : LibertyNode01_was_liberty_farm_logFileName
variable "LibertyNode01_was_liberty_farm_logFileName" {
  type = "string"
  description = "Name of the Liberty farm log file"
}

#Variable : LibertyNode01_was_liberty_farm_pluginInstallRoot
variable "LibertyNode01_was_liberty_farm_pluginInstallRoot" {
  type = "string"
  description = "pluginInstallRoot"
}

#Variable : LibertyNode01_was_liberty_farm_sslCertlabel
variable "LibertyNode01_was_liberty_farm_sslCertlabel" {
  type = "string"
  description = "Name of the ssl Cert label which will be added to the keystore"
}

#Variable : LibertyNode01_was_liberty_farm_sslKeyringLocation
variable "LibertyNode01_was_liberty_farm_sslKeyringLocation" {
  type = "string"
  description = "Full path to the liberty farm ssl Keyring, path must not include the name of the Keyring file"
}

#Variable : LibertyNode01_was_liberty_farm_sslStashfileLocation
variable "LibertyNode01_was_liberty_farm_sslStashfileLocation" {
  type = "string"
  description = "Full path to the Liberty farm ssl Stashfile, path must not include the name of the stash file"
}

#Variable : LibertyNode01_was_liberty_farm_webserverName
variable "LibertyNode01_was_liberty_farm_webserverName" {
  type = "string"
  description = "A descriptive name for the web server"
}

#Variable : LibertyNode01_was_liberty_farm_webserverPort
variable "LibertyNode01_was_liberty_farm_webserverPort" {
  type = "string"
  description = "HTTP Transport port that the webserver is listening on"
}

#Variable : LibertyNode01_was_liberty_farm_webserverhost
variable "LibertyNode01_was_liberty_farm_webserverhost" {
  type = "string"
  description = "Host name of the web server, not this DNS name must be resolvable"
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
#Variable : CentralNode01-flavor
variable "CentralNode01-flavor" {
  type = "string"
  description = "CentralNode01 Flavor"
}

#Variable : CentralNode01-mgmt-network-public
variable "CentralNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
}

#Variable : LibertyNode01-flavor
variable "LibertyNode01-flavor" {
  type = "string"
  description = "LibertyNode01 Flavor"
}

#Variable : LibertyNode01-mgmt-network-public
variable "LibertyNode01-mgmt-network-public" {
  type = "string"
  description = "Expose and use public IP of virtual machine for internal communication"
}

##### domain name #####
variable "runtime_domain" {
  description = "domain name"
}


#########################################################
##### Resource : CentralNode01
#########################################################


#Parameter : CentralNode01_subnet_name
data "aws_subnet" "CentralNode01_selected_subnet" {
  filter {
    name = "tag:Name"
    values = ["${var.CentralNode01_subnet_name}"]
  }
}

variable "CentralNode01_subnet_name" {
  type = "string"
  description = "AWS Subnet Name"
}


#Parameter : CentralNode01_associate_public_ip_address
variable "CentralNode01_associate_public_ip_address" {
  type = "string"
  description = "AWS assign a public IP to instance"
}


#Parameter : CentralNode01_root_block_device_volume_type
variable "CentralNode01_root_block_device_volume_type" {
  type = "string"
  description = "AWS Root Block Device Volume Type"
}


#Parameter : CentralNode01_root_block_device_volume_size
variable "CentralNode01_root_block_device_volume_size" {
  type = "string"
  description = "AWS Root Block Device Volume Size"
}


#Parameter : CentralNode01_root_block_device_delete_on_termination
variable "CentralNode01_root_block_device_delete_on_termination" {
  type = "string"
  description = "AWS Root Block Device Delete on Termination"
}

resource "aws_instance" "CentralNode01" {
  ami = "${data.aws_ami.CentralNode01_ami.id}"
  instance_type = "${var.CentralNode01-flavor}"
  key_name = "${var.ibm_pm_public_ssh_key_name}"
  vpc_security_group_ids = ["${data.aws_security_group.aws_sg_camc_name_selected.id}"]
  subnet_id = "${data.aws_subnet.CentralNode01_selected_subnet.id}"
  associate_public_ip_address = "${var.CentralNode01_associate_public_ip_address}"
  tags {
    Name = "${var.CentralNode01-name}"
  }

  # Specify the ssh connection
  connection {
    user = "${var.CentralNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
  }

  provisioner "file" {
    destination = "CentralNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x CentralNode01_add_ssh_key.sh'",
      "bash -c './CentralNode01_add_ssh_key.sh  \"${var.CentralNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> CentralNode01_add_ssh_key.log 2>&1'"
    ]
  }

  root_block_device {
    volume_type = "${var.CentralNode01_root_block_device_volume_type}"
    volume_size = "${var.CentralNode01_root_block_device_volume_size}"
    #iops = "${var.CentralNode01_root_block_device_iops}"
    delete_on_termination = "${var.CentralNode01_root_block_device_delete_on_termination}"
  }

  user_data = "${data.template_cloudinit_config.CentralNode01_init.rendered}"
}
data "template_cloudinit_config" "CentralNode01_init"  {
  part {
    content_type = "text/cloud-config"
    content = <<EOF
hostname: ${var.CentralNode01-name}.${var.runtime_domain}
fqdn: ${var.CentralNode01-name}.${var.runtime_domain}
manage_etc_hosts: false
EOF
  }
}

#########################################################
##### Resource : CentralNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "CentralNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","aws_instance.CentralNode01"]
  name = "CentralNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.CentralNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.CentralNode01-mgmt-network-public == "false" ? aws_instance.CentralNode01.private_ip : aws_instance.CentralNode01.public_ip}",
  "node_name": "${var.CentralNode01-name}",
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
##### Resource : CentralNode01_liberty_create_server
#########################################################

resource "camc_softwaredeploy" "CentralNode01_liberty_create_server" {
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_install","camc_softwaredeploy.CentralNode01_liberty_install"]
  name = "CentralNode01_liberty_create_server"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.CentralNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.CentralNode01-mgmt-network-public == "false" ? aws_instance.CentralNode01.private_ip : aws_instance.CentralNode01.public_ip}",
  "node_name": "${var.CentralNode01-name}",
  "runlist": "role[liberty_create_server]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[liberty_create_server]"
    },
    "was_liberty": {
      "install_dir": "${var.CentralNode01_was_liberty_install_dir}",
      "liberty_servers": {
        "server1": {
          "feature": "${var.CentralNode01_was_liberty_liberty_servers_server1_feature}",
          "httpport": "${var.CentralNode01_was_liberty_liberty_servers_server1_httpport}",
          "httpsport": "${var.CentralNode01_was_liberty_liberty_servers_server1_httpsport}",
          "jvm_params": "-Xms256m -Xmx2048m",
          "keystore_id": "${var.CentralNode01_was_liberty_liberty_servers_server1_keystore_id}",
          "name": "${var.CentralNode01_was_liberty_liberty_servers_server1_name}",
          "users": {
            "admin_user": {
              "name": "${var.CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_name}",
              "role": "${var.CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_role}"
            }
          }
        }
      },
      "wlp_user_dir": "${var.CentralNode01_was_liberty_wlp_user_dir}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "was_liberty": {
        "liberty_servers": {
          "server1": {
            "keystore_password": "${var.CentralNode01_was_liberty_liberty_servers_server1_keystore_password}",
            "users": {
              "admin_user": {
                "password": "${var.CentralNode01_was_liberty_liberty_servers_server1_users_admin_user_password}"
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
##### Resource : CentralNode01_liberty_install
#########################################################

resource "camc_softwaredeploy" "CentralNode01_liberty_install" {
  depends_on = ["camc_bootstrap.LibertyNode01_chef_bootstrap_comp","camc_bootstrap.CentralNode01_chef_bootstrap_comp"]
  name = "CentralNode01_liberty_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.CentralNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.CentralNode01-mgmt-network-public == "false" ? aws_instance.CentralNode01.private_ip : aws_instance.CentralNode01.public_ip}",
  "node_name": "${var.CentralNode01-name}",
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
      "base_version": "${var.CentralNode01_was_liberty_base_version}",
      "edition": "${var.CentralNode01_was_liberty_edition}",
      "install_dir": "${var.CentralNode01_was_liberty_install_dir}",
      "install_grp": "${var.CentralNode01_was_liberty_install_grp}",
      "install_user": "${var.CentralNode01_was_liberty_install_user}",
      "wlp_user_dir": "${var.CentralNode01_was_liberty_wlp_user_dir}"
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
##### Resource : CentralNode01_liberty_plugin_generate
#########################################################

resource "camc_softwaredeploy" "CentralNode01_liberty_plugin_generate" {
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_plugin_merge_setup"]
  name = "CentralNode01_liberty_plugin_generate"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.CentralNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.CentralNode01-mgmt-network-public == "false" ? aws_instance.CentralNode01.private_ip : aws_instance.CentralNode01.public_ip}",
  "node_name": "${var.CentralNode01-name}",
  "runlist": "role[liberty_plugin_generate]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[liberty_plugin_generate]"
    },
    "ssh": {
      "private_key": {
        "path": "${var.CentralNode01_ssh_private_key_path}"
      }
    },
    "was_liberty": {
      "farm": {
        "central_node": "${var.CentralNode01_was_liberty_farm_central_node}",
        "logFileName": "${var.CentralNode01_was_liberty_farm_logFileName}",
        "pluginInstallRoot": "${var.CentralNode01_was_liberty_farm_pluginInstallRoot}",
        "sslCertlabel": "${var.CentralNode01_was_liberty_farm_sslCertlabel}",
        "sslKeyringLocation": "${var.CentralNode01_was_liberty_farm_sslKeyringLocation}",
        "sslStashfileLocation": "${var.CentralNode01_was_liberty_farm_sslStashfileLocation}",
        "webserverName": "${var.CentralNode01_was_liberty_farm_webserverName}",
        "webserverPort": "${var.CentralNode01_was_liberty_farm_webserverPort}"
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : LibertyNode01
#########################################################


#Parameter : LibertyNode01_subnet_name
data "aws_subnet" "LibertyNode01_selected_subnet" {
  filter {
    name = "tag:Name"
    values = ["${var.LibertyNode01_subnet_name}"]
  }
}

variable "LibertyNode01_subnet_name" {
  type = "string"
  description = "AWS Subnet Name"
}


#Parameter : LibertyNode01_associate_public_ip_address
variable "LibertyNode01_associate_public_ip_address" {
  type = "string"
  description = "AWS assign a public IP to instance"
}


#Parameter : LibertyNode01_root_block_device_volume_type
variable "LibertyNode01_root_block_device_volume_type" {
  type = "string"
  description = "AWS Root Block Device Volume Type"
}


#Parameter : LibertyNode01_root_block_device_volume_size
variable "LibertyNode01_root_block_device_volume_size" {
  type = "string"
  description = "AWS Root Block Device Volume Size"
}


#Parameter : LibertyNode01_root_block_device_delete_on_termination
variable "LibertyNode01_root_block_device_delete_on_termination" {
  type = "string"
  description = "AWS Root Block Device Delete on Termination"
}

resource "aws_instance" "LibertyNode01" {
  ami = "${data.aws_ami.LibertyNode01_ami.id}"
  instance_type = "${var.LibertyNode01-flavor}"
  key_name = "${var.ibm_pm_public_ssh_key_name}"
  vpc_security_group_ids = ["${data.aws_security_group.aws_sg_camc_name_selected.id}"]
  subnet_id = "${data.aws_subnet.LibertyNode01_selected_subnet.id}"
  associate_public_ip_address = "${var.LibertyNode01_associate_public_ip_address}"
  tags {
    Name = "${var.LibertyNode01-name}"
  }

  # Specify the ssh connection
  connection {
    user = "${var.LibertyNode01-os_admin_user}"
    private_key = "${base64decode(var.ibm_pm_private_ssh_key)}"
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
      "bash -c 'chmod +x LibertyNode01_add_ssh_key.sh'",
      "bash -c './LibertyNode01_add_ssh_key.sh  \"${var.LibertyNode01-os_admin_user}\" \"${var.user_public_ssh_key}\">> LibertyNode01_add_ssh_key.log 2>&1'"
    ]
  }

  root_block_device {
    volume_type = "${var.LibertyNode01_root_block_device_volume_type}"
    volume_size = "${var.LibertyNode01_root_block_device_volume_size}"
    #iops = "${var.LibertyNode01_root_block_device_iops}"
    delete_on_termination = "${var.LibertyNode01_root_block_device_delete_on_termination}"
  }

  user_data = "${data.template_cloudinit_config.LibertyNode01_init.rendered}"
}
data "template_cloudinit_config" "LibertyNode01_init"  {
  part {
    content_type = "text/cloud-config"
    content = <<EOF
hostname: ${var.LibertyNode01-name}.${var.runtime_domain}
fqdn: ${var.LibertyNode01-name}.${var.runtime_domain}
manage_etc_hosts: false
EOF
  }
}

#########################################################
##### Resource : LibertyNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "LibertyNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","aws_instance.LibertyNode01"]
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
  "host_ip": "${var.LibertyNode01-mgmt-network-public == "false" ? aws_instance.LibertyNode01.private_ip : aws_instance.LibertyNode01.public_ip}",
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
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_install","camc_softwaredeploy.CentralNode01_liberty_install"]
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
  "host_ip": "${var.LibertyNode01-mgmt-network-public == "false" ? aws_instance.LibertyNode01.private_ip : aws_instance.LibertyNode01.public_ip}",
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
  depends_on = ["camc_bootstrap.LibertyNode01_chef_bootstrap_comp","camc_bootstrap.CentralNode01_chef_bootstrap_comp"]
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
  "host_ip": "${var.LibertyNode01-mgmt-network-public == "false" ? aws_instance.LibertyNode01.private_ip : aws_instance.LibertyNode01.public_ip}",
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
##### Resource : LibertyNode01_liberty_plugin_generate
#########################################################

resource "camc_softwaredeploy" "LibertyNode01_liberty_plugin_generate" {
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_plugin_merge_setup"]
  name = "LibertyNode01_liberty_plugin_generate"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.LibertyNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.LibertyNode01-mgmt-network-public == "false" ? aws_instance.LibertyNode01.private_ip : aws_instance.LibertyNode01.public_ip}",
  "node_name": "${var.LibertyNode01-name}",
  "runlist": "role[liberty_plugin_generate]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[liberty_plugin_generate]"
    },
    "ssh": {
      "private_key": {
        "path": "${var.LibertyNode01_ssh_private_key_path}"
      }
    },
    "was_liberty": {
      "farm": {
        "central_node": "${var.LibertyNode01_was_liberty_farm_central_node}",
        "logFileName": "${var.LibertyNode01_was_liberty_farm_logFileName}",
        "pluginInstallRoot": "${var.LibertyNode01_was_liberty_farm_pluginInstallRoot}",
        "sslCertlabel": "${var.LibertyNode01_was_liberty_farm_sslCertlabel}",
        "sslKeyringLocation": "${var.LibertyNode01_was_liberty_farm_sslKeyringLocation}",
        "sslStashfileLocation": "${var.LibertyNode01_was_liberty_farm_sslStashfileLocation}",
        "webserverName": "${var.LibertyNode01_was_liberty_farm_webserverName}",
        "webserverPort": "${var.LibertyNode01_was_liberty_farm_webserverPort}"
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : LibertyNode01_liberty_plugin_merge
#########################################################

resource "camc_softwaredeploy" "LibertyNode01_liberty_plugin_merge" {
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_plugin_generate","camc_softwaredeploy.CentralNode01_liberty_plugin_generate"]
  name = "LibertyNode01_liberty_plugin_merge"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.LibertyNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.LibertyNode01-mgmt-network-public == "false" ? aws_instance.LibertyNode01.private_ip : aws_instance.LibertyNode01.public_ip}",
  "node_name": "${var.LibertyNode01-name}",
  "runlist": "role[liberty_plugin_merge]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[liberty_plugin_merge]"
    },
    "ssh": {
      "private_key": {
        "path": "${var.LibertyNode01_ssh_private_key_path}"
      }
    },
    "was_liberty": {
      "farm": {
        "httpd_plugins_dir": {
          "default": "undefined",
          "description": "undefined",
          "descriptive": "undefined",
          "hidden": "undefined",
          "parm_type": "undefined",
          "precedence_level": "undefined",
          "required": "undefined",
          "secret": "undefined",
          "selectable": "undefined",
          "type": "undefined"
        },
        "httpd_user": "${var.LibertyNode01_was_liberty_farm_httpd_user}",
        "logFileName": "${var.LibertyNode01_was_liberty_farm_logFileName}",
        "pluginInstallRoot": "${var.LibertyNode01_was_liberty_farm_pluginInstallRoot}",
        "sslCertlabel": "${var.LibertyNode01_was_liberty_farm_sslCertlabel}",
        "sslKeyringLocation": "${var.LibertyNode01_was_liberty_farm_sslKeyringLocation}",
        "sslStashfileLocation": "${var.LibertyNode01_was_liberty_farm_sslStashfileLocation}",
        "webserverName": "${var.LibertyNode01_was_liberty_farm_webserverName}",
        "webserverPort": "${var.LibertyNode01_was_liberty_farm_webserverPort}",
        "webserverhost": "${var.LibertyNode01_was_liberty_farm_webserverhost}"
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : LibertyNode01_liberty_plugin_merge_setup
#########################################################

resource "camc_softwaredeploy" "LibertyNode01_liberty_plugin_merge_setup" {
  depends_on = ["camc_softwaredeploy.LibertyNode01_liberty_create_server","camc_softwaredeploy.CentralNode01_liberty_create_server"]
  name = "LibertyNode01_liberty_plugin_merge_setup"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.LibertyNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${var.LibertyNode01-mgmt-network-public == "false" ? aws_instance.LibertyNode01.private_ip : aws_instance.LibertyNode01.public_ip}",
  "node_name": "${var.LibertyNode01-name}",
  "runlist": "role[liberty_plugin_merge_setup]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[liberty_plugin_merge_setup]"
    },
    "ssh": {
      "private_key": {
        "path": "${var.LibertyNode01_ssh_private_key_path}"
      }
    },
    "was_liberty": {
      "farm": {
        "logFileName": "${var.LibertyNode01_was_liberty_farm_logFileName}",
        "pluginInstallRoot": "${var.LibertyNode01_was_liberty_farm_pluginInstallRoot}",
        "sslCertlabel": "${var.LibertyNode01_was_liberty_farm_sslCertlabel}",
        "sslKeyringLocation": "${var.LibertyNode01_was_liberty_farm_sslKeyringLocation}",
        "sslStashfileLocation": "${var.LibertyNode01_was_liberty_farm_sslStashfileLocation}",
        "webserverName": "${var.LibertyNode01_was_liberty_farm_webserverName}",
        "webserverPort": "${var.LibertyNode01_was_liberty_farm_webserverPort}"
      }
    }
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

output "CentralNode01_ip" {
  value = "Private : ${aws_instance.CentralNode01.private_ip} & Public : ${aws_instance.CentralNode01.public_ip}"
}

output "CentralNode01_name" {
  value = "${var.CentralNode01-name}"
}

output "CentralNode01_roles" {
  value = "liberty_create_server,liberty_install,liberty_plugin_generate"
}

output "LibertyNode01_ip" {
  value = "Private : ${aws_instance.LibertyNode01.private_ip} & Public : ${aws_instance.LibertyNode01.public_ip}"
}

output "LibertyNode01_name" {
  value = "${var.LibertyNode01-name}"
}

output "LibertyNode01_roles" {
  value = "liberty_create_server,liberty_install,liberty_plugin_generate,liberty_plugin_merge,liberty_plugin_merge_setup"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

