#!/bin/bash

# Function to set up a tmux window with splits and directory
setup_tmux_window() {
	local session=$1
	local window=$2
	local path=$3
	local name=$4

	if [ "$window" = 1 ]; then
		tmux rename-window -t "$session":"$window" "$name"
	else
		tmux new-window -t "$session":"$window" -n "$name"
	fi

	# navigate to the specified path
	tmux send-keys -t "$session":"$window" "cd $path" C-m
	tmux send-keys -t "$session":"$window" 'clear' C-m

	# Split the tmux window and change directories in the splits
	tmux split-window -t "$session":"$window".1 -h -c "$path"
	tmux split-window -t "$session":"$window".1 -c "$path"
	tmux split-window -t "$session":"$window".2 -h -c "$path"
	tmux split-window -t "$session":"$window".4 -c "$path"

	# Select the first pane and zoom it
	tmux select-pane -t 1
	tmux resize-pane -Z
}
