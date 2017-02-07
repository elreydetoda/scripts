#!/bin/bash

# the whole goal here is to do an initial preliminary scan to identify the ip addresses, so not to
# do a too in-depth scan, and so you get the ips with the first nmap scan. Creating an array for
# each ip address, then another array per port per ip address array. Use masscan to scan all
# the different ports on each device. After that you use nmap to be able to scan each port per ip
# with an in-depth analysis of each port

# preping for organization
# echo "What do you want the name of the folder to be?"
# read name
# if [[ $name == [a-zA-Z0-9- ] ]] ; then 
# 	echo "You didn't put in an alphanumeric name"
# 	exit 1
# else
# 	echo no
# 	exit 1
# fi

day=$(date -u +%d)
yearMonth=$(date -u +%Y%m)

# getting ready for nework scanning
echo "What type of network is it?"
echo "1) 192.168.0.0/24"
echo "2) 192.168.1.0/24"
echo "3) 172.16.0.0/12"
echo "4) 10.0.0.0/8"
echo "5) custom"

read network

if [ $network -eq 1 ] ; then
	network=192.168.0.0/24
	echo "Using $network"
elif [ $network -eq 2 ] ; then
	network=192.168.1.0/24
	echo "Using $network"
elif [ $network -eq 3 ] ; then
	network=172.16.0.0/12
	echo "Using $network"
elif [ $network -eq 4 ] ; then
	network=10.0.0.0/8
	echo "Using $network"
elif [ $network -eq 5 ] ; then
	echo -e "\nPlease enter the ip address range"
	read network
	network=$network
	echo "Using $network"
else
	echo "You didn't put in correct input"
	exit 1
fi

TIME=$(date -u +%H%M%S)

echo "starting nmap initial scan"
nmap -oG ~/engagement/${yearMonth}/${1}-$day/evidence/scans/nmap/initial/$2-$TIME $network
ips=(`cat ~/engagement/${yearMonth}/${1}-$day/evidence/scans/nmap/initial/$2-$TIME | grep Up | cut -d ' ' -f 2 | tr "\n" ", "`)
echo ${ips[*]}

TIME=$(date -u +%H%M%S)
