#!/bin/bash
INPUT_FILE=
[ -z $INPUT_FILE ] && exit 1

for file in $(cat INPUT_FILE); do
	found=$(ls $HOME/wallpapers | grep -P "^[0]+$file\.(png|jpg)")
	cp $HOME/wallpapers/$found $HOME/wp_shuffle/
done
