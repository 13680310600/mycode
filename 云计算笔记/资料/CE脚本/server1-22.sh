#!/bin/bash
N="nmcli connection modify"
NA="nmcli connection add"
NU="nmcli connection up"
CA="connection.autoconnect yes"
NULL=/dev/null 
IP1=172.16.3.20/24
IP2=2003:ac18::305/64 
ec=echo
S=sed
U=useradd
FIRE="firewall-cmd --permanent"
F=firewall-cmd
t=team-slave
sr="systemctl restart"
se="systemctl enable"
DIRECTORY=/etc/httpd/conf.d/ssl.conf
R=/root/foo.sh
R1=/root/batchusers
HTTP2=http://classroom/pub/materials/station.html
HTTP31=http://classroom/pub/tls/certs/server0.crt
HTTP32=http://classroom.example.com/pub/example-ca.crt
HTTP33=http://classroom/pub/tls/private/server0.key
HTTP4=http://classroom/pub/materials/www.html 
HTTP5=http://classroom/pub/materials/private.html 
HTTP6=http://classroom.example.com/pub/materials/webinfo.wsgi

$ec '#######################################################################
#                             NSD1709 Vv创建                         #
#                                                                    #
######################################################################'

$N "System eth0" ipv4.method manual ipv4.addresses '172.25.0.11/24 172.25.0.254' ipv4.dns 172.25.254.254  $CA
$NU  "System eth0" &> $NULL
$ec 'server0.example.com' > /etc/hostname
$ec 主机server0改名成功 IP地址更改成功 DNS布置完成
$ec 环境布置完毕
$ec 第1题成功
#
$FIRE --zone=block --add-source=172.34.0.0/24 &> $NULL
$F --set-default-zone=trusted &> /dev/null
$FIRE --zone=trusted --add-forward-port=port=5423:proto=tcp:toport=80 &> $NULL
$F --reload &> $NULL
$ec 第2题成功
#
$ec "alias qstat='/bin/ps -Ao pid,tt,user,fname,rsz' " >> /etc/bashrc
$ec 第3题成功
#
$ec 第4题成功
#
$NA con-name team0 ifname team0 type team config '{ "runner":{ "name":"activebackup" } }' &> $NULL
$NA  type $t ifname eth1 master team0 &> $NULL
$NA  type $t ifname eth2 master team0 &> $NULL
$N team0 ipv4.method  manual ipv4.addresses $IP1 $CA  &> $NULL
$NU team-slave-eth1 &> $NULL
$NU team-slave-eth2 &> $NULL
$NU team0 &> $NULL
$ec 第5题成功
#
$N "System eth0" ipv6.method manual ipv6.addresses $IP2 $CA  &> $NULL
$NU "System eth0"  &> $NULL
$ec 第6题成功
#
$S -i '116d' /etc/postfix/main.cf
$S -i '163d' /etc/postfix/main.cf
$ec 'inet_interfaces = loopback-only
mydestination =
myorigin = desktop0.example.com
mynetworks = [::1]/128, 127.0.0.0/8
relayhost = [smtp0.example.com]' >> /etc/postfix/main.cf
$sr postfix
$se postfix
$ec 第7题成功
#
yum -y install samba &> $NULL
mkdir /common
mkdir /devops
setsebool -P samba_export_all_rw=on
$U harry
($ec migwhisk;$ec migwhisk) | pdbedit -t -a -u harry &> $NULL
$U kenji
($ec atenorth;$ec atenorth) | pdbedit -t -a -u kenji &> $NULL
$U chihiro
($ec atenorth;$ec atenorth) | pdbedit -t -a -u chihiro &> $NULL
setfacl -m u:chihiro:rwx /devops/
$S -i  s/MYGROUP/STAFF/g /etc/samba/smb.conf
$ec '[common]
path = /common
[devops]
path = /devops
write list = chihiro
hosts allow = 172.25.0.0/24' >> /etc/samba/smb.conf
$sr smb
$se smb &> $NULL
$ec 第8题成功
$ec 第9题成功
#
lab nfskrb5 setup &> $NULL
mkdir -p /public /protected/project
chown ldapuser0 /protected/project/
wget -O /etc/krb5.keytab http://classroom/pub/keytabs/server0.keytab &> $NULL
$ec '/public 172.25.0.0/24(ro)
/protected 172.25.0.0/24(rw,sec=krb5p)' > /etc/exports
$sr nfs-secure-server nfs-server
$se nfs-secure-server nfs-server &> $NULL
$ec 第10题成功
$ec 第11题成功
#
yum -y install httpd &> $NULL
$ec '<VirtualHost *:80>
ServerName server0.example.com
DocumentRoot /var/www/html
</VirtualHost>' >  /etc/httpd/conf.d/server0.conf
cd /var/www/html/
wget $HTTP2 -O index.html &> $NULL
$ec 第12题成功
#
yum -y install mod_ssl &> $NULL
cd /etc/pki/tls/certs
wget $HTTP31 &> $NULL
wget $HTTP32 &> $NULL 
cd ../private/
wget $HTTP33 &> $NULL
$S -i '100d' /$DIRECTORY
$S -i '106d' /$DIRECTORY
$S -i '120d' /$DIRECTORY
$S -i '213d' /$DIRECTORY
$ec 'SSLCertificateFile /etc/pki/tls/certs/server0.crt
SSLCertificateKeyFile /etc/pki/tls/private/server0.key
SSLCACertificateFile /etc/pki/tls/certs/example-ca.crt
</VirtualHost>' >> /etc/httpd/conf.d/ssl.conf 
$ec 第13题成功
#
mkdir /var/www/virtual
$U fleyd &> $NULL
setfacl -m u:fleyd:rwx /var/www/virtual/
cd /var/www/virtual/
wget $HTTP4 -O index.html &> $NULL
$ec '<VirtualHost *:80>
ServerName www0.example.com
DocumentRoot /var/www/virtual
</VirtualHost>' > /etc/httpd/conf.d/www0.conf
$ec 第14题成功
#
mkdir /var/www/html/private
cd /var/www/html/private/
wget $HTTP5 -O index.html &> $NULL
$ec '<Directory /var/www/html/private>
Require ip 127.0.0.1 ::1 172.25.0.11
</Directory>' >> /etc/httpd/conf.d/server0.conf
$ec 第15题成功
#
yum -y install httpd elinks mod_wsgi &> $NULL
mkdir /var/www/webapp0 &> $NULL
cd /var/www/webapp0
wget $HTTP6 &> $NULL
$ec "Listen 8909
<VirtualHost *:8909>
ServerName webapp0.example.com
DocumentRoot /var/www/webapp0
WSGIScriptAlias / /var/www/webapp0/webinfo.wsgi
</VirtualHost>"  >  /etc/httpd/conf.d/webapp0.conf
semanage port -a -t http_port_t -p tcp 8909 &>  $NULL
$sr httpd
$se httpd &> $NULL
$ec 第16题成功
#
$ec 'if [ "$1" = "redhat" ]
then
echo "fedora"
elif [ "$1" = "fedora" ]
then
echo "redhat"
else
echo "/root/foo.sh redhat|fedora"  >&2
fi' >  $R
chmod +x $R
$ec 第17题成功
#
$ec '#!/bin/bash
if [ $# -eq 0 ] ; then
echo "Usage: /root/batchusers <userfile> "
exit 1
fi
if [ ! -f $1 ] ; then
echo "Input file not found"
exit 2
fi
for name in $(cat $1)
do
useradd -s /bin/false $name
done' > $R1
chmod +x $R1
$ec 第18题成功
#
fdisk /dev/vdb >& $NULL << EOF1
n
p
1

+3G
w
EOF1
partprobe /dev/vdb
yum -y install targetcli  &> $NULL
targetcli <<  EOF
backstores/block create iscsi_store /dev/vdb1
/iscsi create iqn.2016-02.com.example:server0
/iscsi/iqn.2016-02.com.example:server0/tpg1/acls create iqn.2016-02.com.example:desktop0
/iscsi/iqn.2016-02.com.example:server0/tpg1/luns create /backstores/block/iscsi_store
/iscsi/iqn.2016-02.com.example:server0/tpg1/portals create 172.25.0.11
saveconfig
exit
EOF
systemctl restart target
systemctl enable target &> $NULL
echo 第19题成功
#
echo 第20题成功
#
yum -y install mariadb-server mariadb  &> $NULL
echo '[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
symbolic-links=0
skip-networking
[mysqld_safe]
log-error=/var/log/mariadb/mariadb.log
pid-file=/var/run/mariadb/mariadb.pid
!includedir /etc/my.cnf.d
' >  /etc/my.cnf
systemctl restart mariadb
systemctl enable mariadb &> $NULL

echo "請按一下回車"
mysqladmin -u root -p password "atenorth" 

mysql -u root -patenorth << EOF3

CREATE DATABASE Contacts;
GRANT select ON Contacts.* to Raikon@localhost IDENTIFIED BY 'atenorth';
DELETE FROM mysql.user WHERE Password='';
quit
EOF3
wget http://classroom/pub/materials/users.sql  &> $NULL
mysql -u root -patenorth Contacts < users.sql
echo 第21题成功
#
echo 第22题成功
echo '完成以上配置请输入
reboot 
重启机器'
echo '#########################################################################
#             NSD1709 Vv创建 欢迎使用此脚本,祝你生活愉快！再见！        #
#                                                                      #
########################################################################'
