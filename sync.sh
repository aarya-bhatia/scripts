#!/bin/sh

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

mkdir -p ~/dotfiles/config
copyignore="/home/aarya/dotfiles/copyignore"
opts="-avu --exclude-from=$copyignore"
directories=(
"$HOME/.config/i3"
"$HOME/.config/polybar"
"$HOME/.config/terminator"
"$HOME/.config/rofi"
"$HOME/.config/nvim"
"$HOME/.config/zathura"
"$HOME/.config/qutebrowser"
"$HOME/.config/lf"
)

for directory in "${directories[@]}"; do
  rsync $opts $directory $HOME/dotfiles/config
done

rsync $opts $HOME/.xinitrc $HOME/dotfiles/xinitrc
rsync $opts $HOME/.Xmodmap $HOME/dotfiles/Xmodmap
rsync $opts $HOME/.gitconfig $HOME/dotfiles/gitconfig
rsync $opts $HOME/.agignore $HOME/dotfiles/agignore
rsync $opts $HOME/.clang-format $HOME/dotfiles/clang-format
rsync $opts $HOME/.ssh/config $HOME/.ssh/*.pub $HOME/dotfiles/config/ssh
rsync $opts $HOME/.config/picom.conf $HOME/dotfiles/config/picom.conf

which pacman >&/dev/null && pacman -Q > $HOME/dotfiles/pacman.txt

crontab -l > $HOME/dotfiles/crontab

cd $HOME/dotfiles
git add .
git commit -m "Synced on $(date +'%x %X')"

cd $HOME/scripts
git add .
git commit -m "Synced on $(date +'%x %X')"

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
	read "update system packages: [y/n]" ans
	[ $ans = 'y' ] && yes=1
fi

if [ $yes -eq 1 -o $auto -eq 1 ]; then
	sudo pacman -Syu
fi


