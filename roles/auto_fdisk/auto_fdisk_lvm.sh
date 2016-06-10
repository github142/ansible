#!/bin/bash
disk_dev=/dev/sdb
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


t
2
8e

wq
EOF

if [ $? -eq 0 ]; then
    mkswap "$disk_dev"1
    pvcreate "$disk_dev"2
    vgcreate VolOpt "$disk_dev"2
    lvcreate -l 100%FREE -n lv_opt VolOpt
    mkfs.ext4 /dev/VolOpt/lv_opt
    echo "/dev/VolOpt/lv_opt      /opt                 ext4    defaults        0 0" >> /etc/fstab
    echo ""$disk_dev"1               swap                 swap    defaults        0 0" >> /etc/fstab
    mount -a
  else
    exit 1
fi
