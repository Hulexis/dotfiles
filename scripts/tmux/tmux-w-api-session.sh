#!/bin/bash

source ~/scripts/tmux/tmux_functions.sh

session="w-api"

cd ~/work || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]; then
	echo "Session already running"
	exit
fi

tmux new-session -d -s $session

setup_tmux_window $session 1 ~/work/api/electra-kit-api/ fap
setup_tmux_window $session 2 ~/work/api/easee-cloud/ cloud

tmux select-window -t 1
