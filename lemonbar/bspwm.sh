#!/bin/sh
background="#2D2D2D"

bspc subscribe desktop_focus | while read line; do
	echo $line
	desktops=$(bspc query -D --names | sed "s/Desktop//")
	focused=$(bspc query -D --names -d focused)
	# desktops=$(echo $desktops | sed "s/$focused/%{B$background}%{+u}_$focused\_%{-u}%{B-}/")
	desktops=$(echo $desktops | sed "s/$focused/ [$focused] /")
	echo $desktops
done
