
# IBM Cloud Automation Manager Hub

Copyright IBM Corp. 2018, 2020

The scripts in this branch has been enhanced to support IBM Cloud Automation Manager integration with IBM Multicloud Manager. Use this branch to load
content into IBM Cloud Automation Manager 4.x or IBM Multicloud Manager 1.3.x or higher.

The following Chef cookbooks and Terraform templates reside in this organization. This README will be updated each time the version of one of the cookbooks or templates is updated. Watch this repository to be notified when a new version of your cookbook or template is available.

See the [IBM Cloud Automation Manager knowledge center](https://www.ibm.com/support/knowledgecenter/en/SS2L37/kc_welcome.html) for more information.

## Helper script
 - [Git Repository Clone helper script](bin/cloneGitRepositories/)
 - [Requirement Downloader](bin/prereqDownloader/)

## Version Information




|cookbooks|version|readme|
|:----------|:---------------:|:---------------:|
| cookbook_apache_httpd_multios | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/cookbook_apache_httpd_multios/blob/master/README.md) |
| cookbook_apache_tomcat_multios | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/cookbook_apache_tomcat_multios/blob/master/README.md) |
| cookbook_ibm_cloud_utils_multios | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_cloud_utils_multios/blob/master/README.md) |
| cookbook_ibm_db2_multios | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_db2_multios/blob/master/README.md) |
| cookbook_ibm_ihs_multios | 2.0.2 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_ihs_multios/blob/master/README.md) |
| cookbook_ibm_im_multios | 2.0.1 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_im_multios/blob/master/README.md) |
| cookbook_ibm_utils_linux | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_utils_linux/blob/master/README.md) |
| cookbook_ibm_wasliberty_multios | 2.0.1 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_wasliberty_multios/blob/master/README.md) |
| cookbook_ibm_was_multios | 2.0.5 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_was_multios/blob/master/README.md) |
| cookbook_ibm_wmq_multios | 2.0.1 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_wmq_multios/blob/master/README.md) |
| cookbook_ibm_workflow_multios | 2.0.4 | [README](https://github.com/IBM-CAMHub-Open/cookbook_ibm_workflow_multios/blob/master/README.md) |
| cookbook_oracle_enterprisedatabase_multios | 2.0.5 | [README](https://github.com/IBM-CAMHub-Open/cookbook_oracle_enterprisedatabase_multios/blob/master/README.md) |
| cookbook_oracle_mysql_multios | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/cookbook_oracle_mysql_multios/blob/master/README.md) |


|templates|version|readme|
|:----------|:---------------:|:---------------:|
| template_ansible_node | 2.0.2 | [README](https://github.com/IBM-CAMHub-Open/template_ansible_node/blob/master/README.md) |
| template_ansible_playbook_example | 2.0.2 | [README](https://github.com/IBM-CAMHub-Open/template_ansible_playbook_example/blob/master/README.md) |
| template_apache_http_v24_standalone_basic | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_apache_http_v24_standalone_basic/blob/master/README.md) |
| template_apache_http_v24_standalone_full | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_apache_http_v24_standalone_full/blob/master/README.md) |
| template_apache_tomcat_v8_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_apache_tomcat_v8_standalone/blob/master/README.md) |
| template_cam_common | | [README](https://github.com/IBM-CAMHub-Open/template_cam_common/blob/master/README.md) |
| template_deploy_IBMi | | [README](https://github.com/IBM-CAMHub-Open/template_deploy_IBMi/blob/master/README.md) |
| template_git_clone_content_hub | 2.0.1 | [README](https://github.com/IBM-CAMHub-Open/template_git_clone_content_hub/blob/master/README.md) |
| template_ibm_db2_v10_multidb | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v10_multidb/blob/master/README.md) |
| template_ibm_db2_v10_multidisk | 2.1.4 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v10_multidisk/blob/master/README.md) |
| template_ibm_db2_v10_standalone | 2.1.4 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v10_standalone/blob/master/README.md) |
| template_ibm_db2_v11_multidb | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v11_multidb/blob/master/README.md) |
| template_ibm_db2_v11_multidisk | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v11_multidisk/blob/master/README.md) |
| template_ibm_db2_v11_standalone | 2.1.5 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v11_standalone/blob/master/README.md) |
| template_ibm_db2_v11_wasnd_v855_singleserver | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v11_wasnd_v855_singleserver/blob/master/README.md) |
| template_ibm_db2_v11_wasnd_v9_singleserver | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_db2_v11_wasnd_v9_singleserver/blob/master/README.md) |
| template_ibm_ihs_v855_standalone | 2.0.4 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_ihs_v855_standalone/blob/master/README.md) |
| template_ibm_ihs_v9_liberty | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_ihs_v9_liberty/blob/master/README.md) |
| template_ibm_ihs_v9_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_ihs_v9_standalone/blob/master/README.md) |
| template_ibm_mq_v8_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_mq_v8_standalone/blob/master/README.md) |
| template_ibm_mq_v9_standalone | 2.1.1 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_mq_v9_standalone/blob/master/README.md) |
| template_ibm_mq_v9_with_custom_mqsc | 2.1.1 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_mq_v9_with_custom_mqsc/blob/master/README.md) |
| template_ibm_roks | | [README](https://github.com/IBM-CAMHub-Open/template_ibm_roks/blob/master/README.md) |
| template_ibm_wasliberty_v17_serverfarm | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_wasliberty_v17_serverfarm/blob/master/README.md) |
| template_ibm_wasliberty_v17_standalone | 2.1.1 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_wasliberty_v17_standalone/blob/master/README.md) |
| template_ibm_wasnd_v855_multinode | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_wasnd_v855_multinode/blob/master/README.md) |
| template_ibm_wasnd_v855_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_wasnd_v855_standalone/blob/master/README.md) |
| template_ibm_wasnd_v9_multinode | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_wasnd_v9_multinode/blob/master/README.md) |
| template_ibm_wasnd_v9_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_wasnd_v9_standalone/blob/master/README.md) |
| template_ibm_workflow_multinode | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_workflow_multinode/blob/master/README.md) |
| template_ibm_workflow_singlenode | 3.0.0 | [README](https://github.com/IBM-CAMHub-Open/template_ibm_workflow_singlenode/blob/master/README.md) |
| template_icp_aws | 3.1.1.7 | [README](https://github.com/IBM-CAMHub-Open/template_icp_aws/blob/master/README.md) |
| template_icp_azure | 3.1.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_icp_azure/blob/master/README.md) |
| template_icp_googlecloud | 3.1.1.3 | [README](https://github.com/IBM-CAMHub-Open/template_icp_googlecloud/blob/master/README.md) |
| template_icp_ibmcloud | 3.1.1.13 | [README](https://github.com/IBM-CAMHub-Open/template_icp_ibmcloud/blob/master/README.md) |
| template_icp_installer | 2.3.4 | [README](https://github.com/IBM-CAMHub-Open/template_icp_installer/blob/master/README.md) |
| template_icp_installer_medium | 2.3.5 | [README](https://github.com/IBM-CAMHub-Open/template_icp_installer_medium/blob/master/README.md) |
| template_icp_installer_single | 2.3.4 | [README](https://github.com/IBM-CAMHub-Open/template_icp_installer_single/blob/master/README.md) |
| template_icp_modules | 2.3.9 | [README](https://github.com/IBM-CAMHub-Open/template_icp_modules/blob/master/README.md) |
| template_icp_node | 2.0.0 | [README](https://github.com/IBM-CAMHub-Open/template_icp_node/blob/master/README.md) |
| template_icp_on_ocp | | [README](https://github.com/IBM-CAMHub-Open/template_icp_on_ocp/blob/master/README.md) |
| template_icp_upgrade | | [README](https://github.com/IBM-CAMHub-Open/template_icp_upgrade/blob/master/README.md) |
| template_import_openstack | | [README](https://github.com/IBM-CAMHub-Open/template_import_openstack/blob/master/README.md) |
| template_import_vmware | 1.0.2 | [README](https://github.com/IBM-CAMHub-Open/template_import_vmware/blob/master/README.md) |
| template_integration_apm | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_integration_apm/blob/master/README.md) |
| template_integration_apm_was | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_integration_apm_was/blob/master/README.md) |
| template_integration_cam | | [README](https://github.com/IBM-CAMHub-Open/template_integration_cam/blob/master/README.md) |
| template_integration_icam | 2.1.3 | [README](https://github.com/IBM-CAMHub-Open/template_integration_icam/blob/master/README.md) |
| template_integration_icp-elk | 2.1.1 | [README](https://github.com/IBM-CAMHub-Open/template_integration_icp-elk/blob/master/README.md) |
| template_integration_ilmt | 1.0.2 | [README](https://github.com/IBM-CAMHub-Open/template_integration_ilmt/blob/master/README.md) |
| template_integration_infoblox | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_integration_infoblox/blob/master/README.md) |
| template_integration_servicenow | 2.0.4 | [README](https://github.com/IBM-CAMHub-Open/template_integration_servicenow/blob/master/README.md) |
| template_kubernetes_aks | | [README](https://github.com/IBM-CAMHub-Open/template_kubernetes_aks/blob/master/README.md) |
| template_kubernetes_eks | | [README](https://github.com/IBM-CAMHub-Open/template_kubernetes_eks/blob/master/README.md) |
| template_kubernetes_gke | | [README](https://github.com/IBM-CAMHub-Open/template_kubernetes_gke/blob/master/README.md) |
| template_kubernetes_iks | | [README](https://github.com/IBM-CAMHub-Open/template_kubernetes_iks/blob/master/README.md) |
| template_lamp_stack_v1_standalone | 2.1.3 | [README](https://github.com/IBM-CAMHub-Open/template_lamp_stack_v1_standalone/blob/master/README.md) |
| template_mcm_install | 3.1.1.4 | [README](https://github.com/IBM-CAMHub-Open/template_mcm_install/blob/master/README.md) |
| template_mcm_modules | 3.1.1.8 | [README](https://github.com/IBM-CAMHub-Open/template_mcm_modules/blob/master/README.md) |
| template_openshift_installer | | [README](https://github.com/IBM-CAMHub-Open/template_openshift_installer/blob/master/README.md) |
| template_openshift_installer_single | | [README](https://github.com/IBM-CAMHub-Open/template_openshift_installer_single/blob/master/README.md) |
| template_openshift_modules | | [README](https://github.com/IBM-CAMHub-Open/template_openshift_modules/blob/master/README.md) |
| template_openshift_node | | [README](https://github.com/IBM-CAMHub-Open/template_openshift_node/blob/master/README.md) |
| template_oracle_database_v12c_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_oracle_database_v12c_standalone/blob/master/README.md) |
| template_oracle_mysql_v57_standalone | 2.1.2 | [README](https://github.com/IBM-CAMHub-Open/template_oracle_mysql_v57_standalone/blob/master/README.md) |
