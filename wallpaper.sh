#!/bin/sh

get_random_wallpaper() {
	find "/home/aarya/wallpapers" -type f | grep -E "\.png|\.jpg|\.jpeg" | shuf -n 1 | cut -d" " -f1
}

if ! which xwallpaper; then
	notify-send "xwallpaper program is missing"
	exit 1
fi

set_wallpaper_and_quit() {
	xwallpaper --stretch "$1"
	notify-send "wallpaper changed: $wallpaper"
	echo $wallpaper >> ~/wallpaper.log
	exit 0
}

wallpaper="/home/aarya/wallpapers/0055.jpg"
if [ ! -z "$wallpaper" ] && [ -f "$wallpaper" ]; then
	set_wallpaper_and_quit "$wallpaper"
fi

file="/home/aarya/GoogleDrive/Notes/favorite_wallpapers.txt"
if [ -f "$file" ]; then
	set_wallpaper_and_quit "$(cat $file | shuf -n 1)"
else
	notify-send "file not found: $file"
	exit 1
fi
