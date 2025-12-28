#!/bin/zsh

echo "🚀 STARTING MAC SETUP..."

# 1. Setup Bin
mkdir -p ~/bin
cp ./scripts/* ~/bin/
chmod +x ~/bin/*
echo "✅ Scripts installed to ~/bin"

# 2. Setup Zsh Config
if ! grep -q "pj()" ~/.zshrc; then
    echo 'export PATH="$HOME/bin:$HOME/.local/bin:$PATH"' >> ~/.zshrc
    echo 'pj() { cd "$($HOME/bin/pj $@)" }' >> ~/.zshrc
    echo "✅ Config added to .zshrc"
fi

# 3. Install dependencies
if ! command -v uv &>/dev/null; then
    echo "📦 Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

echo "🎉 SETUP COMPLETE! Restart your terminal."
