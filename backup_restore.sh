#!/bin/sh

if ! which rsync; then
	echo "rsync is not installed"
	exit 1
fi

echo "restoring /home/$USER/ from /mnt/$USER"

sudo rsync --archive --progress --human-readable --delete --update \
	--exclude-from=$COPYIGNORE --no-owner --no-group /mnt/$USER/ /home/$USER/

sudo chown -R $USER:$USER /home/$USER/
