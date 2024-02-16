#!/bin/sh
screensaver='~/wallpapers/0001.jpg'
message='system will suspend due to inactivity'

if ! which xautolock; then
	notify-send "xautolock is missing"
	exit 1
fi

locktime=5 # min
killtime=10 # min
notifytime=90 # sec

notifier="sleep 1; xset dpms force off"
locker="i3lock -e -u -c 505050"
killer="systemctl suspend"

xautolock -time $locktime -locker "$locker" \
	-notify $notifytime -notifier "$notifier" \
	-killtime $killtime -killer "$killer" -detectsleep &

