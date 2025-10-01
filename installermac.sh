#!/bin/bash

# install package manager fot macos
if [[ "$(uname)" == "Darwin" ]]; then

    echo "macOS deteted..."

	# Install xcode cli tools 
    if xcode-select -p &>/dev/null; then
        echo "Xcode already installed"
    else
        echo "Installing commandline tools..."
        xcode-select --install
    fi

	# install homebrew
	if brew -p &>/dev/null; then 
        echo "Homebrew already installed"
    else
		echo "Installing homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew analytics off
	fi
fi


# MacOS settings
echo "Changing macOS defaults..."

# Clone dotfiles repository
if [ ! -d "$HOME/repos/dotfiles" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/Sin-cy/dotfiles.git $HOME/dotfiles
fi

brew install stow 
# Stow dotfiles packages
echo "Stowing dotfiles..."
stow -t ~ aerospace karabiner neovim starship wezterm tmux zsh

echo "Dotfiles setup complete!"

# install 
brew bundle install --global
pacman -S --needed - < pacman
