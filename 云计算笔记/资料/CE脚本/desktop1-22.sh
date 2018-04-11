#!/bin/bash
ec=echo
NULL=/dev/null
N="nmcli connection modify"
NU="nmcli connection up"
NA="nmcli connection add"
CA="connection.autoconnect yes"
IP=172.25.254.254
FIRE="firewall-cmd --permanent"
F=firewall-cmd
sr="systemctl restart"
se="systemctl enable"
HTTP=http://classroom/pub/keytabs/desktop0.keytab

$ec '#######################################################################
#                              NSD1709 Vv创建                          #
#                                                                    #
######################################################################'
$N "System eth0" ipv4.method manual ipv4.addresses '172.25.0.10/24 172.25.0.254' ipv4.dns $IP $CA
$NU "System eth0" &> $NULL
$ec 'desktop0.example.com' > /etc/hostname 
$ec 主机desktop0改名成功 IP地址更改成功 DNS布置完成
$ec 环境布置完毕
$ec 第1题成功
#
$FIRE --zone=block --add-source=172.34.0.0/24 &> $NULL
$F --set-default-zone=trusted &> $NULL
$FIRE  --zone=trusted --add-forward-port=port=5423:proto=tcp:toport=80 &> $NULL
$F--reload &> $NULL
$ec 第2题成功
#
$ec "alias qstat='/bin/ps -Ao pid,tt,user,fname,rsz' " >> /etc/bashrc
$ec 第3题成功
#
$ec 第4题成功
#
$NA con-name team0 ifname team0 type team config '{ "runner":{ "name":"activebackup" } }' &> $NULL
$NA type team-slave ifname eth1 master team0 &> $NULL
$NA type team-slave ifname eth2 master team0 &> $NULL
$N team0 ipv4.method manual ipv4.addresses 172.16.3.25/24 $CA  &> $NULL
$NU team-slave-eth1 &> $NULL
$NU team-slave-eth2 &> $NULL
$NU up team0 &> $NULL
$ec 第5题成功
#
$N "System eth0" ipv6.method manual ipv6.addresses 2003:ac18::306/64 $CA  &> $NULL
$NU "System eth0"  &> $NULL
$ec 第6题成功
#
lab smtp-nullclient setup  &> $NULL
$ec 第7题成功
#
lab nfskrb5 setup &> $NULL
mkdir -p /mnt/nfsmount /mnt/nfssecure
wget -O /etc/krb5.keytab $HTTP &> $NULL
$sr nfs-secure
$se nfs-secure &> $NULL
$ec 'server0.example.com:/public /mnt/nfsmount nfs _netdev 0 0
server0.example.com:/protected /mnt/nfssecure nfs sec=krb5p,_netdev 0 0' >> /etc/fstab
mount -a 
#
yum -y install samba-client cifs-utils &> $NULL
mkdir /mnt/dev
$ec '//server0.example.com/devops /mnt/dev cifs username=kenji,password=atenorth,multiuser,sec=ntlmssp,_netdev 0 0'  >>  /etc/fstab
mount -a
$ec 第8题成功
$ec 第9题成功
#
$ec 第10题成功
$ec 第11题成功
$ec 第12题成功
$ec 第13题成功
$ec 第14题成功
$ec 第15题成功
$ec 第16题成功
$ec 第17题成功
$ec 第18题成功
#
#
yum -y install iscsi-initiator-utils &> /dev/null
$ec 'InitiatorName=iqn.2016-02.com.example:desktop0' > /etc/iscsi/initiatorname.iscsi
iscsiadm -m discovery -t st -p server0  &> /dev/null
iscsiadm -m node -T iqn.2016-02.com.example:server0 -l  &> /dev/null
sed -i s/manual/automatic/g  /var/lib/iscsi/nodes/iqn.2016-02.com.example\:server0/172.25.0.11\,3260\,1/default 
systemctl restart iscsi iscsid
systemctl enable iscsi iscsid &> /dev/null
fdisk /dev/sda << EOF
n
p
1

+2100M
w
EOF
partprobe /dev/sda
mkfs.ext4 /dev/sda1 &> /dev/null
mkdir /mnt/data
$ec '/dev/sda1 /mnt/data ext4 _netdev 0 0' >> /etc/fstab
mount -a
$ec 第19题成功
$ec 第20题成功
#
$ec 第21题成功
$ec 第22题成功
mount -a
$ec '完成以上配置请输入
sync;reboot -f
重启机器'
$ec '#########################################################################
#             NSD1709 Vv创建 欢迎使用此脚本,祝你生活愉快！再见！        #
#                                                                      #
########################################################################'
