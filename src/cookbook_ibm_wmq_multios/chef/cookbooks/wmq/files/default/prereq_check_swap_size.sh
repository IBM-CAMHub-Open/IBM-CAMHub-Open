#-----------------------------------------------------------------------------
########################################################
#	  Copyright IBM Corp. 2012, 2017
########################################################
# Name             - prereq-check-swap.sh
# Purpose          - Prereq check to verify memory swap
# Parameters       - autofix
#
#---------------------------------------------------------------------
autofix=Y
######################################################################
f_check_swap_aix()
{
# REAL MEMORY SIZE
# -----------------------------------#
REALMEM=$(lsattr -El sys0 | grep realmem | awk '{print $2}')
# -----------------------------------#
((REALMEM_MB=REALMEM/1024))
((REALMEM_GB=REALMEM_MB/1024))
# -----------------------------------#
if (( 1 < "$REALMEM_GB" )) && (($REALMEM_GB <=2));  then SWAPSIZESET=$(($REALMEM_MB*3/2)); fi
if (( 2 < "$REALMEM_GB" )) && (($REALMEM_GB < 16)); then SWAPSIZESET=$REALMEM_MB; fi
if (( 16 < "$REALMEM_GB" ));                        then SWAPSIZESET=$((16*1024)); fi
# -----------------------------------#

SWAPSIZE=$(lsps -a | egrep -v "Page" | awk '{print $4}'|awk -F "MB" '{print $1}')
if [ "$SWAPSIZE" = "$SWAPSIZESET" ]; then   echo "INFO: SWAP SIZE $SWAPSIZE MB IS SET OK"
                                            exit 0
else
      if [[ "$autofix" == Y* ]]; then
            echo "INFO: Autofix is set.Swap size have to be set to $SWAPSIZESET"
            SIZEDIFF=$(($SWAPSIZESET-$SWAPSIZE)); ((SIZEDIFF_GB=SIZEDIFF/1024))
            PP=$(lslv hd6 | grep "PP SIZE" | awk '{print $6}')
            ((LP=$SIZEDIFF/$PP))
            # extend the hd6 partition in order to increase memory swap size
            extendlv hd6 ${SIZEDIFF_GB}G
            #---------------------------------------------------------------------------------------------------#
            xxRc=$?
            echo "extendlv ended with rc=${xxRc}"
            if [ ${xxRc} != 0 ]; then
               echo "WARNING: EXTENTION OF PARTITION CANNOT BE DONE! PLEASE CHECK DISK SPACE SIZE"
               echo "WARNING: If swap size cannot be increased installation will continue, but this can cause errors!"
            fi
            #---------------------------------------------------------------------------------------------------#
            # Logical partitions to be added to hd6
            chps -s $LP hd6
            #---------------------------------------------------------------------------------------------------#
            xxRc=$?
            echo "chps ended with rc=${xxRc}"
            if [ ${xxRc} != 0 ]; then
               echo "WARNING: ADDING LOGICAL PARTITIONS CANNOT BE DONE! PLEASE CHECK DISK SPACE SIZE"
               echo "WARNING: If swap size cannot be increased installation will continue, but this can cause errors!"
            fi
            #---------------------------------------------------------------------------------------------------#
            if [ ${xxRc} = 0 ]; then
               SWAPSIZE=$(lsps -a | egrep -v "Page" | awk '{print $4}'|awk -F "MB" '{print $1}')
               echo "INFO: SWAP SIZE AFTER EXTENTION: $SWAPSIZE MB"
            fi
            exit 0
      else
            echo "ERROR: Autofix is not set.Size have to be set manualy to $SWAPSIZESET!"
            exit 1
      fi
fi
}
#=====================================================================
#  main section
#=====================================================================
os=$(uname)
echo "#------------------------------------------------------------------------"
echo "#------------------------------------------------------------------------"

if [ "$os" = "AIX" ]; then f_check_swap_aix
else                       exit 0
fi
