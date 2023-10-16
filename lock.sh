#!/bin/sh

wallpaper=$HOME/wallpapers/png/0001.png

use_i3lock() {
	echo "using i3lock"
	i3lock --image $wallpaper --fill \
		--ignore-empty-password --show-failed-attempts \
		--indicator
}

if [ $1 = "i3" ]; then
	use_i3lock
	exit 0
fi

if [ $(pgrep xautolock) ]; then
	echo "using xautolock"
	xautolock -locknow
elif [ $(which betterlockscreen) ]; then
	echo "using betterlockscreen"
	betterlockscreen --lock dim --off 10 --time-format "%r"
elif [ $(which i3lock) ]; then
	use_i3lock
else
	systemctl suspend
fi

