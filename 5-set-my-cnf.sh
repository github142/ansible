#!/bin/bash
# Install mysql-server and modify my.cnf
# start mysql-server on system boot 

host_ip=$1
server_id=`echo $host_ip|cut -d '.' -f 4`
ssh root@$host_ip "cat <<EOF > /etc/my.cnf
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
server-id= $server_id
log_bin = /var/lib/mysql/mysql-binlog
binlog-ignore-db=mysql
binlog-ignore-db=information_schema
replicate-ignore-db=mysql,information_schema
sync_binlog=1
character_set_server=utf8
init_connect='SET NAMES utf8'
#read-only=0
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
[client]
default-character-set=utf8
EOF"
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"set my.cnf success"}'
else
 echo '{"success":"false","msg":"set my.cnf failed"}'
fi
