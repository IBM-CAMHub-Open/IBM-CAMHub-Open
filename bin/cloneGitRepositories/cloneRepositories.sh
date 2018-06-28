#!/bin/bash
#
# Copyright : IBM Corporation 2016, 2017
#
#
[[ `dirname $0 | cut -c1` = '/' ]] && localtoolpath=`dirname $0`/ || localtoolpath=`pwd`/`dirname $0`/
toolrepositoryroot=$localtoolpath/../../

. $localtoolpath/.listRepositories.lib

host=github.com
org=IBM-CAMHub-Open
branch="DEFAULT"
filterIn="cookbook|template|advanced|starterlibrary|IBMPower"
filterOut="NOTHINGTOFILTEROUT"
pwd=`pwd`
theList=""
theFullList=""
tarFile=true
srcPath=`echo $toolrepositoryroot/src/ | tr -s '/'`
[[ -d $srcPath ]] && mv $srcPath $srcPath/../src-`date | tr : - | tr ' ' _`

while test $# -gt 0; do
	[[ $1 =~ ^-h|--host$ ]] && { host="$2"; shift 2; continue; };
        [[ $1 =~ ^-o|--org$ ]] && { org="$2" ; shift 2; continue; };
        [[ $1 =~ ^-b|--branch$ ]] && { branch="$2"; shift 2; continue; };
       	[[ $1 =~ ^-p|--private$ ]] && { grepString="true|false"; shift ; continue; };
	[[ $1 =~ ^-f|--filter$ ]] && { filterIn="$2"; shift 2; continue; };
	[[ $1 =~ ^-f|--filterOut$ ]] && { filterOut="$2"; shift 2; continue; };
	[[ $1 =~ ^-d|--debug$ ]] && { set -x ; shift; continue; };
        [[ $1 =~ ^-r|--skiptar$ ]] && { tarFile=false ; shift; continue; };
	shift
done

theFullList=`listRepositories $host $org true`
[[ -z "$theFullList" ]] && { echo "No repositories found, possibly the connection to the host https://$host/$org failed" ; exit 1 ; }

theList=`echo $theFullList | tr ' ' '\n' | egrep $filterIn | egrep -v $filterOut`
[[ -z "$theList" ]] && { echo "The filter in: $filterIn and filter out: $filterOut, resulted in no repositories in the list" ; exit 0; }

echo "[*] Clone repositories from $host:$org ..."
echo -n "Cloning "

set `echo $theList`
while test $# -gt "0"
do
	cloneRepository $srcPath $host $org $branch $1 2>> clone.log
	shift
done
echo

cp $srcPath/../bin/cloneGitRepositories/loadContentRuntimeTemplates.sh $srcPath/advanced_content_runtime_chef/
[[ "$tarFile" = true ]] && { cd $srcPath ; tar cf IBM-CAMHub-Open_advanced_content_runtime.tar `ls -1 | egrep advanced` 2>&1 > /dev/null ; echo "Tar file generated: $srcPath/IBM-CAMHub-Open_advanced_content_runtime.tar" ; }
[[ "$tarFile" = true ]] && { cd $srcPath ; tar cf IBM-CAMHub-Open.tar `ls -1 | egrep cookbook` 2>&1 > /dev/null ; echo "Tar file generated: $srcPath/IBM-CAMHub-Open.tar" ; }
[[ "$tarFile" = true ]] && { cd $srcPath ; tar cf IBM-CAMHub-Open_templates.tar `ls -1 | egrep -v "cookbook|advanced|IBM-CAMHub-Open.tar"` 2>&1 > /dev/null ; echo "Tar file generated: $srcPath/IBM-CAMHub-Open_templates.tar" ; }

exit 0
