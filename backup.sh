#!/bin/bash
set -e

if ! [ -f $COPYIGNORE ]; then
	echo "COPYIGNORE is not set"
	exit 1
fi

DEST=/mnt/$(hostname)/$USER
sudo mkdir -p $DEST
echo "backing up $HOME to $DEST"
sudo rsync -ahuP --delete --update --exclude-from=$COPYIGNORE $HOME/ $DEST/
echo "Backup created in $backup_dest"
