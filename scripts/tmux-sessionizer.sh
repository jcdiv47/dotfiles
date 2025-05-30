#!/usr/bin/env bash

# Script to quickly open or switch to a tmux session associated with a project directory.
#
# Code borrowed from https://github.com/SylvanFranklin/.config/blob/fa225cba069330ac6b1820a3214041f5aed5ae1f/scripts/tmux-sessionizer.sh
# Docstrings and comments from Gemini-2.5-Pro
#
# Usage:
#   ./script_name.sh [path_to_project]
#
# If [path_to_project] is provided, it uses that directory.
# Otherwise, it launches a fuzzy finder (sk) to select a directory from
# a predefined list of search paths.
#
# It handles creating new tmux sessions or switching to existing ones.

# --- Configuration ---
# Define the base directories to search for projects.
# Add or remove paths as needed.
# Note: ~ will be expanded to the user's home directory.
SEARCH_PATHS=(
    ~/GitHub/
    ~
    ~/.config/
)
# --- End Configuration ---

# Variable to store the selected project directory path
selected=""

# Determine the project directory to use
if [[ $# -eq 1 ]]; then
    # If an argument is provided, use it as the selected path
    selected=$1
    # Basic validation: check if the provided path is a directory
    if [[ ! -d "$selected" ]]; then
        echo "Error: Provided path '$selected' is not a valid directory." >&2
        exit 1
    fi
else
    # No argument provided, so use fuzzy finder (sk) to select a directory
    # find: searches for directories (-type d) directly within the SEARCH_PATHS (-mindepth 1 -maxdepth 1)
    # sed: removes the $HOME/ prefix for a cleaner display in sk
    # sk: fuzzy finder to select a directory
    #   --margin 10%: adds a margin around the sk interface
    #   --color="bw": uses a black and white color scheme
    selected_path_suffix=$(find "${SEARCH_PATHS[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | \
        sed "s|^$HOME/||" | \
        sk --margin 10% --color="bw"
    )

    # If a directory was selected from sk (i.e., selected_path_suffix is not empty)
    if [[ -n "$selected_path_suffix" ]]; then
        # Prepend $HOME/ back to the selected path suffix to get the full path
        # This assumes paths selected are relative to $HOME after the sed command.
        # A more robust approach might be to store full paths and display shortened ones,
        # but this works for the original script's logic.
        # If the path doesn't start with one of the SEARCH_PATHS (e.g. selected from ~ directly),
        # we need to ensure it's correctly prefixed.
        # The original sed command only removes $HOME/, so this re-addition is generally correct.
        selected="$HOME/$selected_path_suffix"

        # A more robust way to reconstruct the full path if `sed` was more complex
        # or if paths didn't always start with $HOME/ would be to keep the full path
        # from `find` and only use `sed` for display purposes in `sk`.
        # However, for this specific script, the original logic is likely sufficient.
    fi
fi

# If no directory was selected (e.g., user pressed Esc in sk or provided invalid arg), exit
if [[ -z "$selected" ]]; then
    echo "No directory selected. Exiting."
    exit 0
fi

# Sanitize the selected directory name to be used as a tmux session name
# basename: get the last component of the path (directory name)
# tr: replace dots (.) with underscores (_) as dots can be problematic in tmux session names
selected_name=$(basename "$selected" | tr . _)

# Check if a tmux server is running
tmux_running=$(pgrep tmux)

# Scenario 1: Not currently inside a tmux session AND no tmux server is running
if [[ -z "$TMUX" ]] && [[ -z "$tmux_running" ]]; then
    echo "No TMUX session detected and no tmux server running. Starting new session."
    # Create a new tmux session, name it, and set its starting directory
    # This will also attach to the new session.
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0 # Script's job is done
fi

# Scenario 2: Tmux server is running or we are inside a tmux session

# Check if a tmux session with the derived name already exists
# `tmux has-session -t=SESSION_NAME` returns 0 if session exists, 1 otherwise.
# `2>/dev/null` suppresses "can't find session" error message if it doesn't exist.
if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    echo "Tmux session '$selected_name' does not exist. Creating it."
    # Create a new detached tmux session (-d)
    # -s: session name
    # -c: starting directory
    tmux new-session -ds "$selected_name" -c "$selected"

    # Optional: Select the first window of the newly created session.
    # Tmux window numbering can be 0-indexed or 1-indexed based on `base-index` setting.
    # This script assumes the first window can be targeted as `SESSION_NAME:1` or `SESSION_NAME:0`.
    # Using `tmux new-window` or simply letting tmux create the default window is also common.
    # The original script had `select-window -t $selected_name:1`.
    # If using default base-index 0, it should be $selected_name:0.
    # For simplicity and robustness if base-index is unknown, creating a named window
    # or just relying on the default window created by new-session is often sufficient.
    # If `new-session` creates a window (which it does), it's usually window 0 or 1.
    # Let's stick to the original intent if it's crucial.
    # We can try to select the first window. Tmux usually names it based on the program running or index.
    # It's generally safe to assume a window :0 or :1 exists after `new-session`.
    # tmux select-window -t "$selected_name:1" # Original line, might fail if base-index is 0
    # A safer way might be to target the first available window if index is uncertain:
    # tmux select-window -t "$selected_name":.+ # Selects the first window by pattern
    # Or, if a specific window setup is desired, create it explicitly:
    # tmux new-window -t "$selected_name" -n "main" # Creates a new window named "main"
    # For now, let's assume the default window created is fine or use the original logic.
    # The new-session command already creates a window.
    # If a specific window needs to be active, `select-window` is appropriate.
    # The original `tmux select-window -t $selected_name:1` might be for a specific workflow
    # where the user expects window 1 to be active. Let's keep it but be aware of base-index.
    tmux select-window -t "$selected_name:1" 2>/dev/null || tmux select-window -t "$selected_name:0" 2>/dev/null
fi

# Switch the current tmux client to the target session
# If already in tmux, this switches sessions.
# If not in tmux (but server is running), this attaches to the session.
echo "Switching to tmux session '$selected_name'."
tmux switch-client -t "$selected_name"
