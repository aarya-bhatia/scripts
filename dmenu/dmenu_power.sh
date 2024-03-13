#!/bin/sh

case $(echo -e "Lock\nSleep\nReboot\nPoweroff" | dmenu) in
	"Lock") betterlockscreen -l --off 10 ;;
	"Sleep") systemctl suspend ;;
	"Reboot") reboot ;;
	"Poweroff") poweroff ;;
	*) exit 1
esac
