#!/bin/sh

on=
off=

if dunstctl is-paused | grep -q false; then
	echo $on
else
	echo $off
fi
