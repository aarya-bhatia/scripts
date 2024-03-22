#!/bin/sh

if pgrep -f "bspc subscribe node_state"; then
	return 0
fi

echo "lemonbar toggle listener started..."
bspc subscribe node_state |
	while read line; do
		action=$(echo $line | awk '{print $5}')

		if [ $action = "fullscreen" ]; then
			value=$(echo $line | awk '{print $6}')
			if [ "$value" = "on" ]; then
				for window in $(xdo id -N "Bar"); do
					xdo hide "$window"
				done
			else
				for window in $(xdo id -N "Bar"); do
					xdo show "$window"
				done
			fi
		fi
	done
