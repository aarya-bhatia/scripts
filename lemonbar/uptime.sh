#!/bin/sh
uptime=$(uptime -p | cut -c 3- | tr -d ",")
echo -e "\uf2f2 $uptime"
