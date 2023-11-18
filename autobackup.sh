#!/bin/sh
set -e
lsblk
device=/dev/sda1
mount=/mnt
backup=/home/aarya/scripts/backup.sh
printf "mounting $device to $mount [y/n]:"
read ans
if [ $ans = "y" ]; then
	sudo mount $device $mount
fi
printf "backup data to $mount [y/n]:"
read ans
if [ $ans = "y" ]; then
	$backup $mount
	printf "unmount $device [y/n]:"
	read ans
	if [ $ans = "y" ]; then
		sudo umount $device
	fi
fi
