#  prereq-downloader.sh
This script can be used to download installation prerequisites for Offline deployment of IBM Cloud Automation Manager Advanced Content Runtime.

### Usage :
```
cd IBM-CAMHub-Open/bin/prereqDownloader/
./prereq-downloader.sh <platform> <version>
```
- An installation of Docker is REQUIRED on the machine where the script is executed
- The versions of software to be downloaded can be changed in the lines 17-19

### Output :

- The following files are prerequisites for an Offline Advanced Content Runtime installation
- Place these files in a directory on the virtual machine being used for the Offline Advanced Content Runtime
- Specify the file location during provisioning of the Offline Advanced Content Runtime template 

camc-pattern-manager
- Docker image for IBM Cloud Automation Manager Advanced Content Runtime Pattern Manager

camc-sw-repo
- Docker image for the IBM Cloud Automation Manager Advanced Content Runtime software repository

chef.(deb,rpm)
- Platform specific Chef server package

docker.(deb,rpm)
- Platform specific Docker package

docker-compose
- docker-compose binary


IBM-CAMHub-Open.tar (via cloneGitRepositories.sh)
- tar file containing Chef cookbooks
- Place in /var of the virtual machine being used for the Offline Advanced Content Runtime

IBM-CAMHub-Open_templates.tar (via cloneGitRepositories.sh)
- tar file containing Terraform templates
- Simplifies download for import into Gitlab, GHE or manual load into Cloud Automation Manager
