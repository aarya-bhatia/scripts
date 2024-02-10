#!/usr/bin/env bash
values=("firefox" "thunderbird" "discord" "chromium")
chosen=$(for value in "${values[@]}"; do
    echo $value
done | dmenu -i -p "Run >")

if ! which $chosen; then
	notify-send "aarya" "Application not found: $chosen"
	exit 1
fi

$chosen
