#  prereq-downloader.sh
This script can be used to download installation prerequisites for an offline deployment of IBM Cloud Automation Manager Content Runtime.

### Usage :
```
cd IBM-CAMHub-Open/bin/prereqDownloader/
./prereq-downloader.sh <platform> <version>
```
- An installation of Docker is REQUIRED on the machine where the script is executed
- The versions of software to be downloaded can be changed in the lines 17-19

### Output :

- The following files are prerequisites for an offline Content Runtime installation
- Place these files in a directory on the virtual machine being used for the offline Content Runtime
- Specify the file location during provisioning of the offline Content Runtime template

camc-pattern-manager
- Docker image for IBM Cloud Automation Manager Content Runtime Pattern Manager

camc-sw-repo
- Docker image for the IBM Cloud Automation Manager Content Runtime software repository

chef.(deb,rpm)
- Platform specific Chef server package

docker.(deb,rpm)
- Platform specific Docker package

docker-compose
- docker-compose binary

loadContenRuntimeTemplates.sh
- Script to load Content Runtime templates only in the case where GitLab or GHE are not available

IBM-CAMHub-Open_advanced_content_runtime.tar (via cloneGitRepositories.sh)
- tar file containing Content Runtime Terraform templates
- For an offline environment, this tar simplifies download for import into Gitlab or GHE
- Alternatively, import into Cloud Automation Manager using loadContentRuntimeTemplates.sh

IBM-CAMHub-Open.tar (via cloneGitRepositories.sh)
- tar file containing Chef cookbooks
- Used for importing cookbooks during an offline Content Runtime provision
- Place in /var of the virtual machine being used for the offline Content Runtime

IBM-CAMHub-Open_templates.tar (via cloneGitRepositories.sh)
- tar file containing Terraform templates
- Simplifies download for import into Gitlab, GHE or manual load into Cloud Automation Manager
