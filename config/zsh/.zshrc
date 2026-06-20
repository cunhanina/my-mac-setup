# Powerful but minimal zsh configuration
# Author: Nina Silva Cunha
# GitHub: https://github.com/cunhanina/my-mac-setup
#
# Uses:
#   Plugins:      git, fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    uv, eza, bat, gh, ripgrep
#   Editor:       VS Code
#   Python:       uv

# =========================================================
# Force XDG Base Directory Specification
# =========================================================
export ZDOTDIR="$HOME/.config/zsh"
export ZCOMPDUMP="$ZDOTDIR/.zcompdump"

# =========================================================
# Homebrew Path (Must be at the top)
# =========================================================

eval "$(/opt/homebrew/bin/brew shellenv)"

# =========================================================
# Default Editor Setup
# =========================================================

export EDITOR="code -w"
export VISUAL="code -w"

# =========================================================
# Oh My Zsh Setup
# =========================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git fast-syntax-highlighting zsh-autosuggestions zsh-history-substring-search zsh-vi-mode)
source $ZSH/oh-my-zsh.sh

# =========================================================
# eza Colors (256-Color Cyberpunk Theme)
# =========================================================

# Pink (213): Directories & Write Permissions
# Blue (117): Dates, Size Numbers & Read Permissions
# Purple (141): Users, Size Units & Execute Permissions
# Muted (61): Dashes and Punctuation
export EZA_COLORS="di=38;5;213:fi=38;5;253:da=38;5;117:uu=38;5;141:gu=38;5;141:sn=38;5;117:sb=38;5;141:ur=38;5;117:uw=38;5;213:ux=38;5;141:ue=38;5;141:gr=38;5;117:gw=38;5;213:gx=38;5;141:tr=38;5;117:tw=38;5;213:tx=38;5;141:xx=38;5;61"

# =========================================================
# History
# =========================================================

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# =========================================================
# Completion & Navigation
# =========================================================

eval "$(zoxide init zsh)"

# Load completion system
autoload -Uz compinit
compinit -d "$ZCOMPDUMP"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# =========================================================
# Fuzzy finder (macOS Apple Silicon & Intel)
# =========================================================

if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi

# =========================================================
# Python / uv
# =========================================================

export PATH="$HOME/.cargo/bin:$PATH"

# =========================================================
# Load Custom Configurations (MUST BE LAST)
# =========================================================

# Starship is initialized in prompt.zsh — do NOT add it here.
for config_file in "$ZDOTDIR"/*.zsh; do
    if [[ -f "$config_file" ]]; then
        source "$config_file"
    fi
done
