#!/bin/sh
screensaver='~/wallpapers/0001.jpg'
message='The screen will lock soon.'
# locker='betterlockscreen --lock'
locker='i3lock -c 009999'

locktime=25
killtime=15

if ! which xautolock; then
	echo "xautolock is missing"
	exit 1
fi

killall -q xautolock

xautolock -time $locktime -locker "$locker" \
		-notify 15 -notifier "notify-send $message" \
		-detectsleep -killtime $killtime -killer "systemctl suspend"

