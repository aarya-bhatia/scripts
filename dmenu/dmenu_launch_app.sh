#!/usr/bin/env bash
values=("firefox" "thunderbird" "discord" "chromium" "libreoffice" "arandr"
	"font-manager" "virt-manager" "qalculate" "lxappearance" "thunar" "vlc"
	"pavucontrol" "blueman-manager")

chosen=$(for value in "${values[@]}"; do
    echo $value
done | dmenu -i -p "Run >" -l 20)

if [ -z "$chosen" ]; then
	exit 0
fi

if ! which $chosen; then
	notify-send "aarya" "Application not found: $chosen"
	exit 1
fi

exec $chosen
