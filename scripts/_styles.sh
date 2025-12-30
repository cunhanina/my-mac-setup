#!/bin/zsh
# Colors - simplified to avoid weird rendering
BOLD=$(tput bold)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
MAGENTA=$(tput setaf 5)

# Headers (Cyan and Bold)
header() { echo -e "\n${BOLD}${CYAN}➜ $1${RESET}"; }

# Rows (Clean, no dimming to avoid dotted lines)
row() { printf "  %-20s %s\n" "$1" "$2"; }

# Status messages
ok() { echo -e "  ${GREEN}✔${RESET} $1"; }
warn() { echo -e "  ${YELLOW}${RESET} $1"; }
err() { echo -e "  ${RED}✖${RESET} $1"; }

# NEW: Info (Blue "i" icon)
info() { echo -e "  ${BLUE}ℹ️${RESET}  $1"; }

# NEW: Step (Magenta arrow)
step() { echo -e "  ${MAGENTA}➜${RESET} $1"; }
