#!/bin/sh
if ! which scrot; then
	notify-send -u normal -t 2000 "scrot: command not found!"
	exit 1
fi

DIR=/home/$USER/GoogleDrive/Pictures/screenshots
timestamp=$(date +"%Y-%m-%d_%s")
file="$DIR/screenshot-$timestamp.png"

mkdir -p $DIR

scrot "$@" -f $file

if [ -f $file ]; then
	echo "Screenshot file: $file"
	du -h $file
else
	echo "Failed to take screenshot."
	notify-send -u normal -t 2000 "Failed to take screenshot"
	exit 1
fi

message="Screenshot saved to $file"
notify-send -u normal -t 2000 -a "INFO" "$message"

# copy filename to clipboard
echo $file | xsel -b -i

if which optipng; then
	echo "Optimizing PNG file..."
	optipng -quiet $file
	du -h $file
else
	notify-send -u normal -t 2000 "optipng: command not found!"
fi

sxiv "$file" &
