#!/bin/bash
# Set mysql repl

master_ip=$1
slave_ip=$2
# Master add repl user and select file id
ssh root@$master_ip "mysql -u root << EOF
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* TO sync@'%' IDENTIFIED BY '123456';
flush privileges;
EOF
"
# Get Master file name and position id
File=`ssh root@$master_ip "mysql -u root -e 'show master status\G' |grep File: "`
File=`echo $File|awk '{print $2}'`
Position=`ssh root@$master_ip "mysql -u root -e 'show master status\G' |grep Position: "`
Position=`echo $Position|awk '{print $2}'`

# Set slave repl
sqlrepl="change master to master_host=\"$master_ip\", master_user=\"sync\", master_password=\"123456\", master_log_file=\"$File\", master_log_pos=$Position;"
sqlrepl2="mysql -u root -e '$sqlrepl'"
ssh root@$slave_ip 'mysql -u root -e "stop slave;"' >> /var/log/3-mysql-repl.log 2>&1
ssh root@$slave_ip "${sqlrepl2}" >> /var/log/3-mysql-repl.log 2>&1
ssh root@$slave_ip 'mysql -u root -e "start slave;"' >> /var/log/3-mysql-repl.log 2>&1
#ssh root@$slave_ip 'mysql -u root -e "show slave status\G"'
if [ $? = 0 ]; then
 echo "{success:true}"
else
 echo "{success:false,msg:'mysql-server repl error'}"
fi
