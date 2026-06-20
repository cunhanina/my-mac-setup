#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Morning
# @raycast.mode fullOutput
# @raycast.icon 🌅
# @raycast.packageName Workflow
# @raycast.argument1 { "type": "dropdown", "title": "Mode", "placeholder": "full", "data": [{"title": "Full", "value": "full"}, {"title": "Quick", "value": "quick"}], "optional": true }
[[ "${1}" == "quick" ]] && "$HOME/bin/morning" --quick || "$HOME/bin/morning"
