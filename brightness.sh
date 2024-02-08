#!/bin/sh
if command -v brightnessctl > /dev/null 2>&1; then
	result=$(brightnessctl | grep -oE "\([0-9]+%\)" | sed "s/(\|)//g")
	echo $result
else
	echo 0
fi
