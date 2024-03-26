#!/bin/sh

values="firefox
	thunderbird
	discord
	chromium
	libreoffice
	arandr
	font-manager
	virt-manager
	qalculate
	lxappearance
	thunar
	vlc
	pavucontrol
	blueman-manager"

chosen=$(printf "%s" "$values" | dmenu -i -l 20)

[ -z "$chosen" ] && exit 0

if ! which $chosen; then
	notify-send "application not found: $chosen"
	exit 1
fi

exec $chosen
