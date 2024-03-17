#!/bin/sh
while true; do
	uptime=$(uptime -p)
	echo -e "$uptime"
	sleep 5
done
