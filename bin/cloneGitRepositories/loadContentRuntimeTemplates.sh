#!/bin/bash
#
# Copyright : IBM Corporation 2020
#

CAM_CONSOLE=''
MCM_CONSOLE=''
CAM_USER=''
CAM_PASSWORD=''

while test $# -gt 0; do
  [[ $1 =~ ^-c|--cam_console$ ]] && { CAM_CONSOLE="$2"; shift 2; continue; };
  [[ $1 =~ ^-m|--mcm_console$ ]] && { MCM_CONSOLE="$2"; shift 2; continue; };
  [[ $1 =~ ^-p|--cam_password$ ]] && { CAM_PASSWORD="$2"; shift 2; continue; };
  [[ $1 =~ ^-u|--cam_user$ ]] && { CAM_USER="$2"; shift 2; continue; };
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
upload_content_runtime() {
  TEMPLATE_FOLDER=$1
  CR_FILE=./content_runtime.json
  echo "[*] Preprocessing $TEMPLATE_FOLDER/camtemplate.json"
  mv $TEMPLATE_FOLDER/camtemplate.json $TEMPLATE_FOLDER/camtemplate.json.back
  sed ':a;N;s/\n/&/1;Ta;/template_source/d' "$TEMPLATE_FOLDER/camtemplate.json.back" | sed -e '/githubRepoUrl/d;/githubAccessToken/d;/relativePathToTemplateFolder/d;/templateFileName/d' > $TEMPLATE_FOLDER/camtemplate.json
  curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "@$TEMPLATE_FOLDER/camtemplate.json" -X POST "https://$CAM_CONSOLE/cam/api/v1/templates?cloudOE_spaceGuid=default&ace_orgGuid=dummy-org-id&tenantId=$TENANT_ID" > $CR_FILE

  if [ $? != 0 ]; then
    echo "[ERROR] There was an error creating the Content Runtime $TEMPLATE_FOLDER/camtemplate.json on $CAM_CONSOLE"
    exit 1
  fi

  CONTENT_RUNTIME_ID=`grep -Eo '"default_template_version":(\d*?,|.*?[^\\]",)' $CR_FILE | head -n 1 | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`

  # Add the terraform template
  cat $TEMPLATE_FOLDER/content_runtime.tf | sed -e 's|\\|\\\\|g' | sed -e 's/\"/\\\"/g' | sed -e 's/\t/    /g' > tmp.tf
  CR_TERRAFORM=$(awk '{printf "%s\\n", $0}' tmp.tf)
  TF_PROVIDER=$(grep -Po '"template_provider":(\d*?,|.*?[^\\]",)' $TEMPLATE_FOLDER/camtemplate.json | awk -F ':' '{print $2}' | awk -F '"' '{print $2}')

  # Add camvariables
  VARIABLES=$(cat $TEMPLATE_FOLDER/camvariables.json)

  IFS=''
  echo '{"templateData":"'$CR_TERRAFORM'", "templateVariables": '$VARIABLES'}' > data.json
  unset IFS

  curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "@data.json" -X PUT "https://$CAM_CONSOLE/cam/api/v1/templateVersions/$CONTENT_RUNTIME_ID?cloudOE_spaceGuid=default&ace_orgGuid=dummy-org-id&tenantId=$TENANT_ID" > result.json
  if [ $? != 0 ]; then
    echo "[ERROR] There was an error adding the Content Runtime template from: $TEMPLATE_FOLDER/content_runtime.tf"
    exit 1
  fi
  rm -rf $CR_FILE tmp.tf data.json
}

echo "[*] Obtaining Access ID"
obtain_access_id

echo "[*] Obtaining Tenant ID"
obtain_tenant_id

for cloud in content_runtime_template/*; do
 for template in $cloud/*; do
   echo "[*] Uploading $template"
   upload_content_runtime $template
 done
done

echo "[SUCCESS] Successfully uploaded Content Runtime templates to $CAM_CONSOLE"
