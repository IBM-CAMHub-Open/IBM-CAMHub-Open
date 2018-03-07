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

# Software versions
CHEF_VERSION=12.11.1
DOCKER_VERSION=17.09.0
DOCKER_COMPOSE_VERSION=1.17.0

# Docker images
DOCKER_REGISTRY=ibmcom
SWREPO_IMAGE_VERSION=1.0-current
PM_IMAGE_VERSION=1.0-current

# Process parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: ./prereq-downloader platform platform_version"
    exit 1
fi
PLATFORM=$1
PLATFORM_VERSION=$2

# Downloaded prereqs location
FOLDER_NAME="prereqs_"$PLATFORM"_"$PLATFORM_VERSION
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
  echo "[*] Downloading Chef installation package..."
  if [[ $PLATFORM == *"ubuntu"* ]]; then
    CHEF_URL=https://packages.chef.io/files/stable/chef-server/$CHEF_VERSION/ubuntu/$PLATFORM_VERSION/chef-server-core_$CHEF_VERSION-1_amd64.deb
  else
    CHEF_URL=https://packages.chef.io/files/stable/chef-server/$CHEF_VERSION/el/$MAIN_VERSION/chef-server-core-$CHEF_VERSION-1.el$MAIN_VERSION.x86_64.rpm
  fi
  download_file $CHEF_URL chef.$PACKAGE_FORMAT
}

download_docker() {
  echo "[*] Downloading Docker installation package..."
  if [[ $PLATFORM == *"ubuntu"* ]]; then
    VERSION_NAME=$(get_ubuntu_version)
    DOCKER_URL=https://download.docker.com/linux/$PLATFORM/dists/$VERSION_NAME/pool/stable/amd64/docker-ce_$DOCKER_VERSION~ce-0~ubuntu_amd64.deb
  else
    DOCKER_URL=https://download.docker.com/linux/centos/$MAIN_VERSION/x86_64/stable/Packages/docker-ce-$DOCKER_VERSION.ce-1.el7.centos.x86_64.rpm
  fi
  download_file $DOCKER_URL docker.$PACKAGE_FORMAT
}

download_compose() {
  echo "[*] Downloading Docker Compose..."
  download_file https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 docker-compose
}

download_images() {
  echo "[*] Pulling Docker images..."
  docker pull $DOCKER_REGISTRY/camc-sw-repo:$SWREPO_IMAGE_VERSION
  docker pull $DOCKER_REGISTRY/camc-pattern-manager:$PM_IMAGE_VERSION
  echo "[*] Saving Docker images to files..."
  docker save $DOCKER_REGISTRY/camc-sw-repo:$SWREPO_IMAGE_VERSION > $FOLDER_NAME/camc-sw-repo
  docker save $DOCKER_REGISTRY/camc-pattern-manager:$PM_IMAGE_VERSION > $FOLDER_NAME/camc-pattern-manager
  echo "[*] Docker images saved succesfully"
}

download_cookbooks_and_templates() {
  echo "[*] Cloning git repositories..."
  ./../cloneGitRepositories/cloneRepositories.sh
  mv ../../src/IBM-CAMHub-Open.tar $FOLDER_NAME/
  rm -rf ../../src
  echo "[*] Git repositories cloned succesfully"
}

download_chef
download_docker
download_compose
download_images
download_cookbooks_and_templates
echo "[DONE] Succesfully downloaded all requirements to the folder: $FOLDER_NAME"
