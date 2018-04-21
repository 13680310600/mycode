#!/bin/bash
menu(){
clear
fors
echo 
echo -e "\033[41;33m#        1:search   a   record           #\033[0m"
echo -e "\033[41;33m#        2:add   a   record              #\033[0m"
echo -e "\033[41;33m#        3:delete   a   record           #\033[0m"
echo -e "\033[41;33m#        4:display   all   record        #\033[0m"
echo -e "\033[41;33m#        5:edit  record  with  vi        #\033[0m"
echo -e "\033[41;33m#        H:help   screen                 #\033[0m"
echo -e "\033[41;33m#        Q:exit   pragma                 #\033[0m"
fors
echo 
echo
echo -ne "\033[40;32mplease enter your choice [1 2 3 4 5  H Q]: \033[0m"
read name
}
fors(){
for i in {1..42}
do
    echo -ne "\033[41;33m#\033[0m"
done
}

shou(){
  clear
  echo -n "please  enter  name  >>>"
  read file
  if [ -z $file ];then
	echo "you  didn't  enter  a  name"
  fi
  if [  ! -f "/record" ];then
	if [ -z  $file  ];then
		echo "you  didn't  enter  a  name"
	else
		echo "you  must  have  some  scores  before  you  can  search!"
	fi
	sleep 1
  else
	grep "$file" /record > /dev/null
      if [ $? -eq 0 ];then
          echo "`cat /record | grep "$file"`"
	  sleep 3 
  	else
          echo "name  not  in record"
          sleep 1
	fi
  fi
}

adds(){
  clear
  echo -ne "\033[32menter name and score of a record:\033[0m"
  read addz
  if [ -z $addz ];then
     echo -e "\033[32myou  didn't  enter  any  value\033[0m"
     echo -ne "\033[32mplease  enter  name  and  score：\033[0m"
     read addz
  fi
  if [ -n $addz ];then
     echo -e "\033[32madded  "$addz" in record\033[0m"
     echo "`awk 'END{print NR}' /record`.$addz" >> /record
     sleep 3
  fi

}
name(){
        read nnn
        grep "$nnn" /record > /dev/null
        if [ $? -ne 0 ]||[ -z $nnn  ] ;then
          echo -n "没有这个人!"
        else      
          sed -i '/'$nnn'/d' /record
          echo "已删除$nnn 这个学生的信息！"
          awk -F. '$1=FNR{print $1"."$2"."$3}' /record  > /aaa
          cat /aaa > /record
          sleep 2
	fi
}

delete(){
	clear
	echo -n "你要删除谁的成绩："
	name
	
}
display(){
	for i in `cat /record`
	do
		echo "$i"
	done
	sleep 3
}
vi(){
	clear
	vim /record
}
tui(){
	clear
	exit 0
}
ban(){
	clear
	echo 
	echo -e "\033[34mThis is a student's record manager program\033[0m"
	sleep 3
}





while :
do
menu
case $name in
1)
	if [ ! -f "/record" ];then
		echo "No record!"
	fi
	shou;;
2)
	adds
	;;
3)
	if [ ! -f "/record" ];then
		echo "No record!"
	else
		delete
	fi
	;;
4)
	if [ ! -f "/record" ];then
		echo "No record!"
	else
		display
	fi
	;;
5)
	if [ ! -f "/record" ];then
		echo "No record!"
	else
		vi 
	fi
	;;
Q|q)
	tui;;
H|h)
	ban;;
*)
    echo "please enter  valid mode"
    sleep 3
    ;;
esac


done





















