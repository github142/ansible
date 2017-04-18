#!/bin/bash
##  mvn-clean-install

git_url=$1
git_name=`echo "$git_url"|awk -F '/' '{print $NF}'|cut -d '.' -f 1`
cd /opt/paas/$git_name
mvn clean install > /tmp/$git_name.log 2>&1
if [ $? = 0 ]; then
 war_file=`cat /tmp/$git_name.log |grep "Building war"|cut -d ' ' -f 4`
 echo "{"success":"true","deploy_war":\""$war_file\""}"
else
 echo '{"success":"false","msg":"mvn clean install fialed"}'
fi
