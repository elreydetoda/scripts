#!/bin/bash

xrandr --setprovideroutputsource 1 0
sleep 1
xrandr --output DP1 --right-of eDP1 --auto
sleep 1
xrandr --output DVI-I-1-1 --right-of DP1 --auto
sleep 1
xrandr --output eDP1 --mode 1920x1080 && DISPLAY=:0.0 feh --randomize --bg-fill /home/$USER/pictures/background-pics/*
