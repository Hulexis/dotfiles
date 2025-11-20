hyprctl keyword animations:enabled false
grim -g "$(slurp)" - | swappy -f - # select region + annotate
hyprctl keyword animations:enabled true
