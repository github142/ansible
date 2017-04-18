#!/bin/bash
# package-configure.sh

git_url=$1
git_name=`echo "$git_url"|awk -F '/' '{print $NF}'|cut -d '.' -f 1`
cd /opt/paas/$git_name
mv ./system/license  ./system/src/main/java/
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"package configure success"}'
else
 echo '{"success":"false","msg":"package configure fialed"}'
fi
