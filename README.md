# 🏠 Dotfiles

My personal Linux dotfiles for a productive development environment featuring Neovim, Hyprland, and a carefully curated set of tools.

## ✨ Features

### 🎨 **Theme & Colors**
- **Nordic-inspired color scheme** with custom palette
- Consistent theming across all applications
- Dark theme optimized for long coding sessions

### 🖥️ **Window Management**
- **Hyprland** - Modern Wayland compositor
- **LeftWM** - Tiling window manager for X11
- **XMonad** - Haskell-based tiling WM
- **Qtile** - Python-configured tiling WM

### 📝 **Editors & Development**
- **Neovim** - Highly configured with LazyVim
- **VS Code** integration for Neovim
- AI-powered coding with Avante.nvim
- Multiple Neovim configurations (main, NvChad)

### 🖼️ **Interface & Appearance**
- **Waybar** - Status bar for Wayland
- **EWW** - Custom widgets and bars
- **Rofi** - Application launcher and menu
- **Dunst** - Notification daemon

### 🔧 **Terminal & Shell**
- **Fish** - Friendly interactive shell
- **Alacritty** - GPU-accelerated terminal
- **Kitty** - Feature-rich terminal emulator
- **Ghostty** - Modern terminal emulator
- **Tmux** - Terminal multiplexer with custom themes

### 🎯 **System Tools**
- **Starship** - Cross-shell prompt
- **Btop** - Resource monitor
- **Picom** - X11 compositor with effects
- **Swaylock** - Screen locker for Wayland

## 📋 Prerequisites

Before installing, ensure you have the following:

- **Arch Linux** (or compatible distribution)
- **Git**
- **Python 3**
- **Fish shell** (optional, but recommended)

### Required Packages

```bash
# Essential packages
sudo pacman -S git neovim tmux fish starship

# Window managers (choose one or more)
sudo pacman -S hyprland qtile xmonad

# Terminal emulators
sudo pacman -S alacritty kitty

# Additional tools
sudo pacman -S rofi dunst waybar picom btop
```

## 🚀 Installation

> [!WARNING]
> **Important**: These are my personal configurations. Please review the code and customize it to your needs before installation. The setup script will overwrite existing configurations!

### Quick Install

```bash
# Clone the repository
git clone git@github.com:Hulexis/dotfiles.git ~/.dotfiles

# Navigate to the directory
cd ~/.dotfiles

# Run the setup script
./setup.sh
```

### Manual Installation

If you prefer to install specific configurations:

```bash
# Link individual configs
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/fish ~/.config/fish
ln -s ~/.dotfiles/tmux ~/.config/tmux
# ... and so on
```

## 📁 Structure

```
~/.dotfiles/
├── nvim/              # Neovim configuration (LazyVim)
├── nvim-nvchad/       # Alternative Neovim config (NvChad)
├── nvim-vs-code/      # VS Code Neovim integration
├── fish/              # Fish shell configuration
├── tmux/              # Tmux configuration and themes
├── hypr/              # Hyprland configuration
├── qtile/             # Qtile window manager
├── xmonad/            # XMonad configuration
├── leftwm/            # LeftWM configuration
├── alacritty/         # Alacritty terminal config
├── kitty/             # Kitty terminal config
├── ghostty/           # Ghostty terminal config
├── waybar/            # Waybar status bar
├── rofi/              # Rofi launcher config
├── dunst/             # Notification daemon
├── eww/               # EWW widgets
├── picom/             # Compositor configuration
├── swaylock/          # Screen locker
├── btop/              # System monitor
├── scripts/           # Utility scripts
├── colours.md         # Color palette reference
└── setup.sh           # Installation script
```

## 🎨 Color Scheme

The configuration uses a custom Nordic-inspired color palette. See [`colours.md`](colours.md) for the complete color reference.

**Key Colors:**
- **Background**: `#242933`
- **Foreground**: `#D8DEE9`
- **Accent**: `#88C0D0`
- **Warning**: `#EBCB8B`
- **Error**: `#BF616A`

## ⚙️ Configuration Highlights

### Neovim
- **LazyVim** distribution with custom plugins
- **AI integration** with Avante.nvim
- **LSP** support for multiple languages
- **Custom keybindings** and workflows

### Tmux
- **Multiple themes** (Nova, Catppuccin)
- **Custom key bindings**
- **Plugin management** with TPM
- **Powerline integration**

### Hyprland
- **Multi-monitor support**
- **Custom animations** and effects
- **Workspace management**
- **Application-specific rules**

## 🔧 Customization

### Adding Your Own Configs

1. **Fork this repository**
2. **Modify configurations** to suit your needs
3. **Update the setup script** if needed
4. **Test in a virtual machine** first

### Key Files to Customize

- `fish/config.fish` - Shell aliases and functions
- `nvim/lua/config/` - Neovim personal settings
- `hypr/hyprland.conf` - Hyprland window manager
- `colours.md` - Color scheme definitions

## 🛠️ Troubleshooting

### Common Issues

**Neovim plugins not loading:**
```bash
nvim --headless "+Lazy! sync" +qa
```

**Fish shell not found:**
```bash
sudo pacman -S fish
chsh -s /usr/bin/fish
```

**Hyprland not starting:**
- Check your graphics drivers
- Verify Wayland support

### Getting Help

- Check individual application documentation
- Review configuration files for comments
- Open an issue for specific problems

## 📝 Scripts

The `scripts/` directory contains useful utilities:

- `launcher.sh` - Application launcher
- `tmux-session.sh` - Tmux session management
- `toggle_keyboard_layout.py` - Keyboard layout switcher
- `lock.sh` - Screen locking script
- `xrandr-setup.sh` - Monitor configuration

## 🤝 Contributing

While these are personal dotfiles, suggestions and improvements are welcome:

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes**
4. **Submit a pull request**

## 📄 License

This project is open source. Feel free to use, modify, and distribute as needed.

## 🙏 Acknowledgments

- **LazyVim** - Excellent Neovim distribution
- **Nordic.nvim** - Beautiful color scheme inspiration
- **Hyprland** - Amazing Wayland compositor
- **Fish Shell** - User-friendly shell experience

---

## Author

```plaintext
██╗  ██╗██╗   ██╗██╗     ███████╗██╗  ██╗██╗███████╗
██║  ██║██║   ██║██║     ██╔════╝╚██╗██╔╝██║██╔════╝
███████║██║   ██║██║     █████╗   ╚███╔╝ ██║███████╗
██╔══██║██║   ██║██║     ██╔══╝   ██╔██╗ ██║╚════██║
██║  ██║╚██████╔╝███████╗███████╗██╔╝ ██╗██║███████║
╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝
```

> *"The best dotfiles are the ones that make you forget they exist."*
