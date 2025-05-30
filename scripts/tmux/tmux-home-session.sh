#!/bin/bash

source ~/scripts/tmux/tmux_functions.sh

session="home"

cd ~/ || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]; then
	echo "Session $session already running"
	exit
fi

tmux new-session -d -s $session

setup_tmux_window $session 1 ~/ home
setup_tmux_window $session 2 ~/.dotfiles/ dotfiles

tmux select-window -t 1
