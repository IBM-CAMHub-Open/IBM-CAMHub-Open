# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2017 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

# This is a terraform generated template generated from ibm_wasnd_v855_multinode

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


##### IHSNode01 variables #####
#Variable : IHSNode01-image
variable "IHSNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : IHSNode01-name
variable "IHSNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : IHSNode01-os_admin_user
variable "IHSNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : IHSNode01_ihs_admin_server_enabled
variable "IHSNode01_ihs_admin_server_enabled" {
  type = "string"
  description = "IBM HTTP Server Admin Server Enable(true/false)"
}

#Variable : IHSNode01_ihs_admin_server_password
variable "IHSNode01_ihs_admin_server_password" {
  type = "string"
  description = "IBM HTTP Server Admin Server Password"
}

#Variable : IHSNode01_ihs_admin_server_port
variable "IHSNode01_ihs_admin_server_port" {
  type = "string"
  description = "IBM HTTP Server Admin Server Port Number"
}

#Variable : IHSNode01_ihs_admin_server_username
variable "IHSNode01_ihs_admin_server_username" {
  type = "string"
  description = "IBM HTTP Server Admin Server username"
}

#Variable : IHSNode01_ihs_install_dir
variable "IHSNode01_ihs_install_dir" {
  type = "string"
  description = "The directory to install IBM HTTP Server"
}

#Variable : IHSNode01_ihs_install_mode
variable "IHSNode01_ihs_install_mode" {
  type = "string"
  description = "The mode of installation for IBM HTTP Server"
}

#Variable : IHSNode01_ihs_java_legacy
variable "IHSNode01_ihs_java_legacy" {
  type = "string"
  description = "The Java version to be used with IBM HTTP Server version 8.5.5"
}

#Variable : IHSNode01_ihs_java_version
variable "IHSNode01_ihs_java_version" {
  type = "string"
  description = "The Java version to be used with IBM HTTP Server"
}

#Variable : IHSNode01_ihs_os_users_ihs_gid
variable "IHSNode01_ihs_os_users_ihs_gid" {
  type = "string"
  description = "The group name for the IBM HTTP Server user"
}

#Variable : IHSNode01_ihs_os_users_ihs_name
variable "IHSNode01_ihs_os_users_ihs_name" {
  type = "string"
  description = "The username for IBM HTTP Server"
}

#Variable : IHSNode01_ihs_os_users_ihs_shell
variable "IHSNode01_ihs_os_users_ihs_shell" {
  type = "string"
  description = "Location of the IBM HTTP Server operating system user shell"
}

#Variable : IHSNode01_ihs_plugin_enabled
variable "IHSNode01_ihs_plugin_enabled" {
  type = "string"
  description = "IBM HTTP Server Plugin Enabled"
}

#Variable : IHSNode01_ihs_plugin_install_dir
variable "IHSNode01_ihs_plugin_install_dir" {
  type = "string"
  description = "IBM HTTP Server Plugin Installation Direcrtory"
}

#Variable : IHSNode01_ihs_plugin_was_webserver_name
variable "IHSNode01_ihs_plugin_was_webserver_name" {
  type = "string"
  description = "IBM HTTP Server Plugin Hostname, normally the FQDN"
}

#Variable : IHSNode01_ihs_port
variable "IHSNode01_ihs_port" {
  type = "string"
  description = "The IBM HTTP Server default port for HTTP requests"
}

#Variable : IHSNode01_ihs_version
variable "IHSNode01_ihs_version" {
  type = "string"
  description = "The version of IBM HTTP Server to install"
}


##### Image Parameters variables #####

##### virtualmachine variables #####

##### WASDMGRNode01 variables #####
#Variable : WASDMGRNode01-image
variable "WASDMGRNode01-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : WASDMGRNode01-name
variable "WASDMGRNode01-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : WASDMGRNode01-os_admin_user
variable "WASDMGRNode01-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : WASDMGRNode01_was_install_dir
variable "WASDMGRNode01_was_install_dir" {
  type = "string"
  description = "The installation root directory for the WebSphere Application Server product binaries"
}

#Variable : WASDMGRNode01_was_java_version
variable "WASDMGRNode01_was_java_version" {
  type = "string"
  description = "The Java SDK version that should be installed with the WebSphere Application Server. Example format is 8.0.4.70"
}

#Variable : WASDMGRNode01_was_os_users_was_comment
variable "WASDMGRNode01_was_os_users_was_comment" {
  type = "string"
  description = "Comment that will be added when creating the userid"
}

#Variable : WASDMGRNode01_was_os_users_was_gid
variable "WASDMGRNode01_was_os_users_was_gid" {
  type = "string"
  description = "Operating system group name that will be assigned to the product installation"
}

#Variable : WASDMGRNode01_was_os_users_was_home
variable "WASDMGRNode01_was_os_users_was_home" {
  type = "string"
  description = "Home directory location for operating system user that is used for product installation"
}

#Variable : WASDMGRNode01_was_os_users_was_ldap_user
variable "WASDMGRNode01_was_os_users_was_ldap_user" {
  type = "string"
  description = "A flag which indicates whether to create the WebSphere user locally, or utilize an LDAP based user"
}

#Variable : WASDMGRNode01_was_os_users_was_name
variable "WASDMGRNode01_was_os_users_was_name" {
  type = "string"
  description = "Operating system userid that will be used to install the product. Userid will be created if it does not exist"
}

#Variable : WASDMGRNode01_was_profile_dir
variable "WASDMGRNode01_was_profile_dir" {
  type = "string"
  description = "The directory path that contains WebSphere Application Server profiles"
}

#Variable : WASDMGRNode01_was_profiles_dmgr_cell
variable "WASDMGRNode01_was_profiles_dmgr_cell" {
  type = "string"
  description = "A cell name is a logical name for the group of nodes administered by the deployment manager cell"
}

#Variable : WASDMGRNode01_was_profiles_dmgr_keystorepassword
variable "WASDMGRNode01_was_profiles_dmgr_keystorepassword" {
  type = "string"
  description = "Specifies the password to use on keystore created during profile creation"
}

#Variable : WASDMGRNode01_was_profiles_dmgr_profile
variable "WASDMGRNode01_was_profiles_dmgr_profile" {
  type = "string"
  description = "WebSphere Deployment Manager profile name"
}

#Variable : WASDMGRNode01_was_security_admin_user
variable "WASDMGRNode01_was_security_admin_user" {
  type = "string"
  description = "The username for securing the WebSphere adminstrative console"
}

#Variable : WASDMGRNode01_was_security_admin_user_pwd
variable "WASDMGRNode01_was_security_admin_user_pwd" {
  type = "string"
  description = "The password for the WebSphere administrative account"
}

#Variable : WASDMGRNode01_was_version
variable "WASDMGRNode01_was_version" {
  type = "string"
  description = "The release and fixpack level of WebSphere Application Server to be installed. Example formats are 8.5.5.12 or 9.0.0.4"
}

#Variable : WASDMGRNode01_was_webserver_ihs_server_admin_port
variable "WASDMGRNode01_was_webserver_ihs_server_admin_port" {
  type = "string"
  description = "IBM HTTP Administrative Server Port.  Used for creating the web server definition"
}

#Variable : WASDMGRNode01_was_webserver_ihs_server_ihs_admin_user
variable "WASDMGRNode01_was_webserver_ihs_server_ihs_admin_user" {
  type = "string"
  description = "IBM HTTP administrative username. Used for creating the web server definition"
}

#Variable : WASDMGRNode01_was_webserver_ihs_server_install_dir
variable "WASDMGRNode01_was_webserver_ihs_server_install_dir" {
  type = "string"
  description = "Specify the HTTP Server installation directory. Used for creating the web server definition"
}

#Variable : WASDMGRNode01_was_webserver_ihs_server_webserver_name
variable "WASDMGRNode01_was_webserver_ihs_server_webserver_name" {
  type = "string"
  description = "Web server server name"
}

#Variable : WASDMGRNode01_was_webserver_ihs_server_webserver_port
variable "WASDMGRNode01_was_webserver_ihs_server_webserver_port" {
  type = "string"
  description = "IBM HTTP Server Listener Port that will receive requests on. Use for creating the web server definition"
}

#Variable : WASDMGRNode01_was_wsadmin_dmgr_jvmproperty_property_value_initial
variable "WASDMGRNode01_was_wsadmin_dmgr_jvmproperty_property_value_initial" {
  type = "string"
  description = "Minimum JVM heap size"
}

#Variable : WASDMGRNode01_was_wsadmin_dmgr_jvmproperty_property_value_maximum
variable "WASDMGRNode01_was_wsadmin_dmgr_jvmproperty_property_value_maximum" {
  type = "string"
  description = "Maximum JVM heap size"
}


##### WASNode01 variables #####
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

#Variable : WASNode01_was_profiles_node_profile_keystorepassword
variable "WASNode01_was_profiles_node_profile_keystorepassword" {
  type = "string"
  description = "Specifies the password to use on all keystore files created during profile creation"
}

#Variable : WASNode01_was_profiles_node_profile_profile
variable "WASNode01_was_profiles_node_profile_profile" {
  type = "string"
  description = "Profile name for a custom profile"
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

#Variable : WASNode01_was_wsadmin_clusters_cluster01_cluster_name
variable "WASNode01_was_wsadmin_clusters_cluster01_cluster_name" {
  type = "string"
  description = "Name of the cluster that will be created"
}

#Variable : WASNode01_was_wsadmin_clusters_cluster01_cluster_servers_cluster_server01_server_name
variable "WASNode01_was_wsadmin_clusters_cluster01_cluster_servers_cluster_server01_server_name" {
  type = "string"
  description = "Name of the cluster member that will created on each of the nodes"
}

#Variable : WASNode01_was_wsadmin_nodeagent_jvmproperty_property_value_initial
variable "WASNode01_was_wsadmin_nodeagent_jvmproperty_property_value_initial" {
  type = "string"
  description = "Minimum JVM heap size"
}

#Variable : WASNode01_was_wsadmin_nodeagent_jvmproperty_property_value_maximum
variable "WASNode01_was_wsadmin_nodeagent_jvmproperty_property_value_maximum" {
  type = "string"
  description = "Maximum JVM heap size"
}


##### WASNode02 variables #####
#Variable : WASNode02-image
variable "WASNode02-image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : WASNode02-name
variable "WASNode02-name" {
  type = "string"
  description = "Short hostname of virtual machine"
}

#Variable : WASNode02-os_admin_user
variable "WASNode02-os_admin_user" {
  type = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : WASNode02_was_install_dir
variable "WASNode02_was_install_dir" {
  type = "string"
  description = "The installation root directory for the WebSphere Application Server product binaries"
}

#Variable : WASNode02_was_java_version
variable "WASNode02_was_java_version" {
  type = "string"
  description = "The Java SDK version that should be installed with the WebSphere Application Server. Example format is 8.0.4.70"
}

#Variable : WASNode02_was_os_users_was_comment
variable "WASNode02_was_os_users_was_comment" {
  type = "string"
  description = "Comment that will be added when creating the userid"
}

#Variable : WASNode02_was_os_users_was_gid
variable "WASNode02_was_os_users_was_gid" {
  type = "string"
  description = "Operating system group name that will be assigned to the product installation"
}

#Variable : WASNode02_was_os_users_was_home
variable "WASNode02_was_os_users_was_home" {
  type = "string"
  description = "Home directory location for operating system user that is used for product installation"
}

#Variable : WASNode02_was_os_users_was_ldap_user
variable "WASNode02_was_os_users_was_ldap_user" {
  type = "string"
  description = "A flag which indicates whether to create the WebSphere user locally, or utilize an LDAP based user"
}

#Variable : WASNode02_was_os_users_was_name
variable "WASNode02_was_os_users_was_name" {
  type = "string"
  description = "Operating system userid that will be used to install the product. Userid will be created if it does not exist"
}

#Variable : WASNode02_was_profile_dir
variable "WASNode02_was_profile_dir" {
  type = "string"
  description = "The directory path that contains WebSphere Application Server profiles"
}

#Variable : WASNode02_was_profiles_node_profile_keystorepassword
variable "WASNode02_was_profiles_node_profile_keystorepassword" {
  type = "string"
  description = "Specifies the password to use on all keystore files created during profile creation"
}

#Variable : WASNode02_was_profiles_node_profile_profile
variable "WASNode02_was_profiles_node_profile_profile" {
  type = "string"
  description = "Profile name for a custom profile"
}

#Variable : WASNode02_was_security_admin_user
variable "WASNode02_was_security_admin_user" {
  type = "string"
  description = "The username for securing the WebSphere adminstrative console"
}

#Variable : WASNode02_was_security_admin_user_pwd
variable "WASNode02_was_security_admin_user_pwd" {
  type = "string"
  description = "The password for the WebSphere administrative account"
}

#Variable : WASNode02_was_version
variable "WASNode02_was_version" {
  type = "string"
  description = "The release and fixpack level of WebSphere Application Server to be installed. Example formats are 8.5.5.12 or 9.0.0.4"
}

#Variable : WASNode02_was_wsadmin_clusters_cluster01_cluster_name
variable "WASNode02_was_wsadmin_clusters_cluster01_cluster_name" {
  type = "string"
  description = "Name of the cluster that will be created"
}

#Variable : WASNode02_was_wsadmin_clusters_cluster01_cluster_servers_cluster_server01_server_name
variable "WASNode02_was_wsadmin_clusters_cluster01_cluster_servers_cluster_server01_server_name" {
  type = "string"
  description = "Name of the cluster member that will created on each of the nodes"
}

#Variable : WASNode02_was_wsadmin_nodeagent_jvmproperty_property_value_initial
variable "WASNode02_was_wsadmin_nodeagent_jvmproperty_property_value_initial" {
  type = "string"
  description = "Minimum JVM heap size"
}

#Variable : WASNode02_was_wsadmin_nodeagent_jvmproperty_property_value_maximum
variable "WASNode02_was_wsadmin_nodeagent_jvmproperty_property_value_maximum" {
  type = "string"
  description = "Maximum JVM heap size"
}


#########################################################
##### Resource : IHSNode01
#########################################################

variable "IHSNode01-os_password" {
  type = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "IHSNode01_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "IHSNode01_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "IHSNode01_domain" {
  description = "Domain Name of virtual machine"
}

variable "IHSNode01_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
}

variable "IHSNode01_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
}

variable "IHSNode01_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "IHSNode01_dns_suffixes" {
  type = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "IHSNode01_dns_servers" {
  type = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "IHSNode01_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "IHSNode01_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "IHSNode01_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "IHSNode01_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "IHSNode01_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
}

variable "IHSNode01_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "IHSNode01_root_disk_type" {
  type = "string"
  description = "Type of template disk volume"
}

variable "IHSNode01_root_disk_controller_type" {
  type = "string"
  description = "Type of template disk controller"
}

variable "IHSNode01_root_disk_keep_on_remove" {
  type = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
}

# vsphere vm
resource "vsphere_virtual_machine" "IHSNode01" {
  name = "${var.IHSNode01-name}"
  domain = "${var.IHSNode01_domain}"
  folder = "${var.IHSNode01_folder}"
  datacenter = "${var.IHSNode01_datacenter}"
  vcpu = "${var.IHSNode01_number_of_vcpu}"
  memory = "${var.IHSNode01_memory}"
  cluster = "${var.IHSNode01_cluster}"
  dns_suffixes = "${var.IHSNode01_dns_suffixes}"
  dns_servers = "${var.IHSNode01_dns_servers}"

  network_interface {
    label = "${var.IHSNode01_network_interface_label}"
    ipv4_gateway = "${var.IHSNode01_ipv4_gateway}"
    ipv4_address = "${var.IHSNode01_ipv4_address}"
    ipv4_prefix_length = "${var.IHSNode01_ipv4_prefix_length}"
    adapter_type = "${var.IHSNode01_adapter_type}"
  }

  disk {
    type = "${var.IHSNode01_root_disk_type}"
    template = "${var.IHSNode01-image}"
    datastore = "${var.IHSNode01_root_disk_datastore}"
    keep_on_remove = "${var.IHSNode01_root_disk_keep_on_remove}"
    controller_type = "${var.IHSNode01_root_disk_controller_type}"
  }

  # Specify the connection
  connection {
    type = "ssh"
    user = "${var.IHSNode01-os_admin_user}"
    password = "${var.IHSNode01-os_password}"
  }

  provisioner "file" {
    destination = "IHSNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x IHSNode01_add_ssh_key.sh'",
      "bash -c './IHSNode01_add_ssh_key.sh  \"${var.IHSNode01-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> IHSNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : IHSNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "IHSNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","vsphere_virtual_machine.IHSNode01"]
  name = "IHSNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.IHSNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.IHSNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.IHSNode01-name}",
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
##### Resource : IHSNode01_ihs-wasmode-nonadmin
#########################################################

resource "camc_softwaredeploy" "IHSNode01_ihs-wasmode-nonadmin" {
  depends_on = ["camc_softwaredeploy.WASDMGRNode01_was_create_dmgr"]
  name = "IHSNode01_ihs-wasmode-nonadmin"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.IHSNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.IHSNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.IHSNode01-name}",
  "runlist": "role[ihs-wasmode-nonadmin]",
  "node_attributes": {
    "ibm": {
      "im_repo": "${var.ibm_im_repo}",
      "im_repo_user": "${var.ibm_im_repo_user}",
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "ibm_internal": {
      "roles": "[ihs-wasmode-nonadmin]"
    },
    "ihs": {
      "admin_server": {
        "enabled": "${var.IHSNode01_ihs_admin_server_enabled}",
        "port": "${var.IHSNode01_ihs_admin_server_port}",
        "username": "${var.IHSNode01_ihs_admin_server_username}"
      },
      "install_dir": "${var.IHSNode01_ihs_install_dir}",
      "install_mode": "${var.IHSNode01_ihs_install_mode}",
      "java": {
        "legacy": "${var.IHSNode01_ihs_java_legacy}",
        "version": "${var.IHSNode01_ihs_java_version}"
      },
      "os_users": {
        "ihs": {
          "gid": "${var.IHSNode01_ihs_os_users_ihs_gid}",
          "name": "${var.IHSNode01_ihs_os_users_ihs_name}",
          "shell": "${var.IHSNode01_ihs_os_users_ihs_shell}"
        }
      },
      "plugin": {
        "enabled": "${var.IHSNode01_ihs_plugin_enabled}",
        "install_dir": "${var.IHSNode01_ihs_plugin_install_dir}",
        "was_webserver_name": "${var.IHSNode01_ihs_plugin_was_webserver_name}"
      },
      "port": "${var.IHSNode01_ihs_port}",
      "version": "${var.IHSNode01_ihs_version}"
    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "ibm": {
        "im_repo_password": "${var.ibm_im_repo_password}",
        "sw_repo_password": "${var.ibm_sw_repo_password}"
      },
      "ihs": {
        "admin_server": {
          "password": "${var.IHSNode01_ihs_admin_server_password}"
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


#########################################################
##### Resource : WASDMGRNode01
#########################################################

variable "WASDMGRNode01-os_password" {
  type = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "WASDMGRNode01_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "WASDMGRNode01_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "WASDMGRNode01_domain" {
  description = "Domain Name of virtual machine"
}

variable "WASDMGRNode01_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
}

variable "WASDMGRNode01_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
}

variable "WASDMGRNode01_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "WASDMGRNode01_dns_suffixes" {
  type = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "WASDMGRNode01_dns_servers" {
  type = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "WASDMGRNode01_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "WASDMGRNode01_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "WASDMGRNode01_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "WASDMGRNode01_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "WASDMGRNode01_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
}

variable "WASDMGRNode01_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "WASDMGRNode01_root_disk_type" {
  type = "string"
  description = "Type of template disk volume"
}

variable "WASDMGRNode01_root_disk_controller_type" {
  type = "string"
  description = "Type of template disk controller"
}

variable "WASDMGRNode01_root_disk_keep_on_remove" {
  type = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
}

# vsphere vm
resource "vsphere_virtual_machine" "WASDMGRNode01" {
  name = "${var.WASDMGRNode01-name}"
  domain = "${var.WASDMGRNode01_domain}"
  folder = "${var.WASDMGRNode01_folder}"
  datacenter = "${var.WASDMGRNode01_datacenter}"
  vcpu = "${var.WASDMGRNode01_number_of_vcpu}"
  memory = "${var.WASDMGRNode01_memory}"
  cluster = "${var.WASDMGRNode01_cluster}"
  dns_suffixes = "${var.WASDMGRNode01_dns_suffixes}"
  dns_servers = "${var.WASDMGRNode01_dns_servers}"

  network_interface {
    label = "${var.WASDMGRNode01_network_interface_label}"
    ipv4_gateway = "${var.WASDMGRNode01_ipv4_gateway}"
    ipv4_address = "${var.WASDMGRNode01_ipv4_address}"
    ipv4_prefix_length = "${var.WASDMGRNode01_ipv4_prefix_length}"
    adapter_type = "${var.WASDMGRNode01_adapter_type}"
  }

  disk {
    type = "${var.WASDMGRNode01_root_disk_type}"
    template = "${var.WASDMGRNode01-image}"
    datastore = "${var.WASDMGRNode01_root_disk_datastore}"
    keep_on_remove = "${var.WASDMGRNode01_root_disk_keep_on_remove}"
    controller_type = "${var.WASDMGRNode01_root_disk_controller_type}"
  }

  # Specify the connection
  connection {
    type = "ssh"
    user = "${var.WASDMGRNode01-os_admin_user}"
    password = "${var.WASDMGRNode01-os_password}"
  }

  provisioner "file" {
    destination = "WASDMGRNode01_add_ssh_key.sh"
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
      "bash -c 'chmod +x WASDMGRNode01_add_ssh_key.sh'",
      "bash -c './WASDMGRNode01_add_ssh_key.sh  \"${var.WASDMGRNode01-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> WASDMGRNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : WASDMGRNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "WASDMGRNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","vsphere_virtual_machine.WASDMGRNode01"]
  name = "WASDMGRNode01_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASDMGRNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASDMGRNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.WASDMGRNode01-name}",
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
##### Resource : WASDMGRNode01_was_create_dmgr
#########################################################

resource "camc_softwaredeploy" "WASDMGRNode01_was_create_dmgr" {
  depends_on = ["camc_softwaredeploy.WASDMGRNode01_was_v855_install","camc_softwaredeploy.WASNode01_was_v855_install","camc_softwaredeploy.WASNode02_was_v855_install"]
  name = "WASDMGRNode01_was_create_dmgr"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASDMGRNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASDMGRNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.WASDMGRNode01-name}",
  "runlist": "role[was_create_dmgr]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_dmgr]"
    },
    "was": {
      "profiles": {
        "dmgr": {
          "cell": "${var.WASDMGRNode01_was_profiles_dmgr_cell}",
          "profile": "${var.WASDMGRNode01_was_profiles_dmgr_profile}"
        }
      },
      "wsadmin": {
        "dmgr": {
          "jvmproperty": {
            "property_value_initial": "${var.WASDMGRNode01_was_wsadmin_dmgr_jvmproperty_property_value_initial}",
            "property_value_maximum": "${var.WASDMGRNode01_was_wsadmin_dmgr_jvmproperty_property_value_maximum}"
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
          "dmgr": {
            "keystorepassword": "${var.WASDMGRNode01_was_profiles_dmgr_keystorepassword}"
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
##### Resource : WASDMGRNode01_was_create_webserver
#########################################################

resource "camc_softwaredeploy" "WASDMGRNode01_was_create_webserver" {
  depends_on = ["camc_softwaredeploy.WASNode02_was_create_clusters_and_members"]
  name = "WASDMGRNode01_was_create_webserver"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASDMGRNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASDMGRNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.WASDMGRNode01-name}",
  "runlist": "role[was_create_webserver]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_webserver]"
    },
    "was": {
      "webserver": {
        "ihs_server": {
          "admin_port": "${var.WASDMGRNode01_was_webserver_ihs_server_admin_port}",
          "ihs_admin_user": "${var.WASDMGRNode01_was_webserver_ihs_server_ihs_admin_user}",
          "install_dir": "${var.WASDMGRNode01_was_webserver_ihs_server_install_dir}",
          "webserver_name": "${var.WASDMGRNode01_was_webserver_ihs_server_webserver_name}",
          "webserver_port": "${var.WASDMGRNode01_was_webserver_ihs_server_webserver_port}"
        }
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : WASDMGRNode01_was_v855_install
#########################################################

resource "camc_softwaredeploy" "WASDMGRNode01_was_v855_install" {
  depends_on = ["camc_bootstrap.WASDMGRNode01_chef_bootstrap_comp","camc_bootstrap.IHSNode01_chef_bootstrap_comp","camc_bootstrap.WASNode01_chef_bootstrap_comp","camc_bootstrap.WASNode02_chef_bootstrap_comp"]
  name = "WASDMGRNode01_was_v855_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASDMGRNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASDMGRNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.WASDMGRNode01-name}",
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
      "install_dir": "${var.WASDMGRNode01_was_install_dir}",
      "java_version": "${var.WASDMGRNode01_was_java_version}",
      "os_users": {
        "was": {
          "comment": "${var.WASDMGRNode01_was_os_users_was_comment}",
          "gid": "${var.WASDMGRNode01_was_os_users_was_gid}",
          "home": "${var.WASDMGRNode01_was_os_users_was_home}",
          "ldap_user": "${var.WASDMGRNode01_was_os_users_was_ldap_user}",
          "name": "${var.WASDMGRNode01_was_os_users_was_name}"
        }
      },
      "profile_dir": "${var.WASDMGRNode01_was_profile_dir}",
      "security": {
        "admin_user": "${var.WASDMGRNode01_was_security_admin_user}"
      },
      "version": "${var.WASDMGRNode01_was_version}"
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
          "admin_user_pwd": "${var.WASDMGRNode01_was_security_admin_user_pwd}"
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}


#########################################################
##### Resource : WASNode01
#########################################################

variable "WASNode01-os_password" {
  type = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "WASNode01_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "WASNode01_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "WASNode01_domain" {
  description = "Domain Name of virtual machine"
}

variable "WASNode01_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
}

variable "WASNode01_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
}

variable "WASNode01_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "WASNode01_dns_suffixes" {
  type = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "WASNode01_dns_servers" {
  type = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "WASNode01_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "WASNode01_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "WASNode01_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "WASNode01_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "WASNode01_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
}

variable "WASNode01_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "WASNode01_root_disk_type" {
  type = "string"
  description = "Type of template disk volume"
}

variable "WASNode01_root_disk_controller_type" {
  type = "string"
  description = "Type of template disk controller"
}

variable "WASNode01_root_disk_keep_on_remove" {
  type = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
}

# vsphere vm
resource "vsphere_virtual_machine" "WASNode01" {
  name = "${var.WASNode01-name}"
  domain = "${var.WASNode01_domain}"
  folder = "${var.WASNode01_folder}"
  datacenter = "${var.WASNode01_datacenter}"
  vcpu = "${var.WASNode01_number_of_vcpu}"
  memory = "${var.WASNode01_memory}"
  cluster = "${var.WASNode01_cluster}"
  dns_suffixes = "${var.WASNode01_dns_suffixes}"
  dns_servers = "${var.WASNode01_dns_servers}"

  network_interface {
    label = "${var.WASNode01_network_interface_label}"
    ipv4_gateway = "${var.WASNode01_ipv4_gateway}"
    ipv4_address = "${var.WASNode01_ipv4_address}"
    ipv4_prefix_length = "${var.WASNode01_ipv4_prefix_length}"
    adapter_type = "${var.WASNode01_adapter_type}"
  }

  disk {
    type = "${var.WASNode01_root_disk_type}"
    template = "${var.WASNode01-image}"
    datastore = "${var.WASNode01_root_disk_datastore}"
    keep_on_remove = "${var.WASNode01_root_disk_keep_on_remove}"
    controller_type = "${var.WASNode01_root_disk_controller_type}"
  }

  # Specify the connection
  connection {
    type = "ssh"
    user = "${var.WASNode01-os_admin_user}"
    password = "${var.WASNode01-os_password}"
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
      "bash -c 'chmod +x WASNode01_add_ssh_key.sh'",
      "bash -c './WASNode01_add_ssh_key.sh  \"${var.WASNode01-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> WASNode01_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : WASNode01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "WASNode01_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","vsphere_virtual_machine.WASNode01"]
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
  "host_ip": "${vsphere_virtual_machine.WASNode01.network_interface.0.ipv4_address}",
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
##### Resource : WASNode01_was_create_clusters_and_members
#########################################################

resource "camc_softwaredeploy" "WASNode01_was_create_clusters_and_members" {
  depends_on = ["camc_softwaredeploy.WASNode02_was_create_nodeagent"]
  name = "WASNode01_was_create_clusters_and_members"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.WASNode01-name}",
  "runlist": "role[was_create_clusters_and_members]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_clusters_and_members]"
    },
    "was": {
      "wsadmin": {
        "clusters": {
          "cluster01": {
            "cluster_name": "${var.WASNode01_was_wsadmin_clusters_cluster01_cluster_name}",
            "cluster_servers": {
              "cluster_server01": {
                "server_name": "${var.WASNode01_was_wsadmin_clusters_cluster01_cluster_servers_cluster_server01_server_name}"
              }
            }
          }
        }
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : WASNode01_was_create_nodeagent
#########################################################

resource "camc_softwaredeploy" "WASNode01_was_create_nodeagent" {
  depends_on = ["camc_softwaredeploy.WASDMGRNode01_was_create_dmgr"]
  name = "WASNode01_was_create_nodeagent"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode01-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASNode01.network_interface.0.ipv4_address}",
  "node_name": "${var.WASNode01-name}",
  "runlist": "role[was_create_nodeagent]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_nodeagent]"
    },
    "was": {
      "profiles": {
        "node_profile": {
          "profile": "${var.WASNode01_was_profiles_node_profile_profile}"
        }
      },
      "wsadmin": {
        "nodeagent": {
          "jvmproperty": {
            "property_value_initial": "${var.WASNode01_was_wsadmin_nodeagent_jvmproperty_property_value_initial}",
            "property_value_maximum": "${var.WASNode01_was_wsadmin_nodeagent_jvmproperty_property_value_maximum}"
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
          "node_profile": {
            "keystorepassword": "${var.WASNode01_was_profiles_node_profile_keystorepassword}"
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
  depends_on = ["camc_bootstrap.WASDMGRNode01_chef_bootstrap_comp","camc_bootstrap.IHSNode01_chef_bootstrap_comp","camc_bootstrap.WASNode01_chef_bootstrap_comp","camc_bootstrap.WASNode02_chef_bootstrap_comp"]
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
  "host_ip": "${vsphere_virtual_machine.WASNode01.network_interface.0.ipv4_address}",
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


#########################################################
##### Resource : WASNode02
#########################################################

variable "WASNode02-os_password" {
  type = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "WASNode02_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "WASNode02_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "WASNode02_domain" {
  description = "Domain Name of virtual machine"
}

variable "WASNode02_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
}

variable "WASNode02_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
}

variable "WASNode02_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "WASNode02_dns_suffixes" {
  type = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "WASNode02_dns_servers" {
  type = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "WASNode02_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "WASNode02_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "WASNode02_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "WASNode02_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "WASNode02_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
}

variable "WASNode02_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "WASNode02_root_disk_type" {
  type = "string"
  description = "Type of template disk volume"
}

variable "WASNode02_root_disk_controller_type" {
  type = "string"
  description = "Type of template disk controller"
}

variable "WASNode02_root_disk_keep_on_remove" {
  type = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
}

# vsphere vm
resource "vsphere_virtual_machine" "WASNode02" {
  name = "${var.WASNode02-name}"
  domain = "${var.WASNode02_domain}"
  folder = "${var.WASNode02_folder}"
  datacenter = "${var.WASNode02_datacenter}"
  vcpu = "${var.WASNode02_number_of_vcpu}"
  memory = "${var.WASNode02_memory}"
  cluster = "${var.WASNode02_cluster}"
  dns_suffixes = "${var.WASNode02_dns_suffixes}"
  dns_servers = "${var.WASNode02_dns_servers}"

  network_interface {
    label = "${var.WASNode02_network_interface_label}"
    ipv4_gateway = "${var.WASNode02_ipv4_gateway}"
    ipv4_address = "${var.WASNode02_ipv4_address}"
    ipv4_prefix_length = "${var.WASNode02_ipv4_prefix_length}"
    adapter_type = "${var.WASNode02_adapter_type}"
  }

  disk {
    type = "${var.WASNode02_root_disk_type}"
    template = "${var.WASNode02-image}"
    datastore = "${var.WASNode02_root_disk_datastore}"
    keep_on_remove = "${var.WASNode02_root_disk_keep_on_remove}"
    controller_type = "${var.WASNode02_root_disk_controller_type}"
  }

  # Specify the connection
  connection {
    type = "ssh"
    user = "${var.WASNode02-os_admin_user}"
    password = "${var.WASNode02-os_password}"
  }

  provisioner "file" {
    destination = "WASNode02_add_ssh_key.sh"
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
      "bash -c 'chmod +x WASNode02_add_ssh_key.sh'",
      "bash -c './WASNode02_add_ssh_key.sh  \"${var.WASNode02-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> WASNode02_add_ssh_key.log 2>&1'"
    ]
  }

}

#########################################################
##### Resource : WASNode02_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "WASNode02_chef_bootstrap_comp" {
  depends_on = ["camc_vaultitem.VaultItem","vsphere_virtual_machine.WASNode02"]
  name = "WASNode02_chef_bootstrap_comp"
  camc_endpoint = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode02-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASNode02.network_interface.0.ipv4_address}",
  "node_name": "${var.WASNode02-name}",
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
##### Resource : WASNode02_was_create_clusters_and_members
#########################################################

resource "camc_softwaredeploy" "WASNode02_was_create_clusters_and_members" {
  depends_on = ["camc_softwaredeploy.WASNode01_was_create_clusters_and_members"]
  name = "WASNode02_was_create_clusters_and_members"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode02-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASNode02.network_interface.0.ipv4_address}",
  "node_name": "${var.WASNode02-name}",
  "runlist": "role[was_create_clusters_and_members]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_clusters_and_members]"
    },
    "was": {
      "wsadmin": {
        "clusters": {
          "cluster01": {
            "cluster_name": "${var.WASNode02_was_wsadmin_clusters_cluster01_cluster_name}",
            "cluster_servers": {
              "cluster_server01": {
                "server_name": "${var.WASNode02_was_wsadmin_clusters_cluster01_cluster_servers_cluster_server01_server_name}"
              }
            }
          }
        }
      }
    }
  }
}
EOT
}


#########################################################
##### Resource : WASNode02_was_create_nodeagent
#########################################################

resource "camc_softwaredeploy" "WASNode02_was_create_nodeagent" {
  depends_on = ["camc_softwaredeploy.WASNode01_was_create_nodeagent","camc_softwaredeploy.IHSNode01_ihs-wasmode-nonadmin"]
  name = "WASNode02_was_create_nodeagent"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode02-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASNode02.network_interface.0.ipv4_address}",
  "node_name": "${var.WASNode02-name}",
  "runlist": "role[was_create_nodeagent]",
  "node_attributes": {
    "ibm_internal": {
      "roles": "[was_create_nodeagent]"
    },
    "was": {
      "profiles": {
        "node_profile": {
          "profile": "${var.WASNode02_was_profiles_node_profile_profile}"
        }
      },
      "wsadmin": {
        "nodeagent": {
          "jvmproperty": {
            "property_value_initial": "${var.WASNode02_was_wsadmin_nodeagent_jvmproperty_property_value_initial}",
            "property_value_maximum": "${var.WASNode02_was_wsadmin_nodeagent_jvmproperty_property_value_maximum}"
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
          "node_profile": {
            "keystorepassword": "${var.WASNode02_was_profiles_node_profile_keystorepassword}"
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
##### Resource : WASNode02_was_v855_install
#########################################################

resource "camc_softwaredeploy" "WASNode02_was_v855_install" {
  depends_on = ["camc_bootstrap.WASDMGRNode01_chef_bootstrap_comp","camc_bootstrap.IHSNode01_chef_bootstrap_comp","camc_bootstrap.WASNode01_chef_bootstrap_comp","camc_bootstrap.WASNode02_chef_bootstrap_comp"]
  name = "WASNode02_was_v855_install"
  camc_endpoint = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace = true
  data = <<EOT
{
  "os_admin_user": "${var.WASNode02-os_admin_user}",
  "stack_id": "${random_id.stack_id.hex}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.WASNode02.network_interface.0.ipv4_address}",
  "node_name": "${var.WASNode02-name}",
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
      "install_dir": "${var.WASNode02_was_install_dir}",
      "java_version": "${var.WASNode02_was_java_version}",
      "os_users": {
        "was": {
          "comment": "${var.WASNode02_was_os_users_was_comment}",
          "gid": "${var.WASNode02_was_os_users_was_gid}",
          "home": "${var.WASNode02_was_os_users_was_home}",
          "ldap_user": "${var.WASNode02_was_os_users_was_ldap_user}",
          "name": "${var.WASNode02_was_os_users_was_name}"
        }
      },
      "profile_dir": "${var.WASNode02_was_profile_dir}",
      "security": {
        "admin_user": "${var.WASNode02_was_security_admin_user}"
      },
      "version": "${var.WASNode02_was_version}"
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
          "admin_user_pwd": "${var.WASNode02_was_security_admin_user_pwd}"
        }
      }
    },
    "vault": "${random_id.stack_id.hex}"
  }
}
EOT
}

output "IHSNode01_ip" {
  value = "VM IP Address : ${vsphere_virtual_machine.IHSNode01.network_interface.0.ipv4_address}"
}

output "IHSNode01_name" {
  value = "${var.IHSNode01-name}"
}

output "IHSNode01_roles" {
  value = "ihs-wasmode-nonadmin"
}

output "WASDMGRNode01_ip" {
  value = "VM IP Address : ${vsphere_virtual_machine.WASDMGRNode01.network_interface.0.ipv4_address}"
}

output "WASDMGRNode01_name" {
  value = "${var.WASDMGRNode01-name}"
}

output "WASDMGRNode01_roles" {
  value = "was_create_dmgr,was_create_webserver,was_v855_install"
}

output "WASNode01_ip" {
  value = "VM IP Address : ${vsphere_virtual_machine.WASNode01.network_interface.0.ipv4_address}"
}

output "WASNode01_name" {
  value = "${var.WASNode01-name}"
}

output "WASNode01_roles" {
  value = "was_create_clusters_and_members,was_create_nodeagent,was_v855_install"
}

output "WASNode02_ip" {
  value = "VM IP Address : ${vsphere_virtual_machine.WASNode02.network_interface.0.ipv4_address}"
}

output "WASNode02_name" {
  value = "${var.WASNode02-name}"
}

output "WASNode02_roles" {
  value = "was_create_clusters_and_members,was_create_nodeagent,was_v855_install"
}

output "stack_id" {
  value = "${random_id.stack_id.hex}"
}

