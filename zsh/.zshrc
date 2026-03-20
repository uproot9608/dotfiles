# ------------------------------------------------------------------------------
# 1. Plugin Manager (Zinit) Setup & Turbo Mode
# ------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   echo "🚀 Installing Zinit..."
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Fast-loading plugins (Immediate)
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Turbo-loaded plugins (Background load to prevent shell lag)
zinit wait'0' lucid for \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    blockf \
    zsh-users/zsh-syntax-highlighting

# ------------------------------------------------------------------------------
# 2. Completion System (XDG Compliant & Fast)
# ------------------------------------------------------------------------------
# Move zcompdump to Cache and only rebuild every 24h
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
mkdir -p "$(dirname "$ZSH_COMPDUMP")"

autoload -Uz compinit
if [[ -n "$ZSH_COMPDUMP"(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi
zinit cdreplay -q

# Completion Styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':completion:*' menu select # Use arrow keys to navigate completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# ------------------------------------------------------------------------------
# 3. Prompt (Oh-My-Posh)
# ------------------------------------------------------------------------------
OHMYPOSH_CONFIG="$XDG_CONFIG_HOME/ohmyposh/config.toml"

if [[ ! -f "$OHMYPOSH_CONFIG" ]]; then
   echo "📥 Fetching Oh-my-posh config..."
   mkdir -p "$(dirname $OHMYPOSH_CONFIG)"
   curl -s -o "$OHMYPOSH_CONFIG" https://raw.githubusercontent.com/uproot9608/dotfiles/refs/heads/main/ohmyposh/config.toml
fi

if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
  eval "$(oh-my-posh init zsh --config $OHMYPOSH_CONFIG)"
fi

# ------------------------------------------------------------------------------
# 4. History (XDG State Compliant)
# ------------------------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_STATE_HOME}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt SHARE_HISTORY          # Share history between tabs
setopt HIST_IGNORE_ALL_DUPS   # Don't record duplicates
setopt HIST_REDUCE_BLANKS     # Clean up whitespace
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt INC_APPEND_HISTORY     # Immediate append

# ------------------------------------------------------------------------------
# 5. Keybindings & Options
# ------------------------------------------------------------------------------
bindkey -e 
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

setopt globdots               # Show hidden files in globs
setopt AUTO_CD                # Just type a directory name to cd into it
setopt MENU_COMPLETE        # List completions on first tab press
setopt AUTO_LIST            # Automatically list choices on ambiguous completion
setopt COMPLETE_IN_WORD     # Complete from both ends of a word

# ------------------------------------------------------------------------------
# 6. Aliases & Functions
# ------------------------------------------------------------------------------
alias c='clear'
alias k='kubectl'
alias cat='bat'
alias ls='eza --icons'
alias ll='eza -lAh --git --icons'
alias lg='lazygit'
alias dump='brew bundle dump --global --force'
alias weather='curl wttr.in'
alias pb='pbcopy'
alias myip="curl -s https://ifconfig.me"

alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -p'

alias -g G='| grep --color=auto'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g B='| bat'

# Improved Repo Jumper
ff() {
    local repo_dir="${HOME}/repos"
    
    # 1. Safety check: does the directory even exist?
    if [[ ! -d "$repo_dir" ]]; then
        echo "❌ Directory $repo_dir not found."
        return 1
    fi

    local repo
    # 2. Use --preview-window=hidden or a custom eza preview to override the global bat preview
    repo=$(eza -1 "$repo_dir" | fzf \
        --height 40% \
        --reverse \
        --prompt="📁 Go to repo > " \
        --preview "eza -T -L 2 --color=always $repo_dir/{}" \
        --preview-window="right:50%:border-left")

    # 3. If a selection was made, jump and list
    if [[ -n "$repo" ]]; then
        cd "$repo_dir/$repo" && ll
    fi
}

# ------------------------------------------------------------------------------
# 7. Integrations & Auth (Sourced Last)
# ------------------------------------------------------------------------------
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Bitwarden SSH Agent check (Using -S for socket check)
if [[ -S "${HOME}/.bitwarden-ssh-agent.sock" ]]; then
  export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
fi
