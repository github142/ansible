#!/bin/bash
disk_dev=/dev/xvdb
fdisk -S 56 $disk_dev << EOF
n
p
1

+8G
t
82
n
p
2


wq
EOF

if [ $? -eq 0 ]; then
    mkswap "$disk_dev"1
    mkfs.ext4 "$disk_dev"2
    echo ""$disk_dev"2             /opt                 ext4    defaults        0 0" >> /etc/fstab
    echo ""$disk_dev"1             swap                 swap    defaults        0 0" >> /etc/fstab
    mount -a
  else
    exit 1
fi
