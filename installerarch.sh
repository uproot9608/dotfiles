#!/bin/bash 

if [[ "$(uname)" == "Linux" ]]; then 
    echo "Installing packges"
    sudo pacman -Suy
    sudo pacman -S --needed - < $(pwd)/pacman
fi

DOTS_HOME="${HOME}/repos/dotfiles"
if [[ ! -d "$DOTS_HOME" ]]; then
    echo "Dotfiles not found. Cloning..."
    git clone https://github.com/uproot9608/dotfiles.git $DOTS_HOME
fi

source ${DOTS_HOME}/.zprofile

ln -s ${DOTS_HOME}/.zprofile ${HOME}/.zprofile
stow -d ${DOTS_HOME}

if [[ "$SHELL" == "/bin/zsh" ]]; then 
    echo "Zsh is your default shell"
else
    chsh -s $(which zsh) $USER
fi

