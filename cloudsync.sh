#!/bin/bash

echo $COPYIGNORE;

if ! [ -f $COPYIGNORE ]; then
	echo "File missing:" $COPYIGNORE
	exit 1
fi

GDRIVE_LOCAL=$HOME/GoogleDrive
GDRIVE_REMOTE=gdrive:

if ! [ -f $GDRIVE_LOCAL ]; then
	mkdir -p $GDRIVE_LOCAL
fi

read -p "override remote files with local files [y/n]?" ans
if [ $ans = 'y' ]; then
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL/Desktop $GDRIVE_REMOTE/Desktop
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL/Documents $GDRIVE_REMOTE/Documents
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL/uiuc $GDRIVE_REMOTE/uiuc
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL/Pictures $GDRIVE_REMOTE/Pictures
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL/Notes $GDRIVE_REMOTE/Notes
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL/Videos $GDRIVE_REMOTE/Videos
	exit 0
fi

read -p "override local files with remote files [y/n]?" ans
if [ $ans = 'y' ]; then
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE/Desktop $GDRIVE_LOCAL/Desktop
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE/Documents $GDRIVE_LOCAL/Documents
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE/uiuc $GDRIVE_LOCAL/uiuc
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE/Pictures $GDRIVE_LOCAL/Pictures
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE/Notes $GDRIVE_LOCAL/Notes
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE/Videos $GDRIVE_LOCAL/Videos
	exit 0
fi

read -p "bidirectional copy [y/n]?" ans
if [ $ans = 'y' ]; then
	rclone copy --exclude-from=$COPYIGNORE -v --update $GDRIVE_LOCAL $GDRIVE_REMOTE
	rclone copy --exclude-from=$COPYIGNORE -v --update $GDRIVE_REMOTE $GDRIVE_LOCAL
	exit 0
fi

