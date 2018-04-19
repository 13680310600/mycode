#!/bin/bash
sum=`yum repolist |sed -n '/repolist/p' |sed 's/repolist: //' | sed 's/,//'`
[ $sum -gt 0 ] && echo "yum可用！"
#yum repolist | sed -n '/repolist/p' 

