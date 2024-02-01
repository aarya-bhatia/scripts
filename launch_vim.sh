#!/usr/bin/env bash
source /home/aarya/.bash_profile
template=/tmp/snippets.XXXXXX
tmpfile=$(mktemp $template)
file $tmpfile
alacritty --class=floating-vim -e /usr/local/nvim/bin/nvim $tmpfile
size=$(du -b $tmpfile | cut -f1)
if [ $size -gt 0 ]; then
	cat $tmpfile | xsel -b
fi
# rm $tmpfile

