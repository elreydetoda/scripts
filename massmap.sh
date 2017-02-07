#!/bin/bash

if [[ $# = 2 ]] ; then
	mkdir $2
	cd $2
	ips=$(nmap -T5 -Pn $1 | grep "report for" | cut -d " " -f 5)
	for ip in $ips; do
		ports=$(masscan -p 0-65535 $ip | grep "open port" | cut -d " " -f 4 | cut -d "/" -f 1)
		mkdir $ip
		nmap -T5 -v -A -Pn -p $ports -oA $ip/$ip $ip
		echo "\n\n##################################################"
		echo "done with ip address $ip"
		echo "##################################################\n\n"
	done
else
	# tell how to use the script
	echo "Please enter in variables as follows"
	echo "massmap.sh \$ip \$filename"
fi


