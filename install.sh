#!/bin/zsh
SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
source "$SCRIPT_DIR/scripts/_styles.sh"

header "LINKING MAC SETUP..."

# --- 1. Scripts → ~/bin -----------------------------------------------

mkdir -p "$HOME/bin"

# _styles.sh and _use.sh are sourced dependencies, not standalone commands:
# - _styles.sh is sourced by all scripts at $HOME/bin/_styles.sh
# - _use.sh is sourced via `alias use='source "$HOME/bin/_use.sh"'` in aliases.zsh
ln -sf "$SCRIPT_DIR/scripts/_styles.sh" "$HOME/bin/_styles.sh"
ln -sf "$SCRIPT_DIR/scripts/use" "$HOME/bin/_use.sh"

# Remove legacy/broken symlinks if present
rm -f "$HOME/bin/use" "$HOME/bin/"*.plist 2>/dev/null

SKIP=(_styles.sh use)

for script in "$SCRIPT_DIR/scripts/"*; do
    name=$(basename "$script")
    [[ "$name" == *.plist ]] && continue
    skip=false
    for s in "${SKIP[@]}"; do
        [[ "$name" == "$s" ]] && skip=true && break
    done
    if $skip; then
        continue
    fi
    chmod +x "$script"
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

# --- 3. VS Code Settings -------------------------------------------------

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if [[ -f "$SCRIPT_DIR/vscode/settings.json" ]]; then
    mkdir -p "$VSCODE_USER_DIR"
    ln -sf "$SCRIPT_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    ok "VS Code settings linked → $VSCODE_USER_DIR/settings.json"
fi

# --- 4. macOS Screenshot Location ----------------------------------------

mkdir -p "$HOME/Screenshots"
CURRENT_SS_LOC=$(defaults read com.apple.screencapture location 2>/dev/null || echo "")
if [[ "$CURRENT_SS_LOC" != "$HOME/Screenshots" ]]; then
    defaults write com.apple.screencapture location "$HOME/Screenshots"
    killall SystemUIServer 2>/dev/null || true
    ok "Screenshots redirected → ~/Screenshots (native macOS setting)"
else
    info "Screenshots already set to ~/Screenshots — skipping"
fi

# --- 5. Toolchains & Dependencies ----------------------------------------

if [[ "$1" == "--bundle" || "$1" == "--deps" ]] && command -v brew &>/dev/null && [[ -f "$SCRIPT_DIR/Brewfile" ]]; then
    step "Installing Homebrew bundle from Brewfile..."
    brew bundle --file="$SCRIPT_DIR/Brewfile"
    ok "Brewfile dependencies installed"
fi

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