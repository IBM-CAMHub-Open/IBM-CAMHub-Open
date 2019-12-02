 #!/bin/bash
#
# Copyright : IBM Corporation 2016, 2017
#

CAM_IP=''
CAM_USER='admin'
CAM_PASSWORD='admin'
CAM_nodePort='30000'

while test $# -gt 0; do
  [[ $1 =~ ^-c|--cam_ip$ ]] && { CAM_IP="$2"; shift 2; continue; };
  [[ $1 =~ ^-n|--CAM_nodePort$ ]] && { CAM_nodePort="$2"; shift 2; continue; };
  [[ $1 =~ ^-p|--cam_password$ ]] && { CAM_USER="$2"; shift 2; continue; };
  [[ $1 =~ ^-u|--cam_user$ ]] && { CAM_PASSWORD="$2"; shift 2; continue; };
done

if [ -z "$CAM_IP" ] || [ -z "$CAM_USER" ] || [ -z "$CAM_PASSWORD" ]; then
  echo "[ERROR] This script requires the IP address, username and password of the CAM instance"
  echo "[ERROR] Correct usage: $0 -c CAM_IP -u CAM_USER -p CAM_PASSWORD"
  exit 1
fi

if [[ "$OSTYPE" != *"linux"* ]]; then
  echo "[ERROR] This script must be executed from a Linux machine"
  exit 1
fi

obtain_access_id () {
  TOKEN_FILE=./token.json
  curl -k -H "Content-Type: application/json" -d '{"grant_type": "password", "password": $CAM_PASSWORD, "username": $CAM_USER, "scope": "openid"}' https://$CAM_IP:$CAM_nodePort/cam/v1/auth/identitytoken > $TOKEN_FILE

  if [ $? != 0 ]; then
    echo "[ERROR] There was an error retrieving the access ID from $CAM_IP"
    exit 1
  fi

  TOKEN=`grep -Eo '"access_token":(\d*?,|.*?[^\\]",)' $TOKEN_FILE | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`
}

obtain_tenant_id() {
  TENANT_FILE=./tenant.json
  curl -k -H "Authorization: bearer $TOKEN" https://$CAM_IP:$CAM_nodePort/cam/tenant/api/v1/tenants/getTenantOnPrem > $TENANT_FILE

  if [ $? != 0 ]; then
    echo "[ERROR] There was an error retrieving the tenant ID from $CAM_IP"
    exit 1
  fi

  TENANT_ID=`grep -Eo '"id":(\d*?,|.*?[^\\]",)' $TENANT_FILE | head -n 1 | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`
}

# Create content runtime using its catalog.json
upload_starterTemplates() {
  TEMPLATE_FOLDER=$1
  TF_File=$2
  ST_FILE=./starterTemplates.json
  echo "[*] Preprocessing $TEMPLATE_FOLDER/catalog.json"
  mv $TEMPLATE_FOLDER/catalog.json $TEMPLATE_FOLDER/catalog.json.back
  sed ':a;N;s/\n/&/1;Ta;/template_source/d' "$TEMPLATE_FOLDER/catalog.json.back" | sed -e '/githubRepoUrl/d;/githubAccessToken/d;/relativePathToTemplateFolder/d;/templateFileName/d' > $TEMPLATE_FOLDER/catalog.json
  curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "@$TEMPLATE_FOLDER/catalog.json" -X POST "https://$CAM_IP:$CAM_nodePort/cam/api/v1/templates?cloudOE_spaceGuid=default&ace_orgGuid=dummy-org-id&tenantId=$TENANT_ID" > $ST_FILE

  if [ $? != 0 ]; then
    echo "[ERROR] There was an error creating the Content Runtime $TEMPLATE_FOLDER/catalog.json on $CAM_IP"
    exit 1
  fi

  starterTemplates_ID=`grep -Eo '"default_template_version":(\d*?,|.*?[^\\]",)' $ST_FILE | head -n 1 | awk -F ':' '{print $2}' | awk -F '"' '{print $2}'`

  # Add the terraform template
  cat $TF_File | sed -e 's|\\|\\\\|g' | sed -e 's/\"/\\\"/g' | sed -e 's/\t/    /g' > tmp.tf
  CR_TERRAFORM=$(awk '{printf "%s\\n", $0}' tmp.tf)
  TF_PROVIDER=$(grep -Po '"template_provider":(\d*?,|.*?[^\\]",)' $TEMPLATE_FOLDER/catalog.json | awk -F ':' '{print $2}' | awk -F '"' '{print $2}')

  # Add camvariables
  VARIABLES=$(cat $TEMPLATE_FOLDER/camvariables.json)

  IFS=''
  echo '{"templateData":"'$CR_TERRAFORM'", "templateVariables": '$VARIABLES'}' > data.json
  unset IFS

  curl -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "@data.json" -X PUT "https://$CAM_IP:30000/cam/api/v1/templateVersions/$starterTemplates_ID?cloudOE_spaceGuid=default&ace_orgGuid=dummy-org-id&tenantId=$TENANT_ID" > result.json
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

  for cloud in $(find . -name catalog.json | sed 's|/[^/]*$||'); do
  [[ $cloud =~ ^(images) ]] && continue
   #TF_File=$(ls $cloud | egrep .tf | egrep -v bastionhost.tf)
   TF_Name=$(ls $cloud/*.tf | egrep -v "bastionhost.tf|output.tf|variables.tf|httpproxy.tf")
   echo "[*] Uploading $cloud"
  #echo "${cloud##*/}"
  #upload_starterTemplates $cloud
   upload_starterTemplates $cloud $TF_Name
  done

echo "[SUCCESS] Successfully uploaded Starter templates to $CAM_IP"
