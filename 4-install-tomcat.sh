#!/bin/bash
##

host_ip=$1
tomcat_port=$2

cat /shell/apache-tomcat-8.0.42.tar.gz | ssh root@$host_ip "tar zxf - -C /opt/"
if [ $? != 0 ]; then
 echo '{"success":"false","msg":"install tomcat failed"}'
 exit
fi

ssh root@$host_ip "sed -i 's/port=\"8080\"/port=\"$tomcat_port\"/g' /opt/apache-tomcat-8.0.42/conf/server.xml "
if [ $? != 0 ]; then
 echo '{"success":"false","msg":"change tomcat conf failed"}'
 exit
fi

ssh root@$host_ip "echo -e '<html><body><center> \n $host_ip Now time is: <%=new java.util.Date()%> \n </center></body></html> ' > /opt/apache-tomcat-8.0.42/webapps/ROOT/index.jsp"

ssh root@$host_ip "/opt/apache-tomcat-8.0.42/bin/startup.sh"
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"install and start tomcat success"}'
else
 echo '{"success":"false","msg":"start tomcat failed"}'
fi

