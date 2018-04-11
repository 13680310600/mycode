#!/bin/bash

num=`sed -n '/bash$/s/:.*//p' /etc/passwd`
for i in  $num
do
	sum=`grep "$i" /etc/shadow`
	sum=${sum#*:}
	sum=${sum%%:*}
	echo  "${i}的密码：$sum "
done
