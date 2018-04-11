#!/bin/bash

#Summary:Enable tab complete for python

#Description:
#	Needs import readline and rlcompleter module
#	import readline
#	import rlcompleter
#	help(rlcompleter) display detail: readline.parse_and_bind('tab: complete')
#	man python display detail: PYTHONSTARTUP variable

[ ! -f /usr/bin/tab.py ]&& cp ./tab.py /usr/bin/
sed  -i '$a export PYTHONSTARTUP=/usr/bin/tab.py' /etc/profile
source /etc/profile
