#!/bin/bash
# Disabled selinux and iptables

host_ip=$1
ssh root@$host_ip "sed -i 's/=enforcing/=permissive/1' /etc/selinux/config;setenforce 0;service iptables stop;chkconfig iptables off"
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"Disable selinux and iptables success"}'
else
 echo '{"success":"false","msg":"Disable selinux and iptables failed"}'
fi
