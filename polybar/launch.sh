#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)
#
# if [[ $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l) == 1 ]]; then
#   MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar mainbar &
# else
#   primary=$(xrandr --query | grep primary | cut -d" " -f1)
#
#   for m in $screens; do
#     if [[ $primary == $m ]]; then
#         MONITOR=$m TRAY_POS=right polybar mainbar &
#     else
#         MONITOR=$m TRAY_POS=none polybar secondary &
#     fi
#   done
# fi

# polybar --reload mainbar 2>&1 | tee -a /tmp/polybar.log & disown

for m in $(polybar --list-monitors | cut -d":" -f1); do
	echo "Launching polybar on display: $m"
	MONITOR=$m polybar --reload mainbar -c ~/.config/polybar/config.ini &
done
