#!/bin/bash

## Todo
## fzf, ag, fd, thunderbird, nerd font, xsel

timestamp=$(date +%Y%m%d%H%M%S)

# install arch linux packages
if uname -a | grep -qi "arch"; then
    read -p "install arch packages? [y/n]: " choice
    if [[ $choice == [yY] ]]; then
        sudo pacman -Syu base-devel neofetch vim git tmux fd fzf xsel the_silver_searcher neovim ctags
    fi

    read -p "install node? [y/n]: " choice
    if [[ $choice == [yY] ]]; then
        sudo pacman -Syu nodejs npm
        sudo npm install -g neovim
    fi

    read -p "install additional packages? [y/n]: " choice
    if [[ $choice == [yY] ]]; then
        sudo pacman -Syu neovim
    fi
fi


# install packages in Ubuntu OS
if uname -a | grep -qi "ubuntu"; then
    read -p "install ubuntu packages? [y/n]: " choice
    if [[ $choice == [yY] ]]; then
        sudo apt-get update -y
        sudo apt-get install -y build-essential neofetch vim git tmux gdb valgrind fd-find fzf neovim python3 exuberant-ctags
    fi
fi

# install mac os packages
if uname -a | grep -qi "darwin"; then
    if ! command -v brew &> /dev/null
    then
        read -p "install homebrew? [y/n]: " choice
        if [[ $choice == [yY] ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        brew install neofetch vim tmux
    fi
fi

# git setup
if command -v git &> /dev/null
then
    git config --global core.editor "vim"
    git config --global user.email "aarya.bhatia1678@gmail.com"
    git config --global user.name "Aarya Bhatia"
else
    echo "ERROR: git is not installed"
fi

# tmux plugin manager
if command -v git &> /dev/null && command -v tmux &> /dev/null
then
    mkdir -p $HOME/.tmux/plugins
    if [ ! -d $HOME/.tmux/plugins/tpm ]
    then
        git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    fi
else
    echo "ERROR: tmux is not installed"
fi

mkdir -p $HOME/.vim $HOME/.config/nvim $HOME/.tmux

# Usage: create_symlink <old_file> <new_file>
try_create_symlink() {
    local old_file="$1"
    local new_file="$2"

    if [ ! -f "$new_file" ]; then
        new_file=$(find . -type f -name "$new_file" -print -quit)
    fi

    if [ -z "$new_file" ]; then
        echo "Failed to find the new file '$2'"
        return 1
    fi

    if [ -f "$old_file" ]; then
        mv "$old_file" "$old_file-$timestamp"
        echo "backup file: $old_file-$timestamp"
    fi

    ln -s "$(realpath "$new_file")" "$old_file"
    echo "file linked: $old_file -> $new_file"
}

# Link config files
read -p "backup and symlink config files? [y/n]: " choice
if [[ $choice == [yY] ]]; then
    try_create_symlink "$HOME/.bashrc" "bashrc"
    try_create_symlink "$HOME/.vimrc" "vimrc"
    try_create_symlink "$HOME/.tmux.conf" "tmux.conf"
fi

