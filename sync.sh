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
	".config/i3/"
	".config/i3status/"
	".config/i3blocks/"
	".config/polybar/"
	".config/alacritty/"
	".config/gtk-2.0/"
	".config/gtk-3.0/"
	".config/nvim/"
	".config/zathura/"
	".config/lf/"
	".config/dunst/"
	".config/xfce4/"
	".config/autostart/"

	".config/mimeapps.list"
	".config/picom.conf"
	".config/user-dirs.dirs"
	".config/user-dirs.locale"
	".config/tmux/tmux.conf"
	".config/sxiv/"
	".config/sxhkd/"
	".config/mpd/"
	".config/ncmpcpp/config"
	".config/pavucontrol.ini"

	".fehbg"
	".clang-format"
	".agignore"
	".xinitrc"
	".bashrc"
	".bash_profile"
	".profile"
	".xsession"
	".gitconfig"

	".local/share/applications/"

	"etc/systemd/"
	"etc/X11/"

	".i3/"

	".config/systemd/user/"
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

crontab -l > $HOME/dotfiles/crontab

cd $HOME/dotfiles
git add .
git commit -m "Synced on $(date +'%x %X')"
git push

cd $HOME/scripts
git add .
git commit -m "Synced on $(date +'%x %X')"
git push

confirm "sync cloud storage" && $HOME/scripts/cloudsync.sh

if confirm "update packages: [y/n]"; then
	if which apt 2>/dev/null; then
		sudo apt update -y && sudo apt upgrade -y
		apt list > $HOME/dotfiles/apt.txt
	fi

	if which pacman 2>/dev/null; then
		sudo pacman -Syu
		pacman -Q > $HOME/dotfiles/pacman.txt
	fi

	if which yay 2>/dev/null; then
		yay -Syu
	fi

	if which snap 2>/dev/null; then
		sudo snap refresh
	fi
fi

echo "Sync successful!"

if which neofetch &>/dev/null; then
	neofetch
fi

