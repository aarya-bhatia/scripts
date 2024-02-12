#!/bin/sh

get_volume() {
	pamixer --get-volume-human
}

get_brightness() {
	if command -v brightnessctl > /dev/null 2>&1; then
		b=$(qalc -t $(brightnessctl get)/$(brightnessctl max)*100)
		printf "%.0f%%\n" $b
		# brightnessctl | grep -oE "\([0-9]+%\)" | sed "s/(\|)//g"
	else
		echo 0
	fi
}

show_volume_notif() {
	ID_file=~/.local/state/volume_notif_id

	if [ -f $ID_file ]; then
		ID=$(cat $ID_file)
		notify-send -r "$ID" "volume: $(get_volume)"
	else
		ID=$(notify-send -p "volume: $(get_volume)")
		echo $ID > $ID_file
	fi
}

show_brightness_notif() {
	ID_file=~/.local/state/brightness_notif_id

	if [ -f $ID_file ]; then
		ID=$(cat $ID_file)
		notify-send -r "$ID" "brightness: $(get_brightness)"
	else
		ID=$(notify-send -p "brightness: $(get_brightness)")
		echo $ID > $ID_file
	fi
}

update_volume_i3blocks() {
	pkill -RTMIN+10 i3blocks
}

update_brightness_i3blocks() {
	pkill -RTMIN+11 i3blocks
}

case "$1" in
	get_volume) get_volume ;;

	get_brightness) get_brightness ;;

	set)
		pamixer --set-volume "$2"
		update_volume_i3blocks
		show_volume_notif
		;;

	up)
		pamixer -i 5
		update_volume_i3blocks
		show_volume_notif
		;;

	down)
		pamixer -d 5
		update_volume_i3blocks
		show_volume_notif
		;;

	mute)
		pamixer --toggle-mute
		update_volume_i3blocks
		show_volume_notif
		;;

	brightness_up)
		brightnessctl set +5%
		update_brightness_i3blocks
		show_brightness_notif
 		;;

	brightness_down)
		brightnessctl set 5%-
		update_brightness_i3blocks
		show_brightness_notif
		;;
esac

