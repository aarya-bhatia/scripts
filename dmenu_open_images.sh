#!/bin/sh
dir=$(printf "/home/aarya/wallpapers\n/home/aarya/screenshots\n" | dmenu -p "Select image folder > ")
[ ! -z "$dir" ] && [ -d "$dir" ] && exec sxiv -t -r $dir
