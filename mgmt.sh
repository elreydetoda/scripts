#!/bin/bash

int=$(ip link list | grep wl | awk '{print $2}' | cut -d ':' -f 1)
sudo ip link set down $int
sudo macchanger -p $int
sudo ip link set up $int
