#!/bin/sh

on=
off=

paused=$(dunstctl is-paused)

if [ "$1" = "--click" ]; then
	if [ $paused = "false" ]; then
		dunstctl set-paused true
	else
		dunstctl set-paused false
		notify-send "notifications enabled"
	fi
else
	if [ $paused = "false" ]; then
		echo $on
	else
		echo $off
	fi
fi

