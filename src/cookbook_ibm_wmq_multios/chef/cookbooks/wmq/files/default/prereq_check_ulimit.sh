#-----------------------------------------------------------------------------
########################################################
#	  Copyright IBM Corp. 2012, 2017
########################################################
# Name             - prereq-v2-check-ulimit.sh
# Purpose          - Prereq check to verify ulimit settings
# Parameters       - username ulimit ulimitvalue tempfile autofix
#
#-----------------------------------------------------------------------------
# --------------------------------------
user=$1
ulmt="$2"
ulmtval=$3
tmpfile=$4
autofix=$5



#=====================================================================
f_set_ulimit_linux()	#
#=====================================================================
# Arg_1 = username
# Arg_2 = limitname
# Arg_3 = ulimitvalue
{
num=`grep "^[[:space:]]*$1[[:space:]]\{1,\}soft[[:space:]]\{1,\}$2[[:space:]]\{1,\}.*" /etc/security/limits.conf | wc -l`
fileext=`date +%Y%M%d%H%M%S`
echo $num
if [ $num -eq 1 ]
	then
		echo "soft limit will be modified"
		cat /etc/security/limits.conf | sed "s#^[[:space:]]*$1[[:space:]]\{1,\}soft[[:space:]]\{1,\}$2.*#$1 soft $2 $3#g" >> /tmp/limits.$fileext
		cp -p /etc/security/limits.conf /etc/security/limits.conf.$fileext
		cp /tmp/limits.$fileext /etc/security/limits.conf
		rm /tmp/limits.$fileext
	else
		`echo $1 soft $2 $3 >> /etc/security/limits.conf`
		`echo $1 hard $2 $3 >> /etc/security/limits.conf`
fi

num2=`grep "^[[:space:]]*$1[[:space:]]\{1,\}hard[[:space:]]\{1,\}$2[[:space:]]\{1,\}.*" /etc/security/limits.conf | wc -l`
fileext=`date +%Y%M%d%H%M%S`
echo $num2
if [ $num2 -eq 1 ]
	then
		echo "limit will be modified"
		cat /etc/security/limits.conf | sed "s#^[[:space:]]*$1[[:space:]]\{1,\}hard[[:space:]]\{1,\}$2.*#$1 hard $2 $3#g" >> /tmp/limits.$fileext
		cp -p /etc/security/limits.conf /etc/security/limits.conf.$fileext
		cp /tmp/limits.$fileext /etc/security/limits.conf
		rm /tmp/limits.$fileext
	else
		`echo $1 hard $2 $3 >> /etc/security/limits.conf`
fi
}
#=====================================================================



#=====================================================================
f_set_ulimit_aix()	#
#=====================================================================
# Arg_1 = username
# Arg_2 = limitname
# Arg_3 = ulimitvalue
{

echo "function not implemented for AIX yet"
exit 8
}
#=====================================================================




#=====================================================================
f_set_ulimit()	#
#=====================================================================
# Arg_1 = username
# Arg_2 = limitname
# Arg_3 = ulimitvalue
{
os=`uname`
case "$os" in
	Linux	)	f_set_ulimit_linux $1 $2 $3 ;;
	AIX		)	f_set_ulimit_aix $1 $2 $3	;;

esac
}
#=====================================================================



#=====================================================================
#  main section
#=====================================================================
echo "#------------------------------------------------------------------------"
echo "#------------------------------------------------------------------------"
echo "# This script will check ulimit setting -$ulmt- is at least $ulmtval "
echo "# and set it to $ulmtval if autofix is set to Y "
echo ""
su - $user -c "ulimit -a"
echo ""
case "$ulmt" in
   core*              ) b=`su - $user -c "ulimit -c"` ;;
   data*              ) b=`su - $user -c "ulimit -d"` ;;
   file*              ) b=`su - $user -c "ulimit -f"` ;;
   pend* | max*loc*   ) b=`su - $user -c "ulimit -i"` ;;
   memo* | max*mem*   ) b=`su - $user -c "ulimit -m"` ;;
   nofil* | open*     ) b=`su - $user -c "ulimit -n"` ;;
   pipe*              ) b=`su - $user -c "ulimit -p"` ;;
   POSI*              ) b=`su - $user -c "ulimit -q"` ;;
   thr*               ) b=`su - $user -c "ulimit -r"` ;;
   stac*              ) b=`su - $user -c "ulimit -s"` ;;
   cpu* | time*       ) b=`su - $user -c "ulimit -t"` ;;
   proc* | *user*     ) b=`su - $user -c "ulimit -u"` ;;
   virt*              ) b=`su - $user -c "ulimit -v"` ;;
   file*loc*          ) b=`su - $user -c "ulimit -s"` ;;
   *                  ) b=error ;;
esac
if [ "$b" = "error" ]
        then
        echo "####### error ############### error ############### error ########"
        echo "Error - ulimit "-$ulmt-" is invalid   "
        echo "####### error ############### error ############### error ########"
        echo "ulimit -- Error - ulimit "-$ulmt-" is invalid   " >> $tmpfile.err
        exit 8
fi
a=$(echo $b | grep -ic 'unlimited' )
if [ "$a"  = 0 ]
    then
        if [ $b -lt $ulmtval ]
               then
               		if [[ "$autofix" == Y* ]]
               			then
               				echo "####### fix ############### fix ############### fix ########"
               				echo "To be fixed:  - ulimit "-$ulmt-" is invalid   "
               				echo "Setting new ulimit   $ulmt"
               				echo "####### fix ############### fix ############### fix ########"
               				echo $b $ulmtval
               				case "$ulmt" in
   								core*              ) f_set_ulimit $user "core" $ulmtval ;;
  								data*              ) f_set_ulimit $user "data" $ulmtval ;;
   								file*              ) f_set_ulimit $user "fsize" $ulmtval ;;
   								pend* | max*loc*   ) f_set_ulimit $user "memlock" $ulmtval ;;
   								memo* | max*mem*   ) f_set_ulimit $user "as" $ulmtval ;;
   								nofil* | open*     ) f_set_ulimit $user "nofile" $ulmtval ;;
   								pipe*              ) f_set_ulimit $user "pipe" $ulmtval ;;
   								POSI*              ) f_set_ulimit $user "msgqueue" $ulmtval ;;
   								thr*               ) f_set_ulimit $user "nproc" $ulmtval ;;
   								stac*              ) f_set_ulimit $user "stack" $ulmtval ;;
   								cpu* | time*       ) f_set_ulimit $user "cpu" $ulmtval ;;
   								proc* | *user*     ) f_set_ulimit $user "nproc" $ulmtval ;;
   								virt*              ) f_set_ulimit $user "as" $ulmtval ;;
   								file*loc*          ) f_set_ulimit $user "locks" $ulmtval ;;
   							esac

               		    else

                        	echo "####### error ############### error ############### error ########"
                        	echo "Error - ulimit "-$ulmt-" is set to $b. Requires $ulmtval  "
                        	echo "####### error ############### error ############### error ########"
                        	echo "ulimit -- Error - ulimit "-$ulmt-" is set to $b. Requires $ulmtval " >> $tmpfile.err
                        	exit 8
					fi

                else
                        echo "##################################################################"
                        echo "ulimit "-$ulmt-" has $b available. More than the required $ulmtval "
                        echo "##################################################################"
                        exit 0
       fi
    else
        echo "##################################################################"
        echo "ulimit "-$ulmt-" has a value of unlimited   "
        echo "##################################################################"
        exit 0
fi
