#!/bin/bash
#
# Copyright : IBM Corporation 2016, 2017
#
######################################################################################
# Script to download prerequisites for a content runtime installation into a virtual machine
# Usage: ./prereq-downloader platform platform_version
######################################################################################
set -o errexit
set -o nounset
set -o pipefail

PLATFORM="ubuntu"
PLATFORM_VERSION="16.04"

# Process parameters
if [ $# -lt 2 ]; then
    echo "Usage: ./prereq-downloader platform platform_version (optional: release)"
    exit 1
fi

PLATFORM=$1
PLATFORM_VERSION=$2
RELEASE=${3:-"3.0"}

if [ -f releases/$RELEASE ]; then
    . releases/$RELEASE
else
  echo "[ERROR] $RELEASE is not a valid release number. Available releases are 1.0, 2.0 and 3.0"
  exit 1
fi

# Downloaded prereqs location
FOLDER_NAME="prereqs_"$PLATFORM"_"$PLATFORM_VERSION"_"$RELEASE
mkdir -p $FOLDER_NAME

# Check if the executing platform is supported
if [[ $PLATFORM == *"ubuntu"* ]]; then
  echo "[*] Downloading requirements for $PLATFORM $PLATFORM_VERSION"
  PACKAGE_FORMAT='deb'
else
  if [[ $PLATFORM == *"redhat"* ]] || [[ $PLATFORM == *"rhel"* ]] || [[ $PLATFORM == *"centos"* ]]; then
    echo "[*] Downloading requirements for $PLATFORM $PLATFORM_VERSION"
    PACKAGE_FORMAT='rpm'
  else
    echo "[ERROR] Platform $PLATFORM not supported. Supported values include: {ubuntu|redhat|rhel|centos}"
    exit 1
  fi
fi

# Change the string 'redhat' to 'rhel'
if [[ $PLATFORM == *"redhat"* ]]; then
  PLATFORM="rhel"
fi

# If executing from unsupported distro versions
MAIN_VERSION=`echo $PLATFORM_VERSION | cut -d '.' -f1`
if ([[ $PLATFORM == *"ubuntu"* ]] && [[ $MAIN_VERSION -lt "14" ]]) || [[ $MAIN_VERSION -lt "7" ]]; then
  echo "[ERROR] This OS version ($PLATFORM_VERSION) is not supported"
  exit 1
fi

get_ubuntu_version() {
  case $PLATFORM_VERSION in
    14.04)
      echo "trusty"
      ;;
    16.04)
      echo "xenial"
      ;;
    *)
      echo "[ERROR] The provided Ubuntu version is not supported"
      exit 1
  esac
}

download_file() {
  curl -L --retry 5 --progress-bar $1 > $FOLDER_NAME/$2
}

download_chef() {
  echo "[*] Downloading Chef installation package v$CHEF_VERSION..."
  if [[ $PLATFORM == *"ubuntu"* ]]; then
    CHEF_URL=https://packages.chef.io/files/stable/chef-server/$CHEF_VERSION/ubuntu/$PLATFORM_VERSION/chef-server-core_$CHEF_VERSION-1_amd64.deb
  else
    CHEF_URL=https://packages.chef.io/files/stable/chef-server/$CHEF_VERSION/el/$MAIN_VERSION/chef-server-core-$CHEF_VERSION-1.el$MAIN_VERSION.x86_64.rpm
  fi
  download_file $CHEF_URL chef.$PACKAGE_FORMAT
}

download_clients() {
  echo "[*] Downloading Chef client installation packages v$CHEF_CLIENT_VERSION..."
  mkdir -p $FOLDER_NAME/chef-clients
  download_file "https://packages.chef.io/files/stable/chef/$CHEF_CLIENT_VERSION/ubuntu/16.04/chef_$CHEF_CLIENT_VERSION-1_amd64.deb" "chef-clients/chef_$CHEF_CLIENT_VERSION-1_amd64.deb"
  download_file "https://packages.chef.io/files/stable/chef/$CHEF_CLIENT_VERSION/el/6/chef-$CHEF_CLIENT_VERSION-1.el6.x86_64.rpm" "chef-clients/chef-$CHEF_CLIENT_VERSION-1.el6.x86_64.rpm"
  download_file "https://packages.chef.io/files/stable/chef/$CHEF_CLIENT_VERSION/el/7/chef-$CHEF_CLIENT_VERSION-1.el7.x86_64.rpm" "chef-clients/chef-$CHEF_CLIENT_VERSION-1.el7.x86_64.rpm"
  download_file "https://rubygems.org/downloads/chef-vault-2.9.0.gem" "chef-clients/chef-vault-2.9.0.gem"
}

download_chefdk() {
  echo "[*] Downloading Chef DK installation packages v$CHEFDK_VERSION..."
  mkdir -p $FOLDER_NAME/chefdk
  download_file "https://packages.chef.io/files/stable/chefdk/$CHEFDK_VERSION/el/7/chefdk-$CHEFDK_VERSION-1.el7.x86_64.rpm" "chefdk/chefdk-$CHEFDK_VERSION-1.el7.x86_64.rpm"
}

download_docker() {
  if [[ $PLATFORM == *"ubuntu"* ]]; then
    VERSION_NAME=$(get_ubuntu_version)
    echo "[*] Downloading Docker installation package $UBUNTU_DOCKER_PACKAGE..."
    DOCKER_URL=https://download.docker.com/linux/$PLATFORM/dists/$VERSION_NAME/pool/stable/amd64/${UBUNTU_DOCKER_PACKAGE}
  else
    echo "[*] Downloading Docker installation package $CENTOS_DOCKER_PACKAGE..."
    DOCKER_URL=https://download.docker.com/linux/centos/$MAIN_VERSION/x86_64/stable/Packages/${CENTOS_DOCKER_PACKAGE}
  fi
  download_file $DOCKER_URL docker.$PACKAGE_FORMAT
}

download_compose() {
  echo "[*] Downloading Docker Compose v$DOCKER_COMPOSE_VERSION..."
  download_file https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 docker-compose
}

download_images() {
  echo "[*] Pulling Docker images (camc-sw-repo v$SWREPO_IMAGE_VERSION, camc-pm-repo v$PM_IMAGE_VERSION)..."
  docker pull $DOCKER_REGISTRY/camc-sw-repo:$SWREPO_IMAGE_VERSION
  docker pull $DOCKER_REGISTRY/camc-pattern-manager:$PM_IMAGE_VERSION
  echo "[*] Saving Docker images to files..."
  docker save $DOCKER_REGISTRY/camc-sw-repo:$SWREPO_IMAGE_VERSION > $FOLDER_NAME/camc-sw-repo
  docker save $DOCKER_REGISTRY/camc-pattern-manager:$PM_IMAGE_VERSION > $FOLDER_NAME/camc-pattern-manager
  echo "[*] Docker images saved successfully"
}

download_cookbooks_and_templates() {
  echo "[*] Downloading Cookbooks and Templates..."
  ###
  #TEMPLATES_VERSION is the default version which is 2.0 used for cookbooks.
  #But version is overridden by entries in cloneGitRepositories/template<release> see cloneGitRepositories/cloneRepositories.sh
  ###
  ./../cloneGitRepositories/cloneRepositories.sh --branch "$TEMPLATES_VERSION" --filter "cookbook|template|starterlibrary|IBMPower" --filterOut "advanced" --release $CAM_VERSION
  mv ../../src/IBM-CAMHub-Open_starterlibrary.tar $FOLDER_NAME/
  mv ../../src/IBM-CAMHub-Open.tar $FOLDER_NAME/
  mv ../../src/IBM-CAMHub-Open_templates.tar $FOLDER_NAME/
  echo "[*] Downloading Content Runtimes v$CR_VERSION..."
  ./../cloneGitRepositories/cloneRepositories.sh --branch "$CR_VERSION" --filter "advanced"
  echo "[*] Git repositories cloned successfully"
  mv ../../src/IBM-CAMHub-Open_advanced_content_runtime.tar $FOLDER_NAME/
  rm -rf ../../src*
  echo "[*] Gathered Content Runtime prerequisite files in $FOLDER_NAME/"
}

echo "[*] Prerequisite Downloader version $SCRIPT_VERSION"
download_chef
download_docker
download_compose
download_images
download_clients
CHEFDK_FOUND=${CHEFDK_VERSION:-""}
if [[ -n $CHEFDK_FOUND ]]; then
        download_chefdk
fi
download_cookbooks_and_templates

echo "[DONE] Successfully downloaded all requirements to the folder: $FOLDER_NAME"
