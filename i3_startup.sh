#!/bin/sh

# Start simple x hotkey daemon
if ! pgrep -f sxhkd; then
	sxhkd &
fi

# Start music player daemon
if ! pgrep -f mpd; then
	mpd &
fi

# Network manager
if ! pgrep -f nm-applet; then
	nm-applet &
fi

# Display wallpaper
~/.fehbg &

# Window compositor
killall -q picom
picom --config ~/.config/picom.conf --backend glx --xrender-sync-fence &

# Always turn on num lock
numlockx on

# Remap Caps Lock to ESC/Control key
~/scripts/keymaps.sh

# Dunst notification daemon
if ! pgrep -f dunst; then
	dunst &
fi

# mirror display with HDMI-1 monitor if connected
~/scripts/screenmirror.sh

# load workspace 3 layout
i3-msg "workspace 3:mail; append_layout /home/aarya/.i3/workspace-3.json"

# Auto lock screen and suspend after some amount of idle time
# ~/scripts/screenlock.sh &

