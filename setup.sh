#!/bin/sh

# Removing stuff
rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.zshrc

rm -r ~/.config/alacritty
rm -r ~/.config/nvim
rm -r ~/.config/qtile


# Setup up neovim 
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
ln -s ~/.dotfiles/nvim ~/.config/nvim/lua/custom

# Setup up normal dot files
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Setup alacritty
ln -s ~/.dotfiles/alacritty ~/.config/alacritty

# Setup qtile
ln -s ~/.dotfiles/qtile ~/.config/qtile

