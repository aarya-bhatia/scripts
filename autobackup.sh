#!/bin/sh
set -e
lsblk
printf "mounting /dev/sda1 to /mnt [y/n]:"
read ans
if [ ! $ans = "y" ]; then
	echo "bye"
	exit 1
fi
sudo mount /dev/sda1 /mnt
exec /home/aarya/scripts/backup.sh /mnt
