#!/bin/sh

# Reset to defaults
setxkbmap -layout us -option

# Map CapsLock to Control when pressed with another key
setxkbmap -option 'caps:ctrl_modifier'

# setxkbmap -option 'caps:ctrl_modifier' -option 'altwin:swap_alt_win'

killall -q xcape

# Run xcape to make CapsLock act as Escape when pressed and released alone
xcape -e 'Caps_Lock=Escape' &

setxkbmap -query

