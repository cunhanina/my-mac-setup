#!/bin/zsh
# FIX: derive SCRIPT_DIR from the script's own location, not from pwd.
# Previously `source ./scripts/_styles.sh` and `REPO_DIR=$(pwd)` only worked
# if you ran install.sh from the repo root — any other directory broke silently.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/scripts/_styles.sh"

header "🔗 LINKING MAC SETUP..."

REPO_DIR="$SCRIPT_DIR"

# 1. Link scripts (force-create symlinks so re-runs are safe)
for script in "$REPO_DIR/scripts/"*; do
    name=$(basename "$script")
    ln -sf "$script" "$HOME/bin/$name"
done

ok "Scripts linked: Repo → ~/bin"

# 2. Setup Zsh config
if ! grep -q "pj()" ~/.zshrc; then
    echo 'export PATH="$HOME/bin:$HOME/.local/bin:$PATH"' >> ~/.zshrc
    echo 'pj() { cd "$($HOME/bin/pj $@)" }' >> ~/.zshrc
    ok "Config added to .zshrc"
else
    info "Zsh config already patched — skipping."
fi

# 3. Install dependencies
if ! command -v uv &>/dev/null; then
    warn "uv not found — installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    info "uv already installed — skipping."
fi

ok "SETUP COMPLETE! Your edits are now live."


