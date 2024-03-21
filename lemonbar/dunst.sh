#!/bin/sh

on=
off=

if [ "$1" = "--click" ]; then
	if [ $(dunstctl is-paused) = "false" ]; then
		dunstctl set-paused true
	else
		dunstctl set-paused false
		notify-send "notifications enabled"
	fi
fi

if [ $(dunstctl is-paused) = "false" ]; then
	echo $on
else
	echo $off
fi

