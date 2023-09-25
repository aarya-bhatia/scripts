#!/bin/bash

echo $COPYIGNORE;

if ! [ -f $COPYIGNORE ]; then
  echo "ERROR"
  exit 1
fi

rclone copy --exclude-from=$COPYIGNORE -v --update ~/GoogleDrive gdrive:
rclone copy --exclude-from=$COPYIGNORE -v --update gdrive: ~/GoogleDrive
# rclone copy --exclude-from=$COPYIGNORE -v --update ~/OneDrive onedrive:
# rclone copy --exclude-from=$COPYIGNORE -v --update onedrive: ~/OneDrive

