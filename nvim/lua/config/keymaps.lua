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

map_normal("<leader>cs", cmd(":noa w"), { desc = "Save file without formatting", remap = true })
map_normal("<leader>ct", cmd(":set list!"), { desc = "Toggle tabs indicator", remap = true })
map_normal("<leader>cl", require("utils.ui").open_diagnostics, { desc = "[l]ist TODOs and Issues", remap = true })
map_normal(
	"<leader>ma",
	cmd(':lua require("monorepo").add_project()'),
	{ desc = "Add project to project list", remap = true }
)
map_normal(
	"<leader>mr",
	cmd(':lua require("monorepo").remove_project()'),
	{ desc = "Remove project to project list", remap = true }
)
map_normal(
	"<leader>mt",
	cmd(':lua require("monorepo").toggle_project()'),
	{ desc = "Remove project to project list", remap = true }
)

for i = 1, 9 do
	map_normal("<leader>m" .. i, function()
		require("monorepo").go_to_project(i)
	end, { desc = "Go to proejct " .. i, remap = true })
end

map_common("<C-b>", cmd("Neotree toggle"), { desc = "Open filetree", remap = true })
map_common("<C-b>", cmd("Neotree toggle"), { desc = "Open filetree", remap = true })

map_normal("<leader>re", function()
	require("telescope").extensions.rest.select_env()
end, { desc = "Select [e]nvironment for http request", remap = true })

return keymaps
