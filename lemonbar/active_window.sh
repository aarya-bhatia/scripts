#/bin/sh

GetWindow() {
	window=$(xdotool getwindowfocus getwindowname)
	echo -e "[]= $window"
}

GetWindow

bspc subscribe node_focus | while read line; do
	GetWindow
done
