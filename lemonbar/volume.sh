#!/bin/sh
# label=♪
action=pavucontrol

Get() {
	if [ $(pamixer --get-mute) = "true" ]; then
		echo "mute"
	else
		echo $(pamixer --get-volume)
	fi
}

echo -e "%{A1:${action}:}v: $(Get)%{A}"
