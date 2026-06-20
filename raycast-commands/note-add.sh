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
