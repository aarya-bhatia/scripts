#!/bin/bash

always=0
never=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        -y)
			always=1
            ;;
        -n)
			never=1
            ;;
        *)
            ;;
    esac
    # Shift to the next argument
    shift
done

if [ $always -eq 1 ] && [ $never -eq 1 ]; then
	echo "Please choose either -y or -n option"
	exit 1
fi

confirm() {
	ret_yes=0
	ret_no=1

	if [ $always -eq 1 ]; then
		return $ret_yes
	fi

	if [ $never -eq 1 ]; then
		return $ret_no
	fi

	printf "$1 [y/n]:"
	read ans

	if [ "$ans" = 'y' ]; then
		return $ret_yes
	fi

	return $ret_no
}

copyignore="/home/aarya/dotfiles/copyignore"
if ! [ -f $copyignore ]; then
	echo "file missing:" $copyignore
	exit 1
fi

if ! [ -d $HOME/dotfiles ]; then
	echo "dest missing:" $HOME/dotfiles
	exit 1
fi

files=(
	".config/alacritty/"
	".config/autostart/"
	".config/bspwm/"
	".config/dunst/"
	".config/gtk-2.0/"
	".config/gtk-3.0/"
	".config/gtk-4.0/"
	".config/i3/"
	".config/i3blocks/"
	".config/i3status/"
	".config/lf/"
	".config/lemonbar/"
	".config/polybar/"
	".config/mimeapps.list"
	".config/mpd/"
	".config/ncmpcpp/"
	".config/nvim/"
	".config/pavucontrol.ini"
	".config/picom.conf"
	".config/polybar/"
	".config/sxhkd/"
	".config/sxiv/"
	".config/systemd/user/"
	".config/tmux/tmux.conf"
	".config/user-dirs.dirs"
	".config/user-dirs.locale"
	".config/xfce4/"
	".config/zathura/"
	".config/git/"

	".clang-format"
	".bashrc"
	".bash_profile"
	".vimrc"
	".screenlayout/"

	".local/share/applications/"

	"etc/systemd/"
	"etc/X11/"
)

mkdir -p $HOME/dotfiles/.config/
mkdir -p $HOME/dotfiles/.config/tmux/
mkdir -p $HOME/dotfiles/.ssh/
mkdir -p $HOME/dotfiles/.local/share/
mkdir -p $HOME/dotfiles/etc/

COPY="rsync -au --delete --exclude-from=$copyignore"

for file in "${files[@]}"; do
	if [ -e $HOME/$file ]; then
		$COPY $HOME/$file $HOME/dotfiles/$file
	else
		echo "src file missing:" $HOME/$file
	fi
done

$COPY $HOME/.ssh/config $HOME/.ssh/*.pub $HOME/dotfiles/.ssh/

if which crontab; then
	crontab -l > $HOME/dotfiles/crontab
fi

if [ $always -eq 1 ]; then
	yes | $HOME/scripts/cloudsync.sh
else
	confirm "sync cloud storage" && $HOME/scripts/cloudsync.sh
fi

if confirm "update packages"; then
	if which apt 2>/dev/null; then
		sudo apt update -y && sudo apt upgrade -y
	fi

	if which pacman 2>/dev/null; then
		sudo pacman -Syu --noconfirm
	fi

	if which yay 2>/dev/null; then
		confirm "yay update?" && yay -Syu
	fi

	if which snap 2>/dev/null; then
		sudo snap refresh
	fi
fi

if confirm "update passwords"; then
	pass git add .
	pass git commit -m "Synced on $(date +'%x %X')"
	pass git push
fi

if confirm "dump packages"; then
	which pacman && pacman -Qqe > $HOME/dotfiles/pacman.txt
	which yay && yay -Qqe > $HOME/dotfiles/yay.txt
	which pip && pip list > $HOME/dotfiles/pip.txt
	which apt && apt list > $HOME/dotfiles/apt.txt
	which npm && npm list > $HOME/dotfiles/npm.txt
	which snap && snap list > $HOME/dotfiles/snap.txt
fi

cd $HOME/dotfiles
git add .
git commit -m "Synced on $(date +'%x %X')"
git push

cd $HOME/scripts
git add .
git commit -m "Synced on $(date +'%x %X')"
git push

echo "Sync successful!"

if which neofetch &>/dev/null; then
	neofetch
fi

