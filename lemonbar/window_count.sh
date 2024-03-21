#!/bin/sh

GetCount() {
	bspc query -N -n .window.local | wc -l
}

GetCount

bspc subscribe node_add node_remove node_transfer desktop_focus |
	while read line; do
		GetCount
	done
