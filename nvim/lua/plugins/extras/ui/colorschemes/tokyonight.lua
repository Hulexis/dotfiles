return {
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
}
