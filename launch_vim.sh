#!/usr/bin/env bash
template=/tmp/snippets.XXXXXX
tmpfile=$(mktemp $template)
alacritty --class=floating -e vim $tmpfile
size=$(du -b $tmpfile | cut -f1)
if [ $size -gt 0 ]; then
	cat $tmpfile | xsel -b
	notify-send "temp file copied to clipboard"
else
	rm $tmpfile
	notify-send "temp file removed"
fi
