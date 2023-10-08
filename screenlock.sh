#!/bin/sh
# screensaver='/usr/share/backgrounds/archlinux/wild.png'
screensaver='~/wallpapers/0001.jpg'
message='The screen will lock soon.'
locker='~/.local/bin/betterlockscreen --lock'

killall -q xautolock

xautolock -time 10 -locker "$locker" \
		-notify 15 -notifier "notify-send $message" \
		-detectsleep -killtime 10 -killer "systemctl suspend" &

