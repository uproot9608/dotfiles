# ------------------------------------------------------------------------------
# 1. XDG Base Directory Specification
# ------------------------------------------------------------------------------
# Defining these first so subsequent variables can use them
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# macOS-friendly Runtime Directory (Standardized across OSs)
if [[ "$(uname)" == "Darwin" ]]; then
    export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$(getconf DARWIN_USER_TEMP_DIR)}"
else
    export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$UID}"
fi

# Move Zsh dotfiles into the XDG structure
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# ------------------------------------------------------------------------------
# 2. Tool-Specific XDG Compliance (The "Fix-it" Section)
# ------------------------------------------------------------------------------
export GOPATH="$XDG_DATA_HOME/go"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# Preview files in fzf using bat
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# ------------------------------------------------------------------------------
# 3. System Environment & Pathing
# ------------------------------------------------------------------------------
export LANG="en_US.UTF-8"

# Homebrew setup (Apple Silicon path)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prevent duplicate entries in PATH
typeset -U path

# Prepend custom bins and homebrew to prioritize them
path=(
    "$HOME/.local/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "$GOPATH/bin"
    $path
)
export PATH

# ------------------------------------------------------------------------------
# 4. macOS Specific Fixes
# ------------------------------------------------------------------------------
if [[ "$(uname)" == "Darwin" ]]; then
    # Stops macOS from creating .zsh_sessions in your $HOME folder
    export SHELL_SESSIONS_DISABLE=1
fi
