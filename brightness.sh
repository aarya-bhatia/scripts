#!/bin/sh
if command -v brightnessctl > /dev/null 2>&1; then
	brightnessctl | grep -oP "\([\d]+%\)" | sed "s/(\|)//g"
	# max_brightness=$(brightnessctl m)
	# cur_brightness=$(brightnessctl get)
	# percentage=$(python -c "print(round(100*$cur_brightness/$max_brightness))")
	# printf "%s%%" $percentage
else
	printf '0'
fi
