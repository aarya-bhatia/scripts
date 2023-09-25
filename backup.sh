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

# echo "Source directory: $backup_src"
echo "Destination directory: $backup_dest"

copydirs=(
	"$HOME/Backup/"
	"$HOME/repos/"
	"$HOME/GoogleDrive/"
	"$HOME/Documents/"
	"$HOME/Desktop/"
	"$HOME/Library/"
	"$HOME/wallpapers/"
	"$HOME/Development/"
	"$HOME/Downloads/"
	"$HOME/go/"
)

for src in "${copydirs[@]}"; do
	echo "Source directory: $src"
	sudo rsync -aP --update --exclude-from=$COPYIGNORE --no-o --no-g \
	  $src $backup_dest
done

# sudo rsync -aP --update --exclude-from=$COPYIGNORE --no-o --no-g \
#   $backup_src $backup_dest

public_key_path="/mnt/aarya/public.pgp"
private_key_path="/mnt/aarya/private.pgp"

if [ ! -e $public_key_path ]; then
	gpg --armor --export aarya.bhatia1678@gmail.com | sudo tee $public_key_path >/dev/null
fi

if [ ! -e $private_key_path ]; then
	gpg --armor --export-secret-key aarya.bhatia1678@gmail.com | sudo tee $private_key_path >/dev/null
fi

echo "Backup created in $backup_dest"
