#!/bin/sh
screensaver='~/wallpapers/0001.jpg'
message='xautolock: system is idle'

if ! which xautolock; then
	notify-send "xautolock is missing"
	exit 1
fi

locktime=1 # min
killtime=10 # min
notifytime=60 # sec
corners="----" # top left - top right - botom left - bottom right

notifier="notify-send '$message'"
locker="i3lock --nofork --ignore-empty-password --no-unlock-indicator --color=505050"
killer="systemctl suspend"

killall -q xautolock

xautolock -detectsleep -time $locktime -locker "$locker" \
	-notify $notifytime -notifier "$notifier" \
	-killtime $killtime -killer "$killer" -corners $corners &

