#!/bin/bash
WALLPAPER_DIR='/home/aarya/wallpapers'
wallpaper=$(find "$WALLPAPER_DIR" -type f | grep -E "\.png$|\.jpg$|\.jpeg$" | shuf -n 1)

# if which nitrogen; then
# 	killall -q nitrogen
# 	nitrogen "$wallpaper" && echo $wallpaper >> ~/wallpaper.log
if which feh; then
	killall -q feh
	feh --no-fehbg --bg-scale "$wallpaper" && echo $wallpaper >> ~/wallpaper.log
else
	notify-send "aarya" "failed to set wallpaper"
fi

