#!/bin/sh
if [ -z $1 ]; then
	printf "Usage: %s <playlist_url>\n" $0
	exit 1
fi

bin="/home/aarya/pyvenv/bin"
$bin/python $bin/yt-dlp -x --audio-format m4a $1
# yt-dlp -x --audio-format m4a $1

