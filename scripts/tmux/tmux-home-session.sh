#!/bin/bash

session="home"

cd ~/ || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]
then
	echo "Session $session already running"
  exit
fi

tmux new-session -d -s $session

window=1
tmux rename-window -t $session:$window 'home'
