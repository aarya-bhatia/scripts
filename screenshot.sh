#!/bin/sh
set -e

DIR=/home/$USER/GoogleDrive/Pictures/screenshots
timestamp=$(date +"%Y-%m-%d_%s")
file="$DIR/screenshot-$timestamp.png"

scrot -f $file "$@" -e "optipng $file" >/dev/null &

iconpath=/usr/share/icons/gnome/16x16/actions/document-save.png
message="Screenshot saved to $file"
notify-send -u normal -t 2000 -i $iconpath -a "INFO" "$message"

