#!/bin/bash
current=$(acpi | grep -v "unavailable")
power=$(echo $current | cut -d ',' -f 2 | cut -d ' ' -f 2 )

full=
discharge=
low=

if [[ "$current" =~ "Full" ]]; then
	printf "FULL\n"
elif [[ "$current" =~ "Charging" ]]; then
	printf "CHR %s\n" $power
else
	printf "BAT %s\n" $power
fi

