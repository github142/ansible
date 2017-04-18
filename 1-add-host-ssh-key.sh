#!/bin/bash
# Add host ssh key

host_ip=$1

after_time=`date +%s -d "+ 3 minutes"`
for i in $(seq 1 60 )
do
 now_time=`date +%s`
 echo quit | telnet $host_ip 22 2>/dev/null | grep Connected
 if [ $? = 0 ]; then
 break
elif [ $now_time -gt $after_time ]; then
 echo '{"success":"false","msg":"can not connect to host"}'
 exit
 fi
 echo "reconnect to $host_ip number of times $i/60"
 sleep 5
done

cat ~/.ssh/id_rsa.pub |sshpass -p 1qaz@WSX  ssh  -o StrictHostKeyChecking=no root@$host_ip 'cat >> .ssh/authorized_keys'
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"add host ssh key success"}'
else
 echo '{"success":"false","msg":"add host ssh key failed"}'
fi
