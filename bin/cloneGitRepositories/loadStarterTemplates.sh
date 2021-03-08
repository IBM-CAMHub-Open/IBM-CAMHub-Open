CAM_CONSOLE=''
MCM_CONSOLE=''
CAM_USER=''
CAM_PASSWORD=''
SUPPORTED_ONLY='no'

EXCLUDE_OOB_REPOS_LIST=( './BlueMix/terraform/hcl/strongloop-single-stack' './BlueMix/terraform/hcl/strongloop-three-tiers' './BlueMix/terraform/hcl/mongodb' './BlueMix/terraform/hcl/nodejs' './VRA/terraform/hcl/cluster-deploy' './IBM_Cloud/blockchain-platform' './IBM_Cloud/cf-goapp-sample' './IBM_Cloud/watson-service-sample' './IBM_Cloud/hpc-fss-cluster' './IBM_Cloud/helm-tiller' './IBM_Cloud/cloudant' './VMware/terraform/hcl/tomcat' './VMware/terraform/hcl/mariadb' './VMware/terraform/hcl/strongloop-single-stack' './VMware/terraform/hcl/strongloop-three-tiers' './VMware/terraform/hcl/mongodb' './VMware/terraform/hcl/nodejs' )

while test $# -gt 0; do
  [[ $1 =~ ^-c|--cam_console$ ]] && { CAM_CONSOLE="$2"; shift 2; continue; };
  [[ $1 =~ ^-m|--mcm_console$ ]] && { MCM_CONSOLE="$2"; shift 2; continue; };
  [[ $1 =~ ^-p|--cam_password$ ]] && { CAM_PASSWORD="$2"; shift 2; continue; };
  [[ $1 =~ ^-u|--cam_user$ ]] && { CAM_USER="$2"; shift 2; continue; };
  [[ $1 =~ ^-s|--supported_only$ ]] && { SUPPORTED_ONLY="$2"; shift 2; continue; };
done

if [ -z "$CAM_CONSOLE" ] || [ -z "$MCM_CONSOLE" ] || [ -z "$CAM_USER" ] || [ -z "$CAM_PASSWORD" ]; then
  echo "[ERROR] This script requires the CAM Console, username and password of the CAM instance"
  echo "[ERROR] Correct usage: $0 -c CAM_CONSOLE -u CAM_USER -p CAM_PASSWORD -m MCM_CONSOLE"
  exit 1
fi

if [[ "$OSTYPE" != *"linux"* ]]; then
  echo "[ERROR] This script must be executed from a Linux machine"
  exit 1
fi

obtain_access_id () {
  TOKEN_FILE=./token.json
  curl -k -H "Content-Type: application/json" -d '{"grant_type": "password", "password": "'$CAM_PASSWORD'", "username": "'$CAM_USER'", "scope": "openid"}' https://$MCM_CONSOLE/idprovider/v1/auth/identitytoken > $TOKEN_FILE

  if [ $? != 0 ]; then
    echo "[ERROR] There was an error retrieving the access ID from $MCM_CONSOLE"
    exit 1
  fi

  TOKEN=`grep -Eo '"access_token":(\d*?,|.*?[^\\]",)' $TOKEN_FILE | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`
}

obtain_tenant_id() {
  TENANT_FILE=./tenant.json
  curl -k -H "Authorization: bearer $TOKEN" https://$CAM_CONSOLE/cam/tenant/api/v1/tenants/getTenantOnPrem > $TENANT_FILE

  if [ $? != 0 ]; then
    echo "[ERROR] There was an error retrieving the tenant ID from $CAM_CONSOLE"
    exit 1
  fi

  TENANT_ID=`grep -Eo '"id":(\d*?,|.*?[^\\]",)' $TENANT_FILE | head -n 1 | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`
}

# Create content runtime using its catalog.json
upload_starterTemplates() {
  TEMPLATE_FOLDER=$1
  TF_File=$2
  ST_FILE=./starterTemplates.json
  echo "[*] Preprocessing $TEMPLATE_FOLDER/camtemplate.json"
  mv $TEMPLATE_FOLDER/camtemplate.json $TEMPLATE_FOLDER/camtemplate.json.back
  #sed ':a;N;s/\n/&/1;Ta;/template_source/d' "$TEMPLATE_FOLDER/camtemplate.json.back" | sed -e '/githubRepoUrl/d;/githubAccessToken/d;/relativePathToTemplateFolder/d;/templateFileName/d' > $TEMPLATE_FOLDER/camtemplate.json
  #Delete the first occurence of }, followed by rest if the template_source
  sed '0,/},/{/},/d};/template_source/d' "$TEMPLATE_FOLDER/camtemplate.json.back" | sed -e '/githubRepoUrl/d;/githubAccessToken/d;/relativePathToTemplateFolder/d;/templateFileName/d' > $TEMPLATE_FOLDER/camtemplate.json
  #echo -e "\ncurl camtemplate\n" >> result.json
  curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "@$TEMPLATE_FOLDER/camtemplate.json" -X POST "https://$CAM_CONSOLE/cam/api/v1/templates?cloudOE_spaceGuid=default&ace_orgGuid=dummy-org-id&tenantId=$TENANT_ID" > $ST_FILE

  if [ $? != 0 ]; then 
    echo "[ERROR] There was an error creating the Content Runtime $TEMPLATE_FOLDER/camtemplate.json on $CAM_IP"
    exit 1
  fi
  #echo -e "\nstart stfile\n" >> result.json
  #cat $ST_FILE >> result.json
  #echo -e "\nend_stfile\n" >> result.json
  starterTemplates_ID=`grep -Eo '"default_template_version":(\d*?,|.*?[^\\]",)' $ST_FILE | head -n 1 | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`

  # Add the terraform template
  cat $TF_File | sed -e 's|\\|\\\\|g' | sed -e 's/\"/\\\"/g' | sed -e 's/\t/    /g' > tmp.tf
  CR_TERRAFORM=$(awk '{printf "%s\\n", $0}' tmp.tf)
  TF_PROVIDER=$(grep -Po '"template_provider":(\d*?,|.*?[^\\]",)' $TEMPLATE_FOLDER/camtemplate.json | awk -F ':' '{print $2}' | awk -F '"' '{print $2}')

  # Add camvariables
  VARIABLES=$(cat $TEMPLATE_FOLDER/camvariables.json)

  IFS=''
  echo '{"templateData":"'$CR_TERRAFORM'", "templateVariables": '$VARIABLES'}' > data.json
  unset IFS
  #echo -e "\ncurl template\n" >> result.json
  curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "@data.json" -X PUT "https://$CAM_CONSOLE/cam/api/v1/templateVersions/$starterTemplates_ID?cloudOE_spaceGuid=default&ace_orgGuid=dummy-org-id&tenantId=$TENANT_ID" > result.json
  if [ $? != 0 ]; then
    echo "[ERROR] There was an error adding the Content Runtime template from: $TF_File"
    exit 1
  fi
  rm -rf $ST_FILE tmp.tf data.json
}

echo "[*] Obtaining Access ID"
obtain_access_id

echo "[*] Obtaining Tenant ID"
obtain_tenant_id

for cloud in $(find . -name camtemplate.json | sed 's|/[^/]*$||'); do
  [[ $cloud =~ ^(images) ]] && continue
  if [[ "$SUPPORTED_ONLY" == "yes" ]]; then
    load=1
    for aexclude in "${EXCLUDE_OOB_REPOS_LIST[@]}"
    do
      if [[ "$aexclude" == "$cloud" ]]; then
       load=0
       break
      fi
    done
    if [[ $load -eq 1 ]]; then
      echo "Load supported template $cloud"
    else
      echo "Load only supported templates is set to yes. Skipping $cloud"
    fi
  fi
  #Merge all TF files
  paste --serial --delimiter=\\n $cloud/*.tf > $cloud/main_load_template.tf
  #Use awk if paste not in os
  #awk 'FNR==1{print ""}1' $cloud/*.tf > $cloud/main_load_template.tf
  #TF_Name=$(ls $cloud/*.tf | egrep -v "bastionhost.tf|output.tf|variables.tf|httpproxy.tf")
  TF_Name=$cloud/main_load_template.tf
  echo "[*] Uploading $cloud"
  #echo "${cloud##*/}"
  #upload_starterTemplates $cloud
  upload_starterTemplates $cloud $TF_Name
done

echo "[SUCCESS] Successfully uploaded Starter templates to $CAM_CONSOLE"
