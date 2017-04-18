#!/bin/bash
## git-clone.sh

git_url=$1
git_name=`echo "$git_url"|awk -F '/' '{print $NF}'|cut -d '.' -f 1`
cd /opt/paas/
if [ -d "$git_name" ]; then
  rm -rf $git_name
fi
git clone $git_url
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"git clone success"}'
else
 echo '{"success":"false","msg":"git clone fialed"}'
fi
