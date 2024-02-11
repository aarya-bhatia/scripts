#!/bin/bash

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

auto=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        -y)
			auto=1
            ;;
        *)
            ;;
    esac
    # Shift to the next argument
    shift
done

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

yes=0

if [ $auto -ne 1 ]; then
	read -p "sync cloud storage: [y/n]" ans
	[ $ans = 'y' ] && yes=1
fi

if [ $yes -eq 1 -o $auto -eq 1 ]; then
	$HOME/scripts/cloudsync.sh
fi

yes=0

if [ $auto -ne 1 ]; then
	read -p "update system packages: [y/n]" ans
	[ $ans = 'y' ] && yes=1
fi

read -p "update snap packages: [y/n]" ans
[ $ans = 'y' ] && sudo snap refresh

if which pacman 2>/dev/null; then
	# pacman -Q > $HOME/dotfiles/pacman.txt

	if [ $yes -eq 1 -o $auto -eq 1 ]; then
		sudo pacman -Syu
	fi
fi

if which apt 2>/dev/null; then
	# apt list > $HOME/dotfiles/apt.txt

	if [ $yes -eq 1 -o $auto -eq 1 ]; then
		sudo apt update -y && sudo apt upgrade -y
	fi
fi

echo "Sync successful!"

if which neofetch &>/dev/null; then
	neofetch
fi

