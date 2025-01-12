-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
---- use `vim.keymap.set` instead

local map = vim.keymap.set
-- local unmap = vim.keymap.del

local function map_common(combo, command, opts)
	map({ "n", "i", "x", "s" }, combo, command, opts)
end

local function map_normal(combo, command, opts)
	map("n", combo, command, opts)
end

local function map_visual(combo, command, opts)
	map("v", combo, command, opts)
end

--@param s string
---@return string
local function cmd(s)
	if string.find(s, "<cr>") then
		return "<cmd>" .. s
	else
		return "<cmd>" .. s .. "<cr>"
	end
end

local keymaps = {}

-- Coding
map_normal("<leader>cs", cmd(":noa w"), { desc = "Save file without formatting", remap = true })
map_normal("<leader>ct", cmd(":set list!"), { desc = "Toggle tabs indicator", remap = true })
map_normal("<leader>ct", cmd("TodoTelescope"), { desc = "List [t]odos", remap = true })
map_normal("<leader>cd", require("utils.ui").open_diagnostics, { desc = "[l]list TODOs and Issues", remap = true })
map_normal("<leader>ch", require("utils.code").toggle_inlay_hints, { desc = "Toggle inlay hint", remap = true })

-- Files
map_normal("<leader>fa", require("utils.ui").search_all_files, { desc = "Search all files", remap = true })
map_common("<C-b>", cmd("Neotree toggle"), { desc = "Open filetree", remap = true })
map_common("<C-b>", cmd("Neotree toggle"), { desc = "Open filetree", remap = true })
map_normal("<leader>/", function()
	local git_root = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd()) or vim.loop.cwd()
	require("telescope.builtin").live_grep({
		cwd = git_root,
	})
end, { desc = "Grep (Git Root Dir)", remap = true })
map_normal("<leader><space>", function()
	local git_root = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd()) or vim.loop.cwd()
	require("telescope.builtin").find_files({
		cwd = git_root,
	})
end, { desc = "Find Files (Git Root Dir)", remap = true })

map_normal("<leader>ro", require("utils.ui").open_last_request, { desc = "Open last response", remap = true })

map_normal("<leader>or", require("overseer").run_template, { desc = "Run a project task", remap = true })
map_normal("<leader>ot", require("overseer").toggle, { desc = "Toggle overseer task list", remap = true })

map_common("<C-p>", cmd("Telescope find_files"), { desc = "Jump to file", remap = true })
map_common("<C-t>", cmd("Telescope filetypes"), { desc = "Select filetype", remap = true })

return keymaps
