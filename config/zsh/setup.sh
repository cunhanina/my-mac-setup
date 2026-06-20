#!/bin/zsh
# setup.sh — one-shot dotfiles + Raycast migration
# Usage: cd /path/to/my-mac-setup && zsh setup.sh

# =========================================================
# Inline styles — no external source dependency
# =========================================================

BOLD=$(tput bold 2>/dev/null || echo '')
RESET=$(tput sgr0 2>/dev/null || echo '')
GREEN=$(tput setaf 2 2>/dev/null || echo '')
YELLOW=$(tput setaf 3 2>/dev/null || echo '')
CYAN=$(tput setaf 6 2>/dev/null || echo '')
RED=$(tput setaf 1 2>/dev/null || echo '')

header() { echo "\n${BOLD}${CYAN}➜ $1${RESET}"; }
ok()     { echo "  ${GREEN}✔${RESET} $1"; }
warn()   { echo "  ${YELLOW}!${RESET} $1"; }
err()    { echo "  ${RED}✖${RESET} $1"; }
info()   { echo "  · $1"; }

# =========================================================
# Resolve repo root — works regardless of how you call it
# =========================================================

REPO_ROOT="$(cd "$(dirname "${(%):-%x}")" && pwd)"

# Fallback: if the above gives a temp path (piped execution), use git
if [[ ! -f "$REPO_ROOT/scripts/_styles.sh" ]]; then
    REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
fi

if [[ ! -f "$REPO_ROOT/scripts/_styles.sh" ]]; then
    echo "✖ Run this from inside the my-mac-setup repo."
    exit 1
fi

echo ""
echo "${BOLD}${CYAN}  ⚡ dotfiles setup — starting${RESET}"
echo "  Repo: $REPO_ROOT"
echo ""

# =========================================================
# 1. CLEANUP — remove scripts replaced by Raycast
# =========================================================

header "Step 1/5 — Removing replaced scripts"

_remove() {
    local path="$REPO_ROOT/$1"
    if [[ -e "$path" ]]; then
        rm -rf "$path"
        ok "Removed $1"
    else
        info "(skip) $1 — not found"
    fi
}

_remove "scripts/organize"
_remove "scripts/screenshot_mover.py"
_remove "scripts/com.maxykoin.organize.plist"
_remove "scripts/com.maxykoin.screenshot-mover.plist"
_remove "scripts/install-organize-plist"
_remove "scripts/dupes"
_remove "scripts/ports"
_remove "scripts/pj"

# Unload launchd agents
for label in com.maxykoin.organize com.maxykoin.screenshot-mover; do
    plist="$HOME/Library/LaunchAgents/${label}.plist"
    if launchctl list "$label" &>/dev/null; then
        launchctl unload "$plist" 2>/dev/null
        rm -f "$plist"
        ok "Unloaded + deleted launchd: $label"
    else
        info "(skip) launchd $label — not loaded"
    fi
done

# Remove stale symlinks from ~/bin
for name in organize screenshot_mover.py dupes ports pj install-organize-plist; do
    link="$HOME/bin/$name"
    if [[ -L "$link" ]]; then
        rm "$link"
        ok "Removed ~/bin/$name"
    fi
done

# Remove pj() shim from ~/.zshrc if present
if grep -q "pj()" "$HOME/.zshrc" 2>/dev/null; then
    sed -i '' "/pj()/d" "$HOME/.zshrc"
    ok "Removed pj() shim from ~/.zshrc"
fi

# =========================================================
# 2. SCREENSHOTS — macOS native path, no daemon
# =========================================================

header "Step 2/5 — Redirecting screenshots"

mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location "$HOME/Screenshots"
killall SystemUIServer 2>/dev/null || true
ok "Screenshots → ~/Screenshots (macOS native, no script needed)"

# =========================================================
# 3. PATCH REPO FILES
# =========================================================

header "Step 3/5 — Patching repo files"

# --- install.sh ---
cat > "$REPO_ROOT/install.sh" << 'INSTALL'
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
INSTALL
chmod +x "$REPO_ROOT/install.sh"
ok "Patched install.sh"

# --- .zshrc: remove duplicate starship init ---
ZSHRC="$REPO_ROOT/config/zsh/.zshrc"
if [[ -f "$ZSHRC" ]]; then
    # Remove the standalone eval + STARSHIP_CONFIG lines that duplicate prompt.zsh
    sed -i '' \
        -e '/^export STARSHIP_CONFIG="\$ZDOTDIR\/starship\.toml"$/d' \
        -e '/^eval "\$(starship init zsh)"$/d' \
        "$ZSHRC"
    ok "Removed duplicate starship init from config/zsh/.zshrc"
fi

# Same fix for the copy at config/.zshrc if it exists
ZSHRC2="$REPO_ROOT/config/.zshrc"
if [[ -f "$ZSHRC2" ]]; then
    sed -i '' \
        -e '/^export STARSHIP_CONFIG="\$ZDOTDIR\/starship\.toml"$/d' \
        -e '/^eval "\$(starship init zsh)"$/d' \
        "$ZSHRC2"
    ok "Removed duplicate starship init from config/.zshrc"
fi

# =========================================================
# 4. RAYCAST COMMANDS
# =========================================================

header "Step 4/5 — Writing Raycast script commands"

RC_DIR="$REPO_ROOT/raycast-commands"
mkdir -p "$RC_DIR"

# health — delegates to ~/bin/health
cat > "$RC_DIR/health.sh" << 'RCHEALTH'
#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Health
# @raycast.mode fullOutput
# @raycast.icon 🖥️
# @raycast.packageName System
"$HOME/bin/health"
RCHEALTH

# morning — delegates to ~/bin/morning
cat > "$RC_DIR/morning.sh" << 'RCMORNING'
#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Morning
# @raycast.mode fullOutput
# @raycast.icon 🌅
# @raycast.packageName Workflow
# @raycast.argument1 { "type": "dropdown", "title": "Mode", "placeholder": "full", "data": [{"title": "Full", "value": "full"}, {"title": "Quick", "value": "quick"}], "optional": true }
[[ "${1}" == "quick" ]] && "$HOME/bin/morning" --quick || "$HOME/bin/morning"
RCMORNING

# clean-system — DNS flush + purge + brew (no interactive prompt, safe for Raycast)
cat > "$RC_DIR/clean-system.sh" << 'RCCLEAN'
#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Clean System
# @raycast.mode fullOutput
# @raycast.icon 🧹
# @raycast.packageName System
BOLD=$(tput bold); RESET=$(tput sgr0); GREEN=$(tput setaf 2); CYAN=$(tput setaf 6)
header() { echo "\n${BOLD}${CYAN}➜ $1${RESET}"; }
ok()     { echo "  ${GREEN}✔${RESET} $1"; }
header "System Maintenance"
echo "  Flushing DNS..."
sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder
echo "  Purging inactive memory..."
sudo purge
if command -v brew &>/dev/null; then
    echo "  Cleaning Homebrew..."
    brew cleanup -s &>/dev/null
fi
ok "Done."
RCCLEAN

# week — delegates to ~/bin/week
cat > "$RC_DIR/week.sh" << 'RCWEEK'
#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Week
# @raycast.mode fullOutput
# @raycast.icon 📊
# @raycast.packageName Workflow
# @raycast.argument1 { "type": "dropdown", "title": "Period", "placeholder": "this week", "data": [{"title": "This week", "value": "this"}, {"title": "Last week", "value": "last"}], "optional": true }
[[ "${1}" == "last" ]] && "$HOME/bin/week" last || "$HOME/bin/week"
RCWEEK

# note-add — appends to global notes.md
cat > "$RC_DIR/note-add.sh" << 'RCNOTE'
#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Note Add
# @raycast.mode silent
# @raycast.icon 📝
# @raycast.packageName Workflow
# @raycast.argument1 { "type": "text", "title": "Task", "placeholder": "what to add..." }
NOTES_FILE="$HOME/Desktop/notes.md"
touch "$NOTES_FILE"
echo "- [ ] ${1}" >> "$NOTES_FILE"
echo "Added: ${1}"
RCNOTE

chmod +x "$RC_DIR"/*.sh
ok "5 script commands written to raycast-commands/"

# Symlink into Raycast's watched scripts directory
RC_LINK="$HOME/.config/raycast/scripts"
mkdir -p "$(dirname "$RC_LINK")"

if [[ ! -e "$RC_LINK" ]]; then
    ln -sf "$RC_DIR" "$RC_LINK"
    ok "Symlinked raycast-commands/ → ~/.config/raycast/scripts"
elif [[ -L "$RC_LINK" && "$(readlink "$RC_LINK")" == "$RC_DIR" ]]; then
    info "Symlink already correct — skipping"
elif [[ -L "$RC_LINK" ]]; then
    warn "~/.config/raycast/scripts points elsewhere: $(readlink "$RC_LINK")"
    warn "In Raycast → Settings → Extensions → Script Commands → add: $RC_DIR"
else
    warn "~/.config/raycast/scripts is a real directory (not a symlink)."
    warn "In Raycast → Settings → Extensions → Script Commands → add: $RC_DIR"
fi

# =========================================================
# 5. LINK SCRIPTS TO ~/bin
# =========================================================

header "Step 5/5 — Linking scripts to ~/bin"

mkdir -p "$HOME/bin"

SKIP=(
    organize screenshot_mover.py
    com.maxykoin.organize.plist com.maxykoin.screenshot-mover.plist
    install-organize-plist dupes ports pj _styles.sh
)

for script in "$REPO_ROOT/scripts/"*; do
    [[ -f "$script" ]] || continue
    name=$(basename "$script")
    skip=false
    for s in "${SKIP[@]}"; do
        [[ "$name" == "$s" ]] && skip=true && break
    done
    $skip && continue
    ln -sf "$script" "$HOME/bin/$name"
done

export PATH="$HOME/bin:$PATH"
ok "Scripts linked."

# =========================================================
# DONE
# =========================================================

echo ""
echo "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo "${BOLD}  ✔ Done.${RESET}"
echo ""
echo "  Removed   : organize, screenshot_mover, dupes, ports, pj, 2× plists"
echo "  Patched   : install.sh  .zshrc (×2)  (starship double-init fixed)"
echo "  Created   : raycast-commands/ (5 scripts)"
echo "  Linked    : ~/bin/* (remaining scripts)"
echo "  macOS     : screenshots → ~/Screenshots"
echo ""
echo "${BOLD}  Raycast — 2 manual steps left:${RESET}"
echo ""
echo "  1. Open Raycast → Settings → Extensions → Script Commands"
echo "     The 'raycast-commands/' folder should already be listed."
echo "     If not: click '+' → Add Directories → $REPO_ROOT/raycast-commands"
echo ""
echo "  2. Raycast Store — install:"
echo "     • Project Manager    (set root: ~/Desktop/coding)"
echo "     • Port Manager"
echo "     • Duplicate File Finder"
echo "     • File Organizer"
echo ""
echo "  3. Settings → Extensions → enable built-ins:"
echo "     • Clipboard History  (⌘⇧V)"
echo "     • Window Management"
echo "     • Snippets"
echo ""
echo "  git add -A && git commit -m 'chore: Raycast migration + fixes'"
echo "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
