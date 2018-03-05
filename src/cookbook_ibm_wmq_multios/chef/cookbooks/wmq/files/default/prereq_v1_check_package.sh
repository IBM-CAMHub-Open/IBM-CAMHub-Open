pack=$1
########################################################
#	  Copyright IBM Corp. 2012, 2017
########################################################
tmpfile=$2
#
echo "#------------------------------------------------------------------------"
echo "#------------------------------------------------------------------------"
echo "# This script will check if package $pack is installed                   "
os=$(uname)
echo ""
if [ $os = AIX ]
   then
      echo $pack | awk '{if ($0 ~ /\./) {print "lslpp -l " $0} else {print "instfix -ik " $0} }' | ksh > $tmpfile 2>&1
      if [ $? -eq 0 ]
      then
       c=1
      else
       c=0
      fi
fi

if [ $os = Linux ]
   then
      rpm -qa --queryformat "[%{NAME} %{VERSION} %{ARCH}\n]" | grep $pack  > $tmpfile 2>&1
      if [ $? -eq 0 ]
      then
       c=1
       awk '{print "The package "$1" version "$2" for "$3 " arch is installed"}' $tmpfile > $tmpfile.2
       mv $tmpfile.2 $tmpfile
    else
       c=0
    fi
fi

if [ $c = 0 ]
   then
      echo "####### error ############### error ############### error ########"
      echo "Error - $pack is not installed on the system                      "
      echo "####### error ############### error ############### error ########"
      echo "package -- $pack is not installed on the system "  >> $tmpfile.err
      exit 8
   else
      echo "##################################################################"
      echo "Package $pack is installed:                                       "
      grep $pack $tmpfile
      echo "##################################################################"
      exit 0
fi
#
