#!/bin/bash

if ! [ -f $COPYIGNORE ]; then
	echo "COPYIGNORE is not set"
	exit 1
fi

if ! which rsync; then
	echo "rsync is not installed"
	exit 1
fi

echo "backing up /home/$USER/ to /mnt/$USER"

sudo rsync --archive --progress --human-readable --delete --update \
	--exclude-from=$COPYIGNORE --no-owner --no-group /home/$USER/ /mnt/$USER/

pubkey="$backup_dest/public.pgp"
privkey="$backup_dest/private.pgp"

if ! [ -e $pubkey ]; then
	gpg --armor --export aarya.bhatia1678@gmail.com | sudo tee $pubkey >/dev/null
fi

if ! [ -e $privkey ]; then
	gpg --armor --export-secret-key aarya.bhatia1678@gmail.com | sudo tee $privkey >/dev/null
fi

echo "Backup created in $backup_dest"
