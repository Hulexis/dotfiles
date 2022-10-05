#!/bin/sh

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

mkdir ~/.config/nvim/lua/custom

ln -s ~/.dotfiles/nvim/* ~/.config/nvim/lua/custom

