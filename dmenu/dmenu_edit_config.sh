#!/bin/sh

EDITOR=nvim
name=$(echo i3 sxhkd bspwm lfrc tmux | sed "s/ /\n/g" | dmenu -p "Edit config file > ")
file=$(find $HOME/.config/ | grep -v "plugged/" | grep -E -i "$name" | head -n 1)
exec alacritty -e $EDITOR "$file"

