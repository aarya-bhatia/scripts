#!/bin/bash
WALLPAPER_DIR='/home/aarya/wallpapers'
wallpaper=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
echo $wallpaper
feh --no-fehbg --bg-scale "$wallpaper"
