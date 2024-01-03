-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
---- use `vim.keymap.set` instead

local map = vim.keymap.set

map("n", "gr", "gd[{V%::s/<C-R>///gc<left><left><left>", { desc = "Local replace" })
