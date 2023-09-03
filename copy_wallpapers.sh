#!/bin/bash

usage() {
	echo "Usage: $0 input_file"
	exit 1
}

INPUT_FILE=$1
[ -z "$INPUT_FILE" ] && usage

if [ -e $INPUT_FILE ]; then
	for file in $(cat "$INPUT_FILE"); do
		found=$(ls $HOME/wallpapers | grep -P "^[0]+$file\.(png|jpg)")
		echo $found
		[ -z "$found" ] || [ -e "$found" ] && cp "$HOME/wallpapers/$found" $HOME/wp_shuffle
	done
else
	usage
fi
