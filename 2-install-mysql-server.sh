#!/bin/bash
# Install mysql-server and modify my.cnf
# start mysql-server on system boot 

host_ip=$1
server_id=`echo $host_ip|cut -d '.' -f 4`
ssh root@$host_ip "yum --enablerepo=local install mysql-server -y;cat <<EOF > /etc/my.cnf
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
[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
EOF
chkconfig mysqld on;service mysqld restart" >> /var/log/2-install-mysql-server.log 2>&1
if [ $? = 0 ]; then
 echo "{success:true}"
else
 echo "{success:false,msg:'mysql-server start error'}"
fi
