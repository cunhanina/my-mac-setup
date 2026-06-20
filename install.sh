#!/bin/zsh
SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
source "$SCRIPT_DIR/scripts/_styles.sh"

header "LINKING MAC SETUP..."

SKIP=(
    organize screenshot_mover.py
    com.maxykoin.organize.plist com.maxykoin.screenshot-mover.plist
    install-organize-plist dupes ports pj _styles.sh
)

mkdir -p "$HOME/bin"

for script in "$SCRIPT_DIR/scripts/"*; do
    name=$(basename "$script")
    skip=false
    for s in "${SKIP[@]}"; do
        [[ "$name" == "$s" ]] && skip=true && break
    done
    if $skip; then
        info "Skipping $name (replaced by Raycast)"
        continue
    fi
    ln -sf "$script" "$HOME/bin/$name"
done

ok "Scripts linked → ~/bin"

if ! grep -q 'HOME/bin' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/bin:$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    ok "PATH added to .zshrc"
else
    info "PATH already in .zshrc — skipping"
fi

if ! command -v uv &>/dev/null; then
    warn "uv not found — installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    info "uv already installed — skipping"
fi

ok "SETUP COMPLETE!"
