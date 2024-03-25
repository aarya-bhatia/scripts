#/bin/sh

MAXLENGTH=50

GetWindow() {
	window=$(xdotool getwindowfocus getwindowname | head -c $MAXLENGTH)
	echo -e "[]= $window"
}

GetWindow

bspc subscribe node_focus | while read line; do
	GetWindow
done
