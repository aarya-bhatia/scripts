#!/bin/sh

case $(echo -e "Logout\nLock\nSleep\nReboot\nPoweroff" | dmenu) in
	"Logout") bspc quit ;;
	"Lock") betterlockscreen -l --off 10 ;;
	"Sleep") systemctl suspend ;;
	"Reboot") reboot ;;
	"Poweroff") poweroff ;;
	*) exit 1
esac
