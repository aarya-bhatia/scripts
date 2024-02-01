#!/bin/bash

if ! [ -f $COPYIGNORE ]; then
	echo "COPYIGNORE is not set"
	exit 1
fi

if ! which rsync; then
	echo "rsync is not installed"
	exit 1
fi

DEST=/mnt/$(hostname)/$USER
sudo mkdir -p $DEST
echo "backing up $HOME to $DEST"

sudo rsync --archive --progress --human-readable --delete --update \
	--exclude-from=$COPYIGNORE --no-owner --no-group $HOME/ $DEST/

echo "Backup created in $backup_dest"
