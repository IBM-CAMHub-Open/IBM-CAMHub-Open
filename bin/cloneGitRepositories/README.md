#  cloneRepositories.sh
This script can be used to simplify the download of Terraform templates and Chef cookbooks which are available for use with IBM Cloud Automation Manager.

### Usage :
```
cd IBM-CAMHub-Open/bin/cloneGitRepositories/
./cloneRepositories.sh
```

### Output :

IBM-CAMHub-Open_advanced_content_runtime.tar
- tar file containing Content Runtime Terraform templates
- For an offline environment, this tar simplifies download for import into Gitlab or GHE
- loadContentRuntimeTemplates.sh is a script to load Content Runtime templates only in the case where GitLab or GHE are not available

IBM-CAMHub-Open.tar
- tar file containing Chef cookbooks
- Used for importing cookbooks during an offline Content Runtime provision
- Place in /var of the virtual machine being used for the offline Content Runtime

IBM-CAMHub-Open_templates.tar
- tar file containing Terraform templates
- Simplifies download for import into Gitlab, GHE or manual load into IBM Cloud Automation Manager
