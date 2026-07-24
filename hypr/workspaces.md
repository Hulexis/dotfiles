# Hyprland Workspaces

This workspace layout is organized around mental modes rather than specific applications. Each workspace represents a type of work, making it easier to switch contexts without thinking about where a particular application belongs.

## Workspace overview

| Workspace | Icon | Purpose | Open / toggle | Move window |
|---:|:---:|---|---|---|
| 1 | 🌐 | Research — consuming information and gathering context | `Super + 1` | `Super + Shift + 1` |
| 2 | 💻 | Build — primary development environment | `Super + 2` | `Super + Shift + 2` |
| 3 | 🎨 | Creative — visual design and physical creation | `Super + 3` | `Super + Shift + 3` |
| 4 | 📚 | Knowledge — long-form reading and writing | `Super + 4` | `Super + Shift + 4` |
| 5 | 🖥️ | Infrastructure — managing development environments | `Super + 5` | `Super + Shift + 5` |
| 6 | 📬 | Work administration — planning and admin tools | `Super + 6` | `Super + Shift + 6` |
| 7 | ☁️ | Operations — production systems and monitoring | `Super + 7` | `Super + Shift + 7` |
| 8 | 🧪 | Sandbox — experimentation and exploration | `Super + 8` | `Super + Shift + 8` |
| 9 | 📁 | Files — file management | `Super + 9` | `Super + Shift + 9` |
| 10 | 📦 | Miscellaneous — overflow and temporary windows | `Super + 0` | `Super + Shift + 0` |
| 11 | 💬 | Chat — communication and messaging | `Super + C` | `Super + Shift + C` |
| 12 | 📱 | Devices — hardware, Android, firmware tools | `Super + A` | `Super + Shift + A` |
| 13 | 🎮 | Games — gaming and game launchers | `Super + G` | `Super + Shift + G` |
| 14 | 🎵 | Media — music and media playback | `Super + M` | `Super + Shift + M` |
| 15 | ▶️ | Runtime — whatever is currently running | `Super + P` | `Super + Shift + P` |
| Special | 🚀 | Overlay — temporary tools without leaving current workspace | `Super + X` | `Super + Shift + X` |

## Primary workspaces (1–4)

The first four workspaces form the core development workflow:

```text
1 Research → 2 Build → 3 Creative → 4 Knowledge
```

- **Research** — browser, ChatGPT, GitHub, documentation, API references.
- **Build** — Ghostty, tmux, Neovim, build tools.
- **Creative** — Figma, FreeCAD, Blender, GIMP, Bambu Studio.
- **Knowledge** — Obsidian, notes, PDFs, architecture and design documents.

## Supporting workspaces (5–10)

Visited less frequently but support the primary workflow:

- **5 — Infrastructure:** SSH, Docker, Kubernetes, database clients, local servers.
- **6 — Work administration:** Linear, email, calendar, sprint planning.
- **7 — Operations:** AWS Console, Datadog, Grafana, production dashboards, customer troubleshooting.
- **8 — Sandbox:** trying new software, temporary windows, testing scripts, one-off workflows.
- **9 — Files:** Nautilus, downloads, archives, file transfers.
- **10 — Miscellaneous:** anything that doesn't fit elsewhere.

## Dedicated workspaces

These use mnemonic keybindings because they are specialized modes outside the everyday number-row workflow.

### Chat — workspace 11 (`Super + C`)

Discord, Slack, Teams.

### Devices — workspace 12 (`Super + A`)

Hardware and device development: Android Studio, scrcpy, ADB, PlatformIO, Arduino IDE, serial terminals, firmware tools.

### Games — workspace 13 (`Super + G`)

Steam and running games. Launch Steam in Gamescope with `Super + Control + G`.

### Media — workspace 14 (`Super + M`)

Spotify, VLC, music, streaming services.

### Runtime — workspace 15 (`Super + P`)

Whatever is currently being executed: browser preview, local web app, game window, emulator, device preview. Represents the output of work regardless of project type.

## Special workspace (`Super + X`)

A temporary overlay that opens without leaving the current workspace. Good for API docs, HTTP clients, quick notes, calculators, logs, and short-lived tasks.

## Waybar icons

```json
"format-icons": {
    "1": "",
    "2": "",
    "3": "",
    "4": "",
    "5": "",
    "6": "",
    "7": "",
    "8": "",
    "9": "",
    "10": "",
    "11": "",
    "12": "",
    "13": "",
    "14": "",
    "15": "",
    "special": ""
}
```
