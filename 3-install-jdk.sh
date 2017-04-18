#!/bin/bash
##

host_ip=$1
scp /shell/jdk-8u111-linux-x64.rpm root@$host_ip:/opt
ssh root@$host_ip "rpm -ivh /opt/jdk-8u111-linux-x64.rpm"

if [ $? = 0 ]; then
 echo '{"success":"true","msg":"install jdk success"}'
else
 echo '{"success":"false","msg":"install jdk failed"}'
fi
