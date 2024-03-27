#!/bin/bash

session="work"

cd ~/work || exit

SESSIONEXISTS=$(tmux list-sessions | grep "$session")

if [ "$SESSIONEXISTS" != "" ]; then
	echo "Session already running"
	exit
fi

tmux new-session -d -s $session

window=1
tmux rename-window -t $session:$window 'blocks'
tmux send-keys -t $session:$window 'cd ~/work/web/electra-kit/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=2
tmux new-window -t $session:$window -n 'api'
tmux send-keys -t $session:$window 'cd ~/work/web/electra-kit-api/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=3
tmux new-window -t $session:$window -n 'fix'
tmux send-keys -t $session:$window 'cd ~/work/web/web.fix/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=4
tmux new-window -t $session:$window -n 'control'

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=5
tmux new-window -t $session:$window -n 'releasee'
tmux send-keys -t $session:$window 'cd ~/work/releasee/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=6
tmux new-window -t $session:$window -n 'portal'
tmux send-keys -t $session:$window 'cd ~/work/web/easee-cloud-portal/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=7
tmux new-window -t $session:$window -n 'st'
tmux send-keys -t $session:$window 'cd ~/work/web/st-portal/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

window=8
tmux new-window -t $session:$window -n 'app'
tmux send-keys -t $session:$window 'cd ~/work/app/easee-kit/' C-m

# tmux split-window -t $session:$window
# tmux split-window -t $session:$window.1 -h
# tmux split-window -t $session:$window.2
# tmux split-window -t $session:$window.4 -h
# tmux resize-pane -t $session:$window.1 -Z

# tmux send-keys -t $session:$window 'cd ~/work/web/electra-kit/' C-m "git pull" C-m "pnpm i" C-m "pnpm run dev" C-m
#
# tmux split-window -t $session:$window
# tmux send-keys -t $session:$window 'cd ~/work/web/electra-go' C-m "git pull" C-m "make run" C-m
#
# tmux split-window -t $session:$window.1 -h
# tmux send-keys -t $session:$window 'cd ~/work/web/electra-kit/' C-m "pnpm run storybook" C-m
#
# window=2
# tmux new-window -t $session:$window -n 'kit'
# tmux split-window -t $session:$window
# tmux send-keys -t $session:$window 'cd web/electra-kit' C-m "clear" C-m
#
# tmux resize-pane -t $session:$window.1 -Z
# tmux send-keys -t $session:$window.1 'cd web/electra-kit' C-m "nvim" C-m
#
# window=3
# tmux new-window -t $session:$window -n 'go'
# tmux split-window -t $session:$window
# tmux send-keys -t $session:$window 'cd web/electra-go' C-m "clear" C-m
#
# tmux resize-pane -t $session:$window.1 -Z
# tmux send-keys -t $session:$window.1 'cd web/electra-go' C-m "nvim" C-m
