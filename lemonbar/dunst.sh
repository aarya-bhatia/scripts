#!/bin/sh

on=
off=

if dunstctl is-paused | grep -q false; then
	echo $off
else
	echo $on
fi
