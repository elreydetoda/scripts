#!/bin/bash
# created by elrey

revert() {
set dpms 0 0 300
}
trap revert SIGHUP SIGINT SIGTERM
start_time="$(date +'%F-%H:%M:%S')"
echo "$start_time Start Lock" | sudo tee -a /var/log/auth.log

xset dpms 5 5 5
xset dpms force off &
i3lock -d -u -i "/home/$USER/pictures/lockscreen.png" -p win -e -f -n 
revert
failed="$(tail -n+$(cat /var/log/auth.log | grep -n "$start_time Start Lock" | cut -d ':' -f 1) /var/log/auth.log |  grep unix_chkpwd |  wc -l)"
echo $failed
if [ $failed -gt 0 ] ; then
	zenity --error --text="Someone has tried $failed times to login to your computer! Don't worry I took a picture though :)" --title="Logon Attempts"
else
	zenity --error --text="All ok in the computer world :)" --title="Logon Attempts"
fi
