#!/bin/sh
source $HOME/bash_profile
if [ -z $EDITOR ]; then
	EDITOR=/usr/bin/vi
fi

selection=$(echo profile bashrc lf i3 i3modes i3workspace i3status i3blocks nvim | sort | sed "s/ /\n/g" | dmenu -p "config >")

if [ $selection = "bashrc" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.bashrc"
elif [ $selection = "profile" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.profile"
elif [ $selection = "lf" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.config/lf/lfrc"
elif [ $selection = "i3" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.config/i3/config"
elif [ $selection = "i3modes" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.config/i3/modes.conf"
elif [ $selection = "i3workspace" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.config/i3/workspace.conf"
elif [ $selection = "i3blocks" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.config/i3blocks/config"
elif [ $selection = "nvim" ]; then
	alacritty -e /bin/bash -c "$EDITOR /home/aarya/.config/nvim/init.vim"
fi

