#!/bin/bash
current=`acpi`
power=$(echo $current | cut -d ',' -f 2 | cut -d ' ' -f 2 | tr -d "%" )

if [[ "$current" =~ "Charging" ]]; then
  printf "%s+" $power
elif [[ "$current" =~ "Full" ]]; then
  printf "FULL"
elif [ $power -le 20 ]; then
  printf "LOW"
else
  printf "%s-" $power
fi

