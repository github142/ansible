#!/bin/bash
# project-configure.sh

git_url=$1
git_name=`echo "$git_url"|awk -F '/' '{print $NF}'|cut -d '.' -f 1`
cd /opt/paas/$git_name
cp -f /opt/paas/application.yml /opt/paas/$git_name/horizon/src/main/resources/application.yml
mv ./system/license  ./system/src/main/java/
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"project configure success"}'
else
 echo '{"success":"false","msg":"project configure fialed"}'
fi
