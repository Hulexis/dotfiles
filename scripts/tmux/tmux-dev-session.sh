#!/bin/bash

source ~/scripts/tmux/tmux_functions.sh

session="dev"

cd ~/ || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]; then
	echo "Session $session already running"
	exit
fi

tmux new-session -d -s $session

setup_tmux_window $session 1 ~/dev dev
