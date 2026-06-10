hyprctl eval "hl.config({ animations = { enabled = false } })"
hyprshot -m region
hyprctl eval "hl.config({ animations = { enabled = true } })"
