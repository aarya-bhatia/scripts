#!/bin/sh
background="#2D2D2D"

desktops=$(bspc query -D --names | sed "s/Desktop//")
focused=$(bspc query -D --names -d focused)

# for desktop in $desktops; do
# 	desktop=$(echo "$desktop")
# 	nodes=$(bspc query -N -d $desktop)
#
# 	if [ ! -z "$nodes" ]; then
# 		desktops=$(echo $desktops | sed "s/$desktop/%{F#ff0000}$desktop%{F-}/")
# fi
# done

desktops=$(echo $desktops | sed "s/$focused/%{B$background}%{+u}_$focused\_%{-u}%{B-}/")

echo $desktops | sed "s/_/ /g"
