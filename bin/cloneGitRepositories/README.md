#  cloneRepositories.sh
This script can be used to simplify the download of Terraform templates and Chef cookbooks which are available for use with IBM Cloud Automation Manager or IBM CloudPak for Multicloud Management.

### Usage :
```
cd IBM-CAMHub-Open/bin/cloneGitRepositories/
./cloneRepositories.sh --branch 2.0 --release 5100
```
branch - Cookbooks branch. Latest branch is 2.0. Default value is 2.0

release - Release of IBM Cloud Automation Manager or IBM CloudPak for Multicloud Management. This value is used to clone the template (and versions) that pertains to the release. The templates that are cloned is defined in file template<release>. The following table maps the product release name to the value required for this argument. Default value is 5300

| Product Release        | Value for argument release     | Corresponding template file    |
|------------------------|--------------------------------|--------------------------------|
| IBM CAM 4.2.0.x        | 4200                           | template4200                   |
| IBM CP4MCM 2.0         | 5000                           | template5000                   |
| IBM CP4MCM 2.1         | 5100                           | template5100                   |
| IBM CP4MCM 2.2         | 5200                           | template5200                   |
| IBM CP4MCM 2.3         | 5300                           | template5300                   |



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

IBM-CAMHub-Open_starterlibrary.tar
- tar file containing terraform template samples in starterlibrary
- You can import the starter library using loadStarterTemplates.sh when you decide not to store starterlibrary in Gitlab or GHE. 