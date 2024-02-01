#!/bin/bash

echo $COPYIGNORE;

if ! [ -f $COPYIGNORE ]; then
  echo "ERROR"
  exit 1
fi

read -p "override remote files with local files [y/n]?" ans
if [ $ans = 'y' ]; then
	rclone sync --exclude-from=$COPYIGNORE -v ~/GoogleDrive gdrive:
	exit 0
else
	read -p "override local files with remote files [y/n]?" ans
	if [ $ans = 'y' ]; then
		rclone sync --exclude-from=$COPYIGNORE -v gdrive: ~/GoogleDrive
		exit 0
	fi

	echo "running bidirectional copy"

	rclone sync --exclude-from=$COPYIGNORE -v ~/GoogleDrive gdrive:
	rclone copy --exclude-from=$COPYIGNORE -v --update ~/GoogleDrive gdrive:
	rclone copy --exclude-from=$COPYIGNORE -v --update gdrive: ~/GoogleDrive
fi

