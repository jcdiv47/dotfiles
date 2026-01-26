#!/bin/bash
current=$(tmux display-message -p '#S')
sessions=$(tmux list-sessions -F '#S' | grep -v "^${current}$")

if [ -z "$sessions" ]; then
  echo "No other sessions available"
  sleep 1
  exit 0
fi

selected=$(echo "$sessions" | fzf --reverse)
[ -n "$selected" ] && tmux switch-client -t "$selected"
