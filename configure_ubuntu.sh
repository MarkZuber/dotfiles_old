#!/bin/bash

# Update pkg lists
echo "Updating package lists..."
sudo apt-get update

# zsh install
which zsh > /dev/null 2>&1
if [[ $? -eq 0 ]] ; then
echo ''
echo "zsh already installed..."
else
echo "zsh not found, now installing zsh..."
echo ''
sudo apt install zsh -y
fi

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    winbind \
    libnss-winbind \
    nodejs \
    npm \
    golang \
    default-jdk \
    screenfetch \
    x11-utils \
    cmake \
    ssh \
    openssh-server \
    dotnet-sdk-2.2 \
    mc \
    jq \
    tmux \
    python-pip


DOTFILES_ROOT=$HOME/repos/dotfiles

pushd $DOTFILES_ROOT > /dev/null && echo "switched to $DOTFILES_ROOT dir..."
echo ''
echo "Now configuring symlinks..." && $DOTFILES_ROOT/script/bootstrap
if [[ $? -eq 0 ]]
then
    echo "Successfully configured your environment.."
else
    echo "dotfiles were not applied successfully..." >&2
fi
popd > /dev/null


