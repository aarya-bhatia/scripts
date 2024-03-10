#!/bin/sh
off=󰂲
on=󰂯

status=$(bluetooth status)

if echo $status | grep -q "on"; then
	echo $on
else
	echo $off
fi

