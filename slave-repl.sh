#!/bin/bash
# Set mysql repl

master_ip=$1
slave_ip=$2
repl_file=$3
repl_id=$4

sqlrepl="change master to master_host=\"$master_ip\", master_user=\"sync\", master_password=\"123456\", master_log_file=\"$repl_file\", master_log_pos=$repl_id;"
sqlrepl2="mysql -u root -e '$sqlrepl'"
ssh root@$slave_ip 'mysql -u root -e "stop slave;"'
ssh root@$slave_ip "${sqlrepl2}"
ssh root@$slave_ip 'mysql -u root -e "start slave;"'

#ssh root@$slave_ip 'mysql -u root -e "show slave status\G"'

if [ $? = 0 ]; then
 echo '{"success":"true","msg":"mysql slave repl success"}'
else
 echo '{"success":"false","msg":"mysql-slave repl failed"}'
fi
