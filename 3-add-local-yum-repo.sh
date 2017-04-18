#!/bin/bash
# Add yum local repo

host_ip=$1
ssh root@$host_ip "cat <<EOF > /etc/yum.repos.d/Local.repo
[local]
name=CentOS-6 - Base - LAN
baseurl=http://192.168.4.55/centos/6/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
EOF
yum clean all"
if [ $? = 0 ]; then
 echo '{"success":"true","msg":"Add local yum repo success"}'
else
 echo '{"success":"false","msg":"Add local yum repo failed"}'
fi
