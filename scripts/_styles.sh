#!/bin/zsh
# ---------------------------------------------------------------------------
# Shared configuration (override via environment variables if desired)
# ---------------------------------------------------------------------------
export CODING_ROOT="${CODING_ROOT:-$HOME/Desktop/coding}"
export GITHUB_USER="${GITHUB_USER:-cunhanina}"
export WEATHER_CITY="${WEATHER_CITY:-Curitiba}"
export NOTES_FILE="${NOTES_FILE:-$HOME/Desktop/notes.md}"
export JOURNAL_FILE="${JOURNAL_FILE:-$HOME/Desktop/journal.md}"

# ---------------------------------------------------------------------------
# Colors - simplified to avoid weird rendering
# ---------------------------------------------------------------------------
if [[ -t 1 ]] && command -v tput &>/dev/null; then
    BOLD=$(tput bold)
    DIM=$(tput dim)
    RESET=$(tput sgr0)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    CYAN=$(tput setaf 6)
    RED=$(tput setaf 1)
    MAGENTA=$(tput setaf 5)
else
    BOLD="" DIM="" RESET="" GREEN="" YELLOW="" BLUE="" CYAN="" RED="" MAGENTA=""
fi

# Headers (Cyan and Bold)
header() { echo -e "\n${BOLD}${CYAN}➜ $1${RESET}"; }

# Rows (Clean, no dimming to avoid dotted lines)
row() { printf "  %-20s %s\n" "$1" "$2"; }

# Status messages
ok() { echo -e "  ${GREEN}✔${RESET} $1"; }
warn() { echo -e "  ${YELLOW}${RESET} $1"; }
err() { echo -e "  ${RED}✖${RESET} $1"; }

# Info (Blue "i" icon)
info() { echo -e "  ${BLUE}ℹ️${RESET}  $1"; }

# Step (Magenta arrow)
step() { echo -e "  ${MAGENTA}➜${RESET} $1"; }

