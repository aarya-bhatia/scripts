#!/bin/sh

# TODO
(for file in $(find /usr/share/applications -type f -name *.desktop); do
	title=$(cat $file | grep ^Name=)
	if [ ! -z "$title" ]; then
		echo $title | cut -d"=" -f2
	fi
done) | dmenu -p "Applications >"

