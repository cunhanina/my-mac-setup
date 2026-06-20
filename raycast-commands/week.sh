#!/bin/zsh
# @raycast.schemaVersion 1
# @raycast.title Week
# @raycast.mode fullOutput
# @raycast.icon 📊
# @raycast.packageName Workflow
# @raycast.argument1 { "type": "dropdown", "title": "Period", "placeholder": "this week", "data": [{"title": "This week", "value": "this"}, {"title": "Last week", "value": "last"}], "optional": true }
[[ "${1}" == "last" ]] && "$HOME/bin/week" last || "$HOME/bin/week"
