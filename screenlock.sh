#!/bin/sh
# screensaver='/usr/share/backgrounds/archlinux/wild.png'
screensaver='~/wallpapers/0001.jpg'
message='The screen will lock soon.'
xautolock -time 1 \
  -locker "~/.local/bin/betterlockscreen --lock" \
  -notify 10 --notifier "notify-send '$message'" \
  -detectsleep -killtime 10 -killer "systemctl suspend" &

