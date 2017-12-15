#!/bin/bash
#

[[ `dirname $0 | cut -c1` = '/' ]] && localtoolpath=`dirname $0`/ || localtoolpath=`pwd`/`dirname $0`/
toolrepositoryroot=$localtoolpath/../../

. $localtoolpath/.listRepositories.lib

host=github.com
org=IBM-AutomationContentHub
token=""
branch="DEFAULT"
filterIn="cookbook|template"
filterOut="NOTHINGTOFILTEROUT"
pwd=`pwd`
theList=""
theFullList=""
tarFile=true
srcPath=$toolrepositoryroot/src/
[[ -d $srcPath ]] && mv $srcPath $srcPath/../src-`date | tr : - | tr ' ' _`

while test $# -gt 0; do
	[[ $1 =~ ^-h|--host$ ]] && { host="$2"; shift 2; continue; };
        [[ $1 =~ ^-o|--org$ ]] && { org="$2" ; shift 2; continue; };
       	[[ $1 =~ ^-t|--token$ ]] && { token="$2"; shift 2; continue; };
        [[ $1 =~ ^-b|--branch$ ]] && { branch="$2"; shift 2; continue; };
       	[[ $1 =~ ^-p|--private$ ]] && { grepString="true|false"; shift ; continue; };
	[[ $1 =~ ^-f|--filter$ ]] && { filterIn="$2"; shift 2; continue; };
	[[ $1 =~ ^-f|--filterOut$ ]] && { filterOut="$2"; shift 2; continue; };
	[[ $1 =~ ^-d|--debug$ ]] && { set -x ; shift; continue; };
        [[ $1 =~ ^-r|--skiptar$ ]] && { tarFile=false ; shift; continue; };
	shift
done

[[ -z "$token" ]] && { echo "--token <token> must be specified to access the repository"; exit 1; }

theFullList=`listRepositories $host $org $token true`
[[ -z "$theFullList" ]] && { echo "No repositories found, either the --token $token was bad, or the connection to the host https://$host/$org failed" ; exit 1 ; }

theList=`echo $theFullList | tr ' ' '\n' | egrep $filterIn | egrep -v $filterOut`
[[ -z "$theList" ]] && { echo "The filter in: $filterIn and filter out: $filterOut, resulted in no repositories in the list" ; exit 0; } 

set `echo $theList`
while test $# -gt "0" 
do
	cloneRepository $srcPath $host $org $branch $token $1
	shift
done

[[ "$tarFile" = true ]] && { cd $srcPath ; tar cvf IBM-AutomationContentHub.tar `ls -1 | egrep cookbook` > /dev/null ; echo "Tar file generated: $srcPath/IBM-AutomationContentHub.tar" ; }

exit 0
