#!/bin/bash

# set in cron and run every minute to create constant connection
# if statement to not cause multiple connections and break ssh
# check the processes for the user you are running as and see
# if there is already a session created for the user before creating
# another one
if [[ $(ps -U $(user) -f | grep [l]ocalhost | wc -l) -ne 1 ]] ; then 

	# clean up all the different connections that might have gotten killed and orphaned
	netstat -plant | awk '{print $7}' | cut -d '/' -f 1 | grep -v '-' | grep -v Address | xargs kill

	# of coarse substitute your own stuff, but this is the reverse ssh command
	ssh -fN -R localhost:6060:localhost:22 $(user)@$(domain)
fi
