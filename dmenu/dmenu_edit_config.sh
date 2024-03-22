#!/bin/sh

EDITOR=nvim
name=$(echo sxhkd bspwm autostart polybar lf i3 tmux nvim scripts | sed "s/ /\n/g" | dmenu -p "Edit config file > ")
if [ -z "$name" ]; then
	exit 1
fi

Open() {
	exec alacritty -e $EDITOR "$1"
}

case "$name" in
	"i3") Open /home/aarya/.config/i3/config ;;
	"sxhkd") Open /home/aarya/.config/sxhkd/sxhkdrc ;;
	"polybar") Open /home/aarya/.config/polybar/config.ini ;;
	"lf") Open /home/aarya/.config/lf/lfrc ;;
	"tmux") Open /home/aarya/.config/tmux/tmux.conf ;;
	"bspwm") Open /home/aarya/.config/bspwm/bspwmrc ;;
	"autostart") Open /home/aarya/.config/bspwm/autostart.sh ;;
	"nvim") Open /home/aarya/.config/nvim/init.vim ;;
	"scripts")
		file=$(fd . /home/aarya/scripts | sed 's|^/home/aarya/scripts/||' |
				dmenu -p "Select file: ")
		[ -z "$file" ] ||  \
			[ -f "/home/aarya/scripts/$file" ] && \
				Open "/home/aarya/scripts/$file" ;;
	*)
		file=$(fd . $HOME/.config | grep -m 1 -iE "$name")
		[ -z "$file" ] || [ -f "$file" ] && Open "$file" ;;
esac
