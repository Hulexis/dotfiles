#!/bin/sh

# Removing stuff
# rm ~/.tmux.conf
# rm ~/.vimrc
# rm ~/.zshrc
#
# rm -r ~/.config/alacritty
# rm -r ~/.config/nvim
# rm -r ~/.config/qtile
# rm -r ~/.config/rofi


# Setup up neovim 
# Disaple neovim setup
# git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
# ln -s ~/.dotfiles/nvim ~/.config/nvim/lua/custom

ln -s ~/.dotfiles/nvim ~/.config/nvim

# Setup up normal dot files
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Setup alacritty
ln -s ~/.dotfiles/alacritty ~/.config/alacritty

# Setup qtile
ln -s ~/.dotfiles/qtile ~/.config/qtile

ln -s ~/.dotfiles/picom ~/.config/picom
ln -s ~/.dotfiles/rofi ~/.config/rofi
ln -s ~/.dotfiles/kitty ~/.config/kitty
ln -s ~/.dotfiles/dunst ~/.config/dunst
ln -s ~/.dotfiles/tmux ~/.config/tmux

ln -s ~/.dotfiles/scripts ~/scripts

