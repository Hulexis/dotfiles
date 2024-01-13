#!/bin/bash

session="work"

cd ~/work || exit


SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]
then
	echo "Session already running"
  exit
fi

tmux new-session -d -s $session

window=1
tmux rename-window -t $session:$window 'serve'
tmux send-keys -t $session:$window 'cd ~/work/web/electra-kit/' C-m "git pull" C-m "pnpm i" C-m "pnpm run dev" C-m
  
tmux split-window -t $session:$window
tmux send-keys -t $session:$window 'cd ~/work/web/electra-go' C-m "git pull" C-m "make run" C-m
  
tmux split-window -t $session:$window.1 -h
tmux send-keys -t $session:$window 'cd ~/work/web/electra-kit/storybook/' C-m "git pull" C-m "pnpm i" C-m "pnpm run storybook" C-m
  
window=2
tmux new-window -t $session:$window -n 'kit'
tmux split-window -t $session:$window
tmux send-keys -t $session:$window 'cd web/electra-kit' C-m "clear" C-m
  
tmux resize-pane -t $session:$window.1 -Z
tmux send-keys -t $session:$window.1 'cd web/electra-kit' C-m "nvim" C-m
  
window=3
tmux new-window -t $session:$window -n 'go'
tmux split-window -t $session:$window
tmux send-keys -t $session:$window 'cd web/electra-go' C-m "clear" C-m
  
tmux resize-pane -t $session:$window.1 -Z
tmux send-keys -t $session:$window.1 'cd web/electra-go' C-m "nvim" C-m

