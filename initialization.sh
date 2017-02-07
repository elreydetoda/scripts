#!/bin/bash

# this is setting up for the engagement

# getting the date of engagement
day=$(date -u +%d)
yearMonth=$(date -u +%Y%m)

mkdir ~/engagement/${yearMonth}/
mkdir ~/engagement/${yearMonth}/${1}-$day/
mkdir ~/engagement/${yearMonth}/${1}-$day/notes/
mkdir ~/engagement/${yearMonth}/${1}-$day/evidence/
mkdir ~/engagement/${yearMonth}/${1}-$day/evidence/scans/
mkdir ~/engagement/${yearMonth}/${1}-$day/evidence/scans/nmap/
mkdir ~/engagement/${yearMonth}/${1}-$day/evidence/scans/nmap/initial/
mkdir ~/engagement/${yearMonth}/${1}-$day/evidence/scans/masscan/

echo 'starting the vulnerability scan'
vuln-scans.sh $1 $2
