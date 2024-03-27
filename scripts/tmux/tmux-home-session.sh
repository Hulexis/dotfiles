#!/bin/bash

session="home"

cd ~/ || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]; then
	echo "Session $session already running"
	exit
fi

tmux new-session -d -s $session

window=1
tmux rename-window -t $session:$window 'home'

window=2
tmux new-window -t $session:$window -n 'dotfiles'
tmux send-keys -t $session:$window 'cd ~/.dotfiles/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z
