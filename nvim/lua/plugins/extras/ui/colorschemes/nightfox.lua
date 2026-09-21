-- Flavors: nightfox, duskfox, nordfox, terafox, dayfox, dawnfox
return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	name = "nightfox",
	opts = {
		options = {
			transparent = false,
			terminal_colors = true,
			dim_inactive = false,
			styles = {
				comments = "italic",
				keywords = "bold",
				types = "italic,bold",
				functions = "NONE",
				strings = "NONE",
				variables = "NONE",
				constants = "NONE",
				numbers = "NONE",
				operators = "NONE",
				conditionals = "NONE",
			},
			inverse = {
				match_paren = false,
				visual = false,
				search = false,
			},
		},
	},
}
