#!/bin/bash
# created by elrey

cd ~/.pia

sudo cp ~/scripts/dns-pia /etc/resolv.conf
sudo openvpn US\ East.ovpn
