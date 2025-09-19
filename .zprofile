# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# XDG base config 
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_RUNTIME_DIR=/run/user/"$UID"


export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOPATH/bin
ZDOTDIR=${XDG_CONFIG_HOME:-$"HOME/.config"}/zsh

export LESSHISTFILE="-"
