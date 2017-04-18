#!/bin/bash
# start mysql-server on system boot 

host_ip=$1
db_user=$2
db_userpwd=$3
db_name=$4
db_rootpwd=$5

ssh root@$host_ip "chkconfig mysqld on;service mysqld restart"
if [ $? != 0 ]; then
 echo '{"success":"false","msg":"start mysql-service failed"}'
 exit
fi

### change db root pwd
ssh root@$host_ip "mysqladmin -u root password "$db_rootpwd""
if [ $? != 0 ]; then
 echo '{"success":"false","msg":"change mysql root password failed"}'
 exit
fi

### create database 
ssh root@$host_ip "mysql -u root -p$db_rootpwd << EOF
create database $db_name;
EOF
"
if [ $? != 0 ]; then
 echo '{"success":"false","msg":"create database failed"}'
 exit
fi

### add db user
### echo "192.168.1.1"|sed 's/\(.*\)./\1%/'
ssh root@$host_ip "mysql -u root -p$db_rootpwd << EOF
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%'IDENTIFIED BY '$db_userpwd' WITH GRANT OPTION;
flush privileges;
EOF
"

if [ $? = 0 ]; then
 echo '{"success":"true","msg":"start mysql-server and change password success"}'
else
 echo '{"success":"false","msg":"add mysql-server user failed"}'
fi
