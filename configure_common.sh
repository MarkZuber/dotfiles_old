#!/bin/bash

# Installing git completion
echo ''
echo "Now installing git and bash-completion..."
sudo apt-get install git bash-completion -y

echo ''
echo "Now configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# oh-my-zsh install
if [ -d ~/.oh-my-zsh/ ] ; then
echo ''
echo "oh-my-zsh is already installed..."
read -p "Would you like to update oh-my-zsh now?" -n 1 -r
echo ''
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
    cd ~/.oh-my-zsh && git pull
        if [[ $? -eq 0 ]]
        then
            echo "Update complete..." && cd
        else
            echo "Update not complete..." >&2 cd
        fi
    fi
else
echo "oh-my-zsh not found, now installing oh-my-zsh..."
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
if ! [ -d ~/.oh-my-zsh/custom/plugins/zsh-completions/ ] ; then
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
fi

if ! [ -d ~/.zsh/zsh-autosuggestions/ ] ; then
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

if ! [ -d ~/.zsh/zsh-syntax-highlighting/ ] ; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

# powerlevel9k install
if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k/ ] ; then
    echo ''
    echo "Now installing powerlevel9k..."
    echo ''
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

# powerlevel10k install
if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k/ ] ; then
    echo ''
    echo "Now installing powerlevel10k..."
    echo ''
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Bash color scheme
echo ''
echo "Now installing solarized dark WSL color scheme..."
echo ''
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark ~/.dircolors

# Python updates
sudo pip install --upgrade pip
sudo pip install speedtest-cli



is_reboot_required=false

# Set default shell to zsh
if [ "$SHELL" == "/usr/bin/zsh" ]
then
    echo ''
    echo "Already running zsh"
else
    echo ''
    echo "Now setting default shell..."
    chsh -s $(which zsh)
    if [[ $? -eq 0 ]]
    then
        echo "Successfully set your default shell to zsh..."
        is_reboot_required=true
    else
        echo "Default shell not set successfully..." >&2
    fi
fi

echo ''
echo 'Installation completed!'

if [ "$is_reboot_required" = true ]
then
    echo "Please reboot your computer for changes to be made."
fi
