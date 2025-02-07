return {
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				mode = "virtualtext",
				RRGGBB = true,
				RRGGBBAA = true,
				names = false,
				RGB = false,
				virtualtext = " ",
			},
		},
	},
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
██╗  ██╗██╗   ██╗██╗     ███████╗██╗  ██╗██╗███████╗
██║  ██║██║   ██║██║     ██╔════╝╚██╗██╔╝██║██╔════╝
███████║██║   ██║██║     █████╗   ╚███╔╝ ██║███████╗
██╔══██║██║   ██║██║     ██╔══╝   ██╔██╗ ██║╚════██║
██║  ██║╚██████╔╝███████╗███████╗██╔╝ ██╗██║███████║
╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝
]],
				},

				sections = {
					{ section = "header", pane = 1 },
					{ section = "keys", gap = 1, padding = 1, pane = 1 },
					-- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },

					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 5,
						padding = 1,
					},
					-- {
					-- 	pane = 1,
					-- 	section = "terminal",
					-- 	cmd = "colorscript -e square",
					-- 	height = 5,
					-- 	padding = 1,
					-- },
					{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
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

					{
						section = "terminal",
						cmd = "pokemon-colorscripts-go --no-title; sleep .1",
						random = 10,
						pane = 2,
						indent = 10,
						height = 30,
						padding = 10,
					},
					{ section = "startup", pane = 1 },
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

	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load({
				-- This callback can be used to override the colors used in the base palette.
				on_palette = function(palette)
					palette.gray0 = "#191D24"
					palette.black0 = "#242933"
				end,
				-- This callback can be used to override the colors used in the extended palette.
				after_palette = function(palette) end,
				-- This callback can be used to override highlights before they are applied.
				on_highlight = function(highlights, palette) end,
				-- Enable bold keywords.
				bold_keywords = false,
				-- Enable italic comments.
				italic_comments = true,
				-- Enable editor background transparency.
				transparent = {
					-- Enable transparent background.
					bg = false,
					-- Enable transparent background for floating windows.
					float = false,
				},
				-- Enable brighter float border.
				bright_border = false,
				-- Reduce the overall amount of blue in the theme (diverges from base Nord).
				reduced_blue = true,
				-- Swap the dark background with the normal one.
				swap_backgrounds = false,
				-- Cursorline options.  Also includes visual/selection.
				cursorline = {
					-- Bold font in cursorline.
					bold = false,
					-- Bold cursorline number.
					bold_number = true,
					-- Available styles: 'dark', 'light'.
					theme = "dark",
					-- Blending the cursorline bg with the buffer bg.
					blend = 0.85,
				},
				noice = {
					-- Available styles: `classic`, `flat`.
					style = "flat",
				},
				telescope = {
					-- Available styles: `classic`, `flat`.
					style = "flat",
				},
				leap = {
					-- Dims the backdrop when using leap.
					dim_backdrop = false,
				},
				ts_context = {
					-- Enables dark background for treesitter-context window
					dark_background = true,
				},
			})
		end,
	},
}
