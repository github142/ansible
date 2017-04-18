#!/bin/bash
##

deploy_war=$1
remote_host="192.168.101.104"
remote_dir="/usr/apache-tomcat-8.0.33"

#ssh root@$remote_host "cp /opt/tomcat/webapps/horizon.war /backupdir/horizon.war"

tomcat_pid=`ssh -t root@192.168.101.104 <<'EOF'
ps -ef |grep tomcat|grep -v grep|awk -F ' ' '{print $2}'
EOF
`
ssh root@$remote_host "kill -9 $tomcat_pid"

scp $deploy_war root@$remote_host:$remote_dir/webapps/ROOT.war

ssh root@$remote_host "source /etc/profile;$remote_dir/bin/startup.sh"
