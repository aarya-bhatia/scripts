#!/bin/sh

killprogs() {
	pkill -x redshift
}

logout() {
	killprogs
	bspc quit
}

lock() {
	betterlockscreen -l --off 10
}

items="logout
lock
sleep
reboot
poweroff
hibernate
hybrid
"

case $(printf '%s' "$items" | dmenu -i) in
	exit|logout) logout ;;
	lock) lock ;;
	sleep|suspend) systemctl suspend ;;
	hibernate) systemctl hibernate ;;
	hybrid|hybrid-sleep) systemctl hybrid-sleep ;;
	reboot|restart) systemctl reboot ;;
	halt|poweroff|shutdown) systemctl poweroff ;;
	*) exit 1 ;;
esac
