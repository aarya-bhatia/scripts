#!/bin/sh
# screensaver='/usr/share/backgrounds/archlinux/wild.png'
screensaver='~/wallpapers/0001.jpg'
message='The screen will lock soon.'
locker='betterlockscreen --lock'

killall -q xautolock

locktime=25
killtime=15

xautolock -time $locktime -locker "$locker" \
		-notify 15 -notifier "notify-send $message" \
		-detectsleep -killtime $killtime -killer "systemctl suspend" &

