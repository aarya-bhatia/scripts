#!/bin/bash

echo $COPYIGNORE;

if ! [ -f $COPYIGNORE ]; then
  echo "ERROR"
  exit 1
fi

TARGET_DIR=$1

if [ -z $TARGET_DIR ]; then
  echo "Usage: $0 target_dir"
  exit 1
fi

if [ ! -d $TARGET_DIR ]; then
  echo "Target directory does not exist."
  exit 1
fi

backup_src=$HOME
backup_dest=$(realpath "$TARGET_DIR")

if [ ! -e "$backup_dest" ]; then
    echo "The path does not exist."
	exit 1
fi

echo "Source directory: $backup_src"
echo "Destination directory: $backup_dest"

sudo rsync -aP --update --exclude-from=$COPYIGNORE --no-o --no-g \
  $backup_src $backup_dest

public_key_path="/mnt/aarya/public.key"
private_key_path="/mnt/aarya/public.key"

sudo sh -c "[ ! -e $public_key_path ] && gpg --export | tee $public_key_path >/dev/null"
sudo sh -c "[ ! -e $private_key_path ] && gpg --export-secret-key | tee $private_key_path >/dev/null"

echo "Backup created in $backup_dest"
