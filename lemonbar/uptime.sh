#!/bin/sh
while true; do
	uptime=$(uptime -p | cut -c 3- | tr -d ",")
	echo -e "\uf2f2 $uptime"
	sleep 5
done
