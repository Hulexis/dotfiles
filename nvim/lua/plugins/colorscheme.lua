return {
	"folke/tokyonight.nvim",
	opts = {
		style = "night",
		transparent = true,
		styles = {
			-- sidebars = "transparent",
			floats = "transparent",
		},
		on_highlights = function(hl, c)
			hl.NeoTreeDimText = {
				fg = "#ffffff",
			}
			hl.NeoTreeNormal = {
				-- bg = "#ffffff",
				fg = "#ffffff",
			}
			hl.NeoTreeNormalNC = {
				-- bg = "#ffffff",
				fg = "#ffffff",
			}
		end,
	},
}
