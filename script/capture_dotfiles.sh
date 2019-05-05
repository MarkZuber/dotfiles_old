#!/bin/bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

to_capture=(
    ".conkyrc"
    ".dircolors" 
    ".editorconfig"
    ".hyper.js"
    ".zshrc"
    ".tmux.conf"
)

to_capture_add_extension=(
    ".gitconfig"
    ".gitignore"
)

custom_extension=".ext"

# Use filename as program name
prog=${0##*/}

# Text color variables
bldblu='\e[1;34m'         # blue
bldred='\e[1;31m'         # red
bldwht='\e[1;37m'         # white
txtcyn='\e[0;36m'         # cyan
txtund=$(tput sgr 0 1)    # underline
txtrst='\e[0m'            # text reset
info=${bldwht}*${txtrst}
pass=${bldblu}*${txtrst}
warn=${bldred}!${txtrst}

case $1 in
  b )   # Capture dotfiles from home dir and put into repo
        echo -e "$pass Capturing user dotfiles into repo."
        for dotfile in "${to_capture[@]}"
        do
            echo ~/$dotfile $DOTFILES_ROOT/dotfiles/$dotfile
            cp ~/$dotfile $DOTFILES_ROOT/dotfiles/$dotfile            
        done
        for dotfile in "${to_capture_add_extension[@]}"
        do
            echo ~/$dotfile $DOTFILES_ROOT/dotfiles/$dotfile$custom_extension
            # cp ~/$dotfile $DOTFILES_ROOT/dotfiles/$dotfile$custom_extension            
        done
        ;;
  r )   # Backup existing dotfiles and copy from repo
        echo -e "$pass Backing up existing dotfiles"
        mkdir ~/.dotfiles_backup
        for dotfile in "${to_capture[@]}"
        do
            echo ~/$dotfile ~/.dotfiles_backup/$dotfile
            cp ~/$dotfile ~/.dotfiles_backup/$dotfile
        done
        for dotfile in "${to_capture_add_extension[@]}"
        do
            echo ~/$dotfile ~/.dotfiles_backup/$dotfile
            cp ~/$dotfile ~/.dotfiles_backup/$dotfile
        done

        echo -e "$pass Copying dotfiles from repo to user dir"
        for dotfile in "${to_capture[@]}"
        do
            echo $DOTFILES_ROOT/dotfiles/$dotfile ~/$dotfile
            rm ~/$dotfile
            cp $DOTFILES_ROOT/dotfiles/$dotfile ~/$dotfile
        done
        for dotfile in "${to_capture_add_extension[@]}"
        do
            echo $DOTFILES_ROOT/dotfiles/$dotfile$custom_extension ~/$dotfile
            rm ~/$dotfile
            cp $DOTFILES_ROOT/dotfiles/$dotfile$custom_extension ~/$dotfile
        done
        ;;
  * ) echo -e " ${prog} b - capture dot files from homedir into repo."
      echo -e " ${prog} r - backup existing dotfiles and replace with repo contents." ;;
esac
