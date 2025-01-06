return {
	{ import = "lazyvim.plugins.extras.ui.smear-cursor" },
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "night",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_highlights = function(hl, c)
				local prompt = "#2d3149"
				hl.TelescopeNormal = {
					bg = c.bg_dark,
					fg = c.fg_dark,
				}
				hl.TelescopeBorder = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopePromptNormal = {
					bg = prompt,
				}
				hl.TelescopePromptBorder = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePromptTitle = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePreviewTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopeResultsTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				-- hl.NeoTreeDimText = {
				-- 	fg = "#ffffff",
				-- }
				-- hl.NeoTreeNormal = {
				-- 	-- bg = "#ffffff",
				-- 	fg = "#ffffff",
				-- }
				-- hl.NeoTreeNormalNC = {
				-- 	-- bg = "#ffffff",
				-- 	fg = "#ffffff",
				-- }
			end,
		},
	},

	{
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

					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				},

				sections = {
					{ section = "header", pane = 2 },
					{ section = "keys", gap = 1, padding = 1, pane = 2 },
					-- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },

					{
						pane = 3,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 5,
						padding = 1,
					},
					{
						pane = 1,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 5,
						padding = 1,
					},
					{ pane = 3, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ pane = 3, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 3,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = vim.fn.isdirectory(".git") == 1,
						cmd = "hub status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},

					{
						section = "terminal",
						cmd = "pokemon-colorscripts-go --no-title; sleep .1",
						random = 10,
						pane = 1,
						indent = 4,
						height = 30,
					},
					{ section = "startup", pane = 2 },
				},
			},
		},
	},

	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
}
