#!/bin/sh
# echo ♪ $($HOME/scripts/volume.sh get_volume | tr -d %)

Get() {
	if [ $(pamixer --get-mute) = "true" ]; then
		echo "mute"
	else
		echo $(pamixer --get-volume | tr -d %)
	fi
}

echo v: $(Get)
