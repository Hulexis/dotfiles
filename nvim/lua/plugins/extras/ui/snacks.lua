return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {

		dashboard = {

			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = require("utils.ui").dashboard_name(),
			},

			sections = {
				{ section = "header", pane = 1 },
				{ section = "keys", gap = 1, padding = 1, pane = 1 },
				-- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },

				-- {
				-- 	pane = 2,
				-- 	section = "terminal",
				-- 	cmd = "colorscript -e square",
				-- 	height = 5,
				-- 	padding = 1,
				-- },
				-- {
				-- 	pane = 1,
				-- 	section = "terminal",
				-- 	cmd = "colorscript -e square",
				-- 	height = 5,
				-- 	padding = 1,
				-- },
				-- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				-- {
				-- 	pane = 3,
				-- 	icon = " ",
				-- 	title = "Git Status",
				-- 	section = "terminal",
				-- 	enabled = vim.fn.isdirectory(".git") == 1,
				-- 	cmd = "hub status --short --branch --renames",
				-- 	height = 5,
				-- 	padding = 1,
				-- 	ttl = 5 * 60,
				-- 	indent = 3,
				-- },

				-- {
				-- 	section = "terminal",
				-- 	cmd = "pokemon-colorscripts-go --no-title; sleep .1",
				-- 	random = 10,
				-- 	pane = 2,
				-- 	indent = 10,
				-- 	height = 30,
				-- 	padding = 10,
				-- },
				{ section = "startup", pane = 1 },
			},
		},
	},
}
