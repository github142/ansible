#!/bin/bash

master_ip=192.168.101.79
vmhost_ip=1.1.1.4

ssh root@192.168.101.79 "echo -e '<html><body><center> \n $vmhost_ip Now time is: <%=new java.util.Date()%> \n </center></body></html> ' > /opt/apache-tomcat-8.0.42/webapps/index.jsp"
