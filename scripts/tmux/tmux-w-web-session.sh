#!/bin/bash

source ~/scripts/tmux/tmux_functions.sh

session="w-web"

cd ~/work || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]; then
	echo "Session already running"
	exit
fi

tmux new-session -d -s $session

setup_tmux_window $session 1 ~/work/web/web/ lib
setup_tmux_window $session 2 ~/work/web/web.portal/ portal
setup_tmux_window $session 3 ~/work/web/web.fix/ fix
setup_tmux_window $session 4 ~/work/web/web.control/ control
setup_tmux_window $session 5 ~/work/web/st-portal/ st
setup_tmux_window $session 6 ~/work/web/easee-cloud-portal/ old-portal

tmux select-window -t 1
