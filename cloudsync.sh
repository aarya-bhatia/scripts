#!/bin/bash

echo $COPYIGNORE;

if ! [ -f $COPYIGNORE ]; then
  echo "ERROR"
  exit 1
fi

read -p "override remote files with local files [y/n]?" ans
if [ $ans = 'y' ]; then
	rclone sync --exclude-from=$COPYIGNORE -v ~/GoogleDrive gdrive:
else
	rclone copy --exclude-from=$COPYIGNORE -v --update ~/GoogleDrive gdrive:
	rclone copy --exclude-from=$COPYIGNORE -v --update gdrive: ~/GoogleDrive
fi

