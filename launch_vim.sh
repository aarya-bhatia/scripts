#!/usr/bin/env bash
template=/tmp/snippets.XXXXXX
tmpfile=$(mktemp $template)
file $tmpfile
alacritty --class=floating-vim -e nvim $tmpfile
size=$(du -b $tmpfile | cut -f1)
if [ $size -gt 0 ]; then
	cat $tmpfile | xsel -b
	notify-send "temp file copied to clipboard"
else
	rm $tmpfile
	notify-send "temp file removed"
fi
