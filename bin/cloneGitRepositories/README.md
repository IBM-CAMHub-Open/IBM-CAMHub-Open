#  cloneRepositories.sh
This script can be used to simplify the download of Terraform templates and Chef cookbooks which are available for use with IBM Cloud Automation Manager.

### Usage :
```
cd IBM-CAMHub-Open/bin/cloneGitRepositories/
./cloneRepositories.sh
```

### Output :

IBM-CAMHub-Open.tar
- tar file containing Chef cookbooks
- Used for importing cookbooks during an Offline Advanced Content Runtime installation
- Place in /var of the virtual machine being used for the Offline Advanced Content Runtime

IBM-CAMHub-Open_templates.tar
- tar file containing Terraform templates
- Simplifies download for import into Gitlab, GHE or manual load into IBM Cloud Automation Manager
