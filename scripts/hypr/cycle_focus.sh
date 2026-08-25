#!/bin/bash
# Cycle window focus while preserving maximized/fullscreen state
# fullscreen field: 0=none, 1=fullscreen, 2=maximized

PREV=$(hyprctl activewindow -j | jq '.fullscreen')
hyprctl dispatch 'hl.dsp.window.cycle_next()'

if [ "$PREV" -gt 0 ]; then
    NEW=$(hyprctl activewindow -j | jq '.fullscreen')
    if [ "$NEW" != "$PREV" ]; then
        case "$PREV" in
            1) hyprctl dispatch 'hl.dsp.window.fullscreen({mode="maximized"})' ;;
            2) hyprctl dispatch 'hl.dsp.window.fullscreen({mode="fullscreen"})' ;;
        esac
    fi
fi
