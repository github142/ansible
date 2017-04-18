#!/bin/bash
# Set mysql repl

master_ip=$1
slave_ip=$2
repl_file=$3
repl_id=$4
db_rootpwd=$5

ssh root@$slave_ip "sed -i 's/#read-only=0/read-only=1/1' /etc/my.cnf "
ssh root@$slave_ip "service mysqld restart"

sqlrepl="change master to master_host=\"$master_ip\", master_user=\"sync\", master_password=\"123456\", master_log_file=\"$repl_file\", master_log_pos=$repl_id;"
sqlrepl2="mysql -u root -p$db_rootpwd -e '$sqlrepl'"
ssh root@$slave_ip "mysql -u root -p$db_rootpwd -e \"stop slave;\""
ssh root@$slave_ip "${sqlrepl2}"
if [ $? != 0 ]; then
 echo '{"success":"false","msg":"set mysql slave repl configure failed"}'
 exit
fi

ssh root@$slave_ip "mysql -u root -p$db_rootpwd -e \"start slave;\""

#ssh root@$slave_ip "mysql -u root -p$db_rootpwd -e \"show slave status\G\""

if [ $? = 0 ]; then
 echo '{"success":"true","msg":"mysql slave repl success"}'
else
 echo '{"success":"false","msg":"mysql-slave repl failed"}'
fi
