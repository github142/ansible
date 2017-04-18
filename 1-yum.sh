#!/bin/bash
# Disabled selinux and add yum local repo

host_ip=$1
cat ~/.ssh/id_rsa.pub |sshpass -p 1qaz@WSX  ssh  -o StrictHostKeyChecking=no root@$host_ip 'cat >> .ssh/authorized_keys && echo "Key copied"'
ssh root@$host_ip "sed -i 's/=enforcing/=permissive/1' /etc/selinux/config;setenforce 0;service iptables stop;chkconfig iptables off;cat <<EOF > /etc/yum.repos.d/Local.repo
[local]
name=CentOS-6 - Base - LAN
baseurl=http://192.168.4.55/centos/6/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
EOF
yum clean all" >> /var/log/1-yum.log 2>&1
if [ $? = 0 ]; then
 echo "{success:true}"
else
 echo "{success:false,msg:'error msg'}"
fi
