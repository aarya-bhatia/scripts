#!/bin/bash
current=$(acpi)
power=$(echo $current | cut -d ',' -f 2 | cut -d ' ' -f 2 )

if [[ "$current" =~ "Full" ]]; then
	printf "FULL\n"
elif [[ "$current" =~ "Charging" ]]; then
	printf "CHR %s\n" $power
else
	printf "BAT %s\n" $power
fi

