# XDG base config 
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_RUNTIME_DIR=/run/user/"$UID"

# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ ! -d "$HOME/.local/bin" ]] then
    mkdir $HOME/.local/bin
fi

export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
ZDOTDIR=${XDG_CONFIG_HOME:-$"HOME/.config"}/zsh

export LESSHISTFILE="-"

# Disable Apple's "save/restore shell state" feature.
if [[ "$(uname)" == "Darwin" ]]; then
   SHELL_SESSIONS_DISABLE=1
   # export SHELL_SESSIONS_DISABLE=1 ????
fi
