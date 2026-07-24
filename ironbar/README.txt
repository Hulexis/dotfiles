Copy the files to:

  ~/.config/ironbar/config.json
  ~/.config/ironbar/style.css

Then test with:

  pkill ironbar 2>/dev/null
  ironbar

Hyprland autostart:

  exec-once = ironbar

Notes:
- The pasted Waybar config had empty modules-left/center/right arrays, so the layout was inferred.
- The music module uses MPRIS for display, but the click/scroll commands target Spotify.
- Remove the battery module if you do not use this config on a laptop.
- The keyboard module requires membership in the input group.
