#!/bin/zsh
SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
source "$SCRIPT_DIR/scripts/_styles.sh"

header "LINKING MAC SETUP..."

# --- 1. Scripts → ~/bin -----------------------------------------------

mkdir -p "$HOME/bin"

# _styles.sh is a sourced dependency, not a standalone command — but every
# other script resolves it at $HOME/bin/_styles.sh, so it must always be
# linked first, unconditionally, regardless of what gets skipped below.
ln -sf "$SCRIPT_DIR/scripts/_styles.sh" "$HOME/bin/_styles.sh"

# use must stay alias-only (config/aliases.zsh) — it calls `source
# .venv/bin/activate` + `return`, which only works sourced into the
# current shell, never as a symlinked subprocess.
SKIP=(_styles.sh use)

for script in "$SCRIPT_DIR/scripts/"*; do
    name=$(basename "$script")
    skip=false
    for s in "${SKIP[@]}"; do
        [[ "$name" == "$s" ]] && skip=true && break
    done
    if $skip; then
        continue
    fi
    ln -sf "$script" "$HOME/bin/$name"
done

ok "Scripts linked → ~/bin"

# --- 2. Zsh config → $ZDOTDIR (~/.config/zsh) ---------------------------
# This repo's shell config uses the ZDOTDIR pattern: ~/.zshenv (which zsh
# always reads first, from $HOME, before ZDOTDIR is known) sets
# ZDOTDIR=$HOME/.config/zsh, and every other rc file lives there instead
# of directly in $HOME. PATH (including ~/bin) is set inside
# config/.zshrc — not appended here — so it stays version-controlled.

if ! grep -q 'ZDOTDIR' "$HOME/.zshenv" 2>/dev/null; then
    echo 'export ZDOTDIR="$HOME/.config/zsh"' > "$HOME/.zshenv"
    ok "~/.zshenv created (sets ZDOTDIR)"
else
    info "~/.zshenv already sets ZDOTDIR — skipping"
fi

mkdir -p "$HOME/.config/zsh"

for f in .zprofile .zshenv .zshrc aliases.zsh bindings.zsh fzf.zsh plugins.zsh prompt.zsh starship.toml; do
    if [[ -f "$SCRIPT_DIR/config/$f" ]]; then
        ln -sf "$SCRIPT_DIR/config/$f" "$HOME/.config/zsh/$f"
    fi
done

ok "Zsh config linked → \$ZDOTDIR ($HOME/.config/zsh)"

# --- 3. Toolchains -------------------------------------------------------

if ! command -v uv &>/dev/null; then
    warn "uv not found — installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    info "uv already installed — skipping"
fi

if ! command -v go &>/dev/null; then
    warn "go not found — install with: brew install go"
else
    info "go already installed — skipping"
fi

ok "SETUP COMPLETE! Restart your terminal (or run: exec zsh)"