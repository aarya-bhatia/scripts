#!/bin/bash

echo $COPYIGNORE;

if ! [ -f $COPYIGNORE ]; then
  echo "ERROR"
  exit 1
fi

backup_src="/home/aarya"
backup_dest="/mnt/aarya/backup"

sudo rsync -aP --update --exclude-from=$COPYIGNORE --no-o --no-g \
  $backup_src $backup_dest

public_key_path="/mnt/aarya/public.key"
private_key_path="/mnt/aarya/public.key"

sudo sh -c "[ ! -e $public_key_path ] && gpg --export | tee $public_key_path >/dev/null"
sudo sh -c "[ ! -e $private_key_path ] && gpg --export-secret-key | tee $private_key_path >/dev/null"

echo "Backup created in $backup_dest"
