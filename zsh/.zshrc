ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Prompt configuration
OHMYPOSH_CONFIG="$XDG_CONFIG_HOME/ohmyposh/config.toml"
# Download oh-my-posh config, if it's not there yet
if [ ! -f "$OHMYPOSH_CONFIG" ]; then
   echo "Oh-my-posh config not found. Creating one..."
   mkdir -p "$(dirname $OHMYPOSH_CONFIG)"
   curl -s -o "$OHMYPOSH_CONFIG" https://raw.githubusercontent.com/uproot9608/dotfiles/refs/heads/main/ohmyposh/config.toml
fi

# Standard terminal has issues displaying the ANSI characters correctly
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $OHMYPOSH_CONFIG)"
fi

# Emacs mode 
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE="${XDG_STATE_HOME}"/zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Show hidden files and directories
setopt globdots
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# fzf completions
if (( $+commands[fzf] )); then
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
fi
# zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# TODO rework 
export LANG=en_US.UTF-8
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
# zshenv?
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
# not working
export HOMEBREW_CASK_OPTS=--no-quarantine 

# somenitelno no ok
# export SSH_AUTH_SOCK=${HOME}/.bitwarden-ssh-agent.sock
if [ -S "${HOME}/.bitwarden-ssh-agent.sock" ]; then
  export SSH_AUTH_SOCK=$HOME/.bitwarden-ssh-agent.sock
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

alias c=clear
alias k=kubectl
alias cat=bat
alias ls=eza
alias ll="eza -lAh --git"
alias lg=lazygit
alias dump="brew bundle dump --global --force"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
ff (){
    cd ${HOME}/repos/$(ls -A ${HOME}/repos | fzf) && ll
}

if [[ "$(uname)" == "Darwin" ]]; then
    alias sha256sum="shasum -a 256" 
fi

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
