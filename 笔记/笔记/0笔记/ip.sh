#!/bin/bash

ip(){
for ((i=180;i<220;i++))
do
     for  ((j=1;j<254;j++))
	do
		ping -c 4 -i 0.1 -w 0.3  176.121.$i.$j  &> /dev/null

      if [ $? -eq 0  ];then

                echo "176.121.$i.$j OK!" >> /root/桌面/笔记/ok.txt
        else
                echo "176.121.$i.$j NO!" >> /root/桌面/笔记/no.txt
        fi


	done


done
}
while :
do
ip &
done





