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

lock() {
	i3lock && systemctl suspend
}

case "$chosen" in
	lock) confirm "lock" && lock ;;
	logout) confirm "logout" && killall -q i3 ;;
	suspend) confirm "suspend" && systemctl suspend ;;
	reboot) confirm "reboot" && reboot ;;
	poweroff) confirm "poweroff" && poweroff ;;
esac
