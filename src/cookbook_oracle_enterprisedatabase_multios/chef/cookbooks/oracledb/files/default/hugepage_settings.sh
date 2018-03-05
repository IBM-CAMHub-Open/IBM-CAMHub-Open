#!/bin/bash
KERN=`uname -r | awk -F. '{ printf("%d.%d\n",$1,$2); }'`
# Find out the HugePage size
HPG_SZ=`grep Hugepagesize /proc/meminfo | awk '{print $2}'`
# Start from 1 pages to be on the safe side and guarantee 1 free HugePage
NUM_PG=1
# Cumulative number of pages required to handle the running shared memory segments

for SEG_BYTES in `ipcs -m | awk '{print $5}' | grep "[0-9][0-9]*"`
do
    MIN_PG=`echo "$SEG_BYTES/($HPG_SZ*1024)" | bc -q`
    if [ $MIN_PG -gt 0 ]; then
        NUM_PG=`echo "$NUM_PG+$MIN_PG+1" | bc -q`
    fi
done

# Finish with results
case $KERN in
    '2.4') HUGETLB_POOL=`echo "$NUM_PG*$HPG_SZ/1024" | bc -q`;
           echo "Recommended setting: vm.hugetlb_pool = $HUGETLB_POOL" ;;
    '2.6') MEM_LOCK=`echo "$NUM_PG*$HPG_SZ" | bc -q`;
            echo "Recommended setting within the kernel boot command line: hugepages = $NUM_PG"
            echo "Recommended setting within /etc/security/limits.d/99-grid-oraclelimits.conf:
            # oracle soft memlock $MEM_LOCK"
            echo "Recommended setting within /etc/security/limits.d/99-grid-oraclelimits.conf:
            # oracle hard memlock $MEM_LOCK" ;;
    *) echo "Unrecognized kernel version $KERN. Exiting." ;;
esac
