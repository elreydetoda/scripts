#!/bin/bash
# created by elrey

sudo ip link set up enp0s20f0u2c2
sleep 2
sudo dhcpcd enp0s20f0u2c2
sudo cp ~/scripts/lab-dns /etc/resolv.conf
