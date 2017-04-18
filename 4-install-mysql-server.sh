#!/bin/bash
# Install mysql-server

host_ip=$1
ssh root@$host_ip "yum --enablerepo=local install mysql-server -y"
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"install mysql-server success"}'
else
 echo '{"success":"false","msg":"install mysql-server failed"}'
fi
