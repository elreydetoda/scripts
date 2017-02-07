#!/bin/bash


if [[ $# -ne 1 ]]; then
	echo "one job...one job..."
	exit
fi

seconds=$1; 
date1=$((`date +%s` + $seconds)); 
while [ "$date1" -ge `date +%s` ]; do 
	echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r"; 
done
