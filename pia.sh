#!/bin/bash
# created by elrey

cd ~/.pia

echo -e "Where would you like to go?\n"
ls | grep -v -E "(crl|ca|auth)" | column
read going
sudo cp ~/scripts/dns-pia /etc/resolv.conf
sudo openvpn "$going"
