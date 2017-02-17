#!/bin/bash
# created by elrey

sudo ip link set up enx94103eb88f79
sleep 2
sudo dhclient enx94103eb88f79
sudo cp ~/scripts/lab-dns /etc/resolv.conf
