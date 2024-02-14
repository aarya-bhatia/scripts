#!/bin/sh
# wallpaper=$(find "/home/aarya/wallpapers" -type f | grep -E \\
# 	"\.png|\.jpg|\.jpeg" | shuf -n 1 | cut -d" " -f1)

wallpaper=""
cmd="xwallpaper --stretch"

if ! which xwallpaper; then
	notify-send "xwallpaper program is missing"
	exit 1
fi

if [ ! -z "$wallpaper" ] && [ -f "$wallpaper" ]; then
	$cmd "$wallpaper"
	notify-send "changed wallpaper: $wallpaper"
	echo $wallpaper >> ~/wallpaper.log
else
	file='/home/aarya/GoogleDrive/Notes/favorite_wallpapers.txt'
	if [ -f $file ];
	then
		wallpaper="$(cat $file | shuf -n 1)"
		$cmd "$wallpaper"
		notify-send "changed wallpaper: $wallpaper"
	else
		notify-send "file not found: $file"
		exit 1
	fi
fi

