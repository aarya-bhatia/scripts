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
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_LOCAL $GDRIVE_REMOTE
	exit 0
fi

read -p "override local files with remote files [y/n]?" ans
if [ $ans = 'y' ]; then
	rclone sync --exclude-from=$COPYIGNORE -v $GDRIVE_REMOTE $GDRIVE_LOCAL
	exit 0
fi

echo "running bidirectional copy"

rclone copy --exclude-from=$COPYIGNORE -v --update $GDRIVE_LOCAL $GDRIVE_REMOTE
rclone copy --exclude-from=$COPYIGNORE -v --update $GDRIVE_REMOTE $GDRIVE_LOCAL

