#-----------------------------------------------------------------------------
########################################################
#	  Copyright IBM Corp. 2012, 2017
########################################################
# Name             - prereq-v2-check-aix-ifix.sh
# Purpose          - Prereq check to verify aix apars ifix
# Parameters       - listifix
#
#---------------------------------------------------------------------
listifix=$1
######################################################################
num_members_list=$(echo ${listifix} | awk '{ for (i =1; i <= NF; i++) print $i }' | wc -l )
######################################################################
f_check_ifix_aix()
{
echo "LIST AIX IFIX: $listifix"
count=$(/usr/sbin/instfix -i -k "${listifix}" | grep "were found" | wc -l)
if [ "$count" = "$num_members_list" ];then
          echo "INFO: APARS IFIX'S ${listifix} ARE INSTALLED ON THE SYSTEM!"
          exit 0
else
          echo "ERROR: APARS IFIX'S ${listifix} ARE NOT INSTALLED ON THE SYSTEM!"
          exit 1
fi
}

#=====================================================================
#  main section
#=====================================================================
os=$(uname)
echo "#------------------------------------------------------------------------"
echo "#------------------------------------------------------------------------"

if [ "$os" = "AIX" ]; then f_check_ifix_aix
else                       exit 0
fi
