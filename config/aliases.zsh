# Better ls
alias ls='eza --icons'

# Detailed listing (forces Oh My Zsh defaults to drop)
unalias ll 2>/dev/null
alias ll='eza -lh --icons --git'

# Detailed listing including hidden files
unalias la 2>/dev/null
alias la='eza -lah --icons --git'

# Tree view
alias tree='eza --tree --icons'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# =========================================================
# Git & Setup
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='cd "${CODING_ROOT:-$HOME/Desktop/coding}/shell/my-mac-setup"'

# =========================================================
# Python / Workflow
# =========================================================

# Must stay an alias so `source .venv/bin/activate` runs in the current shell
alias use='source "$HOME/bin/_use.sh"'

# Interactive project jumper: `pj` cd's in current shell; `pj -t` opens iTerm tab; `pj -c` opens VS Code
pj() {
    if [[ "$1" == "-t" || "$1" == "--tab" || "$1" == "-c" || "$1" == "--code" || "$1" == "-h" || "$1" == "--help" ]]; then
        "$HOME/bin/pj" "$@"
    else
        local dir
        dir=$("$HOME/bin/pj" --print "$@")
        [[ -n "$dir" && -d "$dir" ]] && cd "$dir"
    fi
}

