#!/usr/bin/env bash

# Copied from https://github.com/linkarzu/dotfiles-latest/blob/main/scripts/macos/mac/misc/300-dailyNote.sh
# and modified to my own need

obsidian_vault_dir=~/GitHub/jcdiv47.github.io/content
daily_note_dir="${obsidian_vault_dir}/daily\ notes"
tmux_session_name="daily notes"

# Get current date components
current_year=$(date +"%Y")
current_month_num=$(date +"%m")
current_month_abbr=$(date +"%b")
current_day=$(date +"%d")
current_weekday=$(date +"%A")
current_datetime=$(date +'%Y-%m-%dT%H:%M:%S+08:00')

note_name=${current_year}-${current_month_num}-${current_day}
full_path=${daily_note_dir}/${note_name}.md

# Check if the directory exists, if not, create it
if [ ! -d "$daily_note_dir" ]; then
  mkdir -p "$daily_note_dir"
fi

# Create the daily note if it does not already exist
if [ ! -f "$full_path" ]; then
  cat <<EOF >"$full_path"
---
title: ${note_name}
created: ${current_datetime}
modified: ${current_datetime}
---

EOF
fi

# Check if the dedicated daily notes tmux session already exists
if ! tmux has-session -t="$tmux_session_name" 2>/dev/null; then
  # Create a dedicated daily notes tmux session in detached mode and
  # start neovim with the daily note, cursor at the last line
  tmux new-session -d -s "$tmux_session_name"
fi

# Check if neovim is running, if not open it
if ! tmux list-panes -t "$tmux_session_name" -F "#{pane_current_command}" | grep -q "nvim"; then
  tmux send-keys -t "$tmux_session_name" "nvim +norm\ G $full_path" C-m
fi

# Switch to the tmux session with the note name
tmux switch-client -t "$tmux_session_name"
