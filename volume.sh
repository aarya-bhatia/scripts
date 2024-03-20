#!/bin/sh

get_volume() {
	pamixer --get-volume-human
}

get_brightness() {
	if command -v brightnessctl > /dev/null 2>&1; then
		b=$(qalc -t $(brightnessctl get)/$(brightnessctl max)*100)
		printf "%.0f%%\n" $b
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

get_album_art() {
    url=$(playerctl -f "{{mpris:artUrl}}" metadata)
    if [[ $url == "file://"* ]]; then
        album_art="${url/file:\/\//}"
    elif [[ $url == "http://"* ]] && [[ $download_album_art == "true" ]]; then
        # Identify filename from URL
        filename="$(echo $url | sed "s/.*\///")"

        # Download file to /tmp if it doesn't exist
        if [ ! -f "/tmp/$filename" ]; then
            wget -O "/tmp/$filename" "$url"
        fi

        album_art="/tmp/$filename"
    elif [[ $url == "https://"* ]] && [[ $download_album_art == "true" ]]; then
        # Identify filename from URL
        filename="$(echo $url | sed "s/.*\///")"

        # Download file to /tmp if it doesn't exist
        if [ ! -f "/tmp/$filename" ]; then
            wget -O "/tmp/$filename" "$url"
        fi

        album_art="/tmp/$filename"
    else
        album_art=""
    fi
}

show_player_notif() {
	ID_file=~/.local/state/player_notif_id

    song_title=$(playerctl -f "{{title}}" metadata)
    song_artist=$(playerctl -f "{{artist}}" metadata)
    song_album=$(playerctl -f "{{album}}" metadata)

	get_album_art

	# notify-send -r "$ID" "volume: $(get_volume)"
	# ID=$(notify-send -p "volume: $(get_volume)")

	if [ ! -z "$song_title" ]; then
		if [ -f $ID_file ]; then
			ID=$(cat $ID_file)
			notify-send -r "$ID" -i "$album_art" "$song_title" "$song_artist"
		else
			ID=$(notify-send -p -i "$album_art" "$song_title" "$song_artist")
			echo $ID > $ID_file
		fi
	fi
}

panel_update_volume() {
	# test -e /tmp/lemonbar.fifo && echo volume > /tmp/lemonbar.fifo
	# polybar-msg action my_volume hook 0
	pkill -SIGUSR1 -f bin/topbar
}

panel_update_brightness() {
	# test -e /tmp/lemonbar.fifo && echo brightness > /tmp/lemonbar.fifo
	# polybar-msg action my_brightness hook 0
	return 0
}

case "$1" in
	get_volume) get_volume ;;

	get_brightness) get_brightness ;;

	set)
		pamixer --set-volume "$2"
		panel_update_volume
		show_volume_notif
		;;

	up)
		pamixer --allow-boost -i 5
		panel_update_volume
		show_volume_notif
		;;

	down)
		pamixer --allow-boost -d 5
		panel_update_volume
		show_volume_notif
		;;

	mute)
		pamixer --toggle-mute
		panel_update_volume
		show_volume_notif
		;;

	brightness_up)
		brightnessctl set +5%
		panel_update_brightness
		show_brightness_notif
 		;;

	brightness_down)
		brightnessctl set 5%-
		panel_update_brightness
		show_brightness_notif
		;;

    play_pause)
		playerctl play-pause
		show_player_notif
		;;

	next_track)
		playerctl next
		sleep 0.5
		show_player_notif
		;;

	prev_track)
		playerctl previous
		sleep 0.5
		show_player_notif
		;;
esac


