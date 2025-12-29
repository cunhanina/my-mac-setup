#!/bin/zsh
source ./scripts/_styles.sh

header "🔗 LINKING MAC SETUP..."

# 1. Get the absolute path of the repo
REPO_DIR=$(pwd)

# 2. Link Scripts (Force create links)
# We loop through them to ensure they link correctly
for script in "$REPO_DIR/scripts/"*; do
    name=$(basename "$script")
    ln -sf "$script" "$HOME/bin/$name"
done

ok "Scripts linked: Repo -> ~/bin"

# 3. Setup Zsh Config
if ! grep -q "pj()" ~/.zshrc; then
    echo 'export PATH="$HOME/bin:$HOME/.local/bin:$PATH"' >> ~/.zshrc
    echo 'pj() { cd "$($HOME/bin/pj $@)" }' >> ~/.zshrc
    ok "Config added to .zshrc"
fi

# 4. Install dependencies
if ! command -v uv &>/dev/null; then
    warn "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

ok "SETUP COMPLETE! Your edits are now live."
