#!/bin/bash
# created by elrey

sudo useradd upgrader
echo "upgrader 	ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get update" | sudo tee -a /etc/sudoers
echo "upgrader 	ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get upgrade -y" | sudo tee -a /etc/sudoers
echo "upgrader 	ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get dist-upgrade -y" | sudo tee -a /etc/sudoers
sudo -H -u upgrader bash -c '(crontab -l 2>/dev/null; echo "* * */2 * * sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y") | crontab -'
sudo -H -u upgrader bash -c 'sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y'
exit
