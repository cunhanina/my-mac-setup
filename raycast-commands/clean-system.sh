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
