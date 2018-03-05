#---------------------------------------------------------------------
########################################################
#	  Copyright IBM Corp. 2012, 2017
########################################################
# Name             - prereq-check-os-version.sh
# Purpose          - Prereq check to verify os version
# Parameters       - osversion
#
#---------------------------------------------------------------------
osversion=$1
######################################################################
case=$(echo "$osversion" | awk -F "-" '{ for(i=1; i<=NF; i++) print NF}' | uniq)
######################################################################
message="INFO: OS VERSION IS OK"

f_check_version_aix_4()
{
osversion=$1
#######################################################################
MM1=$(echo $osversion | awk -F "-" '{print $1}');M1=$(echo $MM1 | awk '{ printf ( "%d", $1)}')
MM2=$(echo $osversion | awk -F "-" '{print $2}');M2=$(echo $MM2 | awk '{ printf ( "%d", $1)}')
MM3=$(echo $osversion | awk -F "-" '{print $3}');M3=$(echo $MM3 | awk '{ printf ( "%d", $1)}')
MM4=$(echo $osversion | awk -F "-" '{print $4}');M4=$(echo $MM4 | awk '{ printf ( "%d", $1)}')
#######################################################################
# -----------------------------------------#
NN1=$(oslevel -s | awk -F "-" '{print $1}');N1=$(echo $NN1 | awk '{ printf ( "%d", $1)}')
NN2=$(oslevel -s | awk -F "-" '{print $2}');N2=$(echo $NN2 | awk '{ printf ( "%d", $1)}')
NN3=$(oslevel -s | awk -F "-" '{print $3}');N3=$(echo $NN3 | awk '{ printf ( "%d", $1)}')
NN4=$(oslevel -s | awk -F "-" '{print $4}');N4=$(echo $NN4 | awk '{ printf ( "%d", $1)}')

if (( $N1 >= $M1 )) && (( $N2 >= $M2 )) && (( $N3 >= $M3 )) && (( $N4 >= $M4 )); then echo "$message"; exit 0
else                                                                                  exit 1
fi
}

f_check_version_aix_3()
{
osversion=$1
#######################################################################
MM1=$(echo $osversion | awk -F "-" '{print $1}');M1=$(echo $MM1 | awk '{ printf ( "%d", $1)}')
MM2=$(echo $osversion | awk -F "-" '{print $2}');M2=$(echo $MM2 | awk '{ printf ( "%d", $1)}')
MM3=$(echo $osversion | awk -F "-" '{print $3}');M3=$(echo $MM3 | awk '{ printf ( "%d", $1)}')
#######################################################################
# -----------------------------------------#
NN1=$(oslevel -s | awk -F "-" '{print $1}'); N1=$(echo $NN1 | awk '{ printf ( "%d", $1)}')
NN2=$(oslevel -s | awk -F "-" '{print $2}'); N2=$(echo $NN2 | awk '{ printf ( "%d", $1)}')
NN3=$(oslevel -s | awk -F "-" '{print $3}'); N3=$(echo $NN3 | awk '{ printf ( "%d", $1)}')


if (( $N1 >= $M1 )) && (( $N2 >= $M2 )) && (( $N3 >= $M3 )); then echo "$message"; exit 0
else                                                              exit 1
fi
}

f_check_version_aix_2()
{
osversion=$1
#######################################################################
MM1=$(echo $osversion | awk -F "-" '{print $1}');M1=$(echo $MM1 | awk '{ printf ( "%d", $1)}')
MM2=$(echo $osversion | awk -F "-" '{print $2}');M2=$(echo $MM2 | awk '{ printf ( "%d", $1)}')
#######################################################################
# -----------------------------------------#
NN1=$(oslevel -s | awk -F "-" '{print $1}');N1=$(echo $NN1 | awk '{ printf ( "%d", $1)}')
NN2=$(oslevel -s | awk -F "-" '{print $2}');N2=$(echo $NN2 | awk '{ printf ( "%d", $1)}')

if (( $N1 >= $M1 )) && (( $N2 >= $M2 )); then echo "$message"; exit 0
else                                          exit 1
fi
}

f_check_version_aix_1()
{
osversion=$1
#######################################################################
MM1=$(echo $osversion | awk -F "-" '{print $1}');M1=$(echo $MM1 | awk '{ printf ( "%d", $1)}')
#######################################################################
# -----------------------------------------#
NN1=$(oslevel -s | awk -F "-" '{print $1}'); N1=$(echo $NN1 | awk '{ printf ( "%d", $1)}')

if (( $N1 >= $M1 )); then echo "$message"; exit 0
else                      exit 1
fi
}

#===============================================================================
#  main section
#===============================================================================
os=$(uname)
echo "#------------------------------------------------------------------------"
echo "#------------------------------------------------------------------------"

echo $osversion

if [ "$os" = "AIX" ]; then
   f_check_version_aix_${case} ${osversion}
   exit 0
else                       exit 0
fi
