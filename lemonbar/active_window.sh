#/bin/sh

GetWindow() {
	window=$(xdotool getwindowfocus getwindowname | head -c 30)
	echo -e "[]= $window"
}

GetWindow

bspc subscribe node_focus | while read line; do
	GetWindow
done
