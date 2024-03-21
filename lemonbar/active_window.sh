#/bin/sh

GetWindow() {
	window=$(xdotool getwindowfocus getwindowname)
	echo $window
}

GetWindow

bspc subscribe node_focus | while read line; do
	GetWindow
done
