#!/bin/sh
background="#2D2D2D"

GetDesktops() {
	desktops=$(bspc query -D --names | sed "s/Desktop//")
	focused=$(bspc query -D --names -d focused)
	desktops=$(echo $desktops | sed "s/$focused/ [$focused] /")
	echo $desktops
}

GetDesktops

bspc subscribe desktop_focus | while read line; do
	GetDesktops
done
