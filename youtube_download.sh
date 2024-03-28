#!/bin/sh
if [ -z $1 ]; then
	printf "Usage: %s <playlist_url>\n" $0
	exit 1
fi

yt-dlp -x --audio-format m4a $1

