#!/bin/sh

# Map CapsLock to Control when pressed with another key
setxkbmap -option 'caps:ctrl_modifier'

killall xcape 2>/dev/null

# Run xcape to make CapsLock act as Escape when pressed and released alone
xcape -e 'Caps_Lock=Escape'

