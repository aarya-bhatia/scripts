#!/bin/bash
values=("lock" "logout" "suspend" "reboot" "poweroff")
chosen=$(for value in "${values[@]}"; do
    echo $value
done | dmenu -i -p "Run >")

confirm(){
	ans=$(printf "yes\nno\n" | dmenu -i -p "Are you sure you want to $1?")
	if [ $ans = "yes" ]; then
		return 0
	else
		return 1
	fi
}

case "$chosen" in
	lock) confirm "lock" && xautolock -locknow ;;
	logout) confirm "logout" && i3-msg exit ;;
	suspend) confirm "suspend" && i3lock -e -u && systemctl suspend ;;
	reboot) confirm "reboot" && reboot ;;
	poweroff) confirm "poweroff" && poweroff ;;
esac
