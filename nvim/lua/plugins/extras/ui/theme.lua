-- return {
--   "EdenEast/nightfox.nvim",
--   opts = {
--     transparent = true,
--   },
-- }

-- return {
-- 	"folke/tokyonight.nvim",
-- 	opts = {
-- 		transparent = true,
-- 		styles = {
-- 			sidebars = "transparent",
-- 			floats = "transparent",
-- 		},
-- 	},
-- }

return {
	-- add gruvbox
	{ "ellisonleao/gruvbox.nvim" },

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}

-- return {
-- 	{
-- 		"catppuccin/nvim",
-- 		lazy = true,
-- 		name = "catppuccin",
-- 		opts = {
-- 			integrations = {
-- 				aerial = true,
-- 				alpha = true,
-- 				cmp = true,
-- 				dashboard = true,
-- 				flash = true,
-- 				gitsigns = true,
-- 				headlines = true,
-- 				illuminate = true,
-- 				indent_blankline = { enabled = true },
-- 				leap = true,
-- 				lsp_trouble = true,
-- 				mason = true,
-- 				markdown = true,
-- 				mini = true,
-- 				native_lsp = {
-- 					enabled = true,
-- 					underlines = {
-- 						errors = { "undercurl" },
-- 						hints = { "undercurl" },
-- 						warnings = { "undercurl" },
-- 						information = { "undercurl" },
-- 					},
-- 				},
-- 				navic = { enabled = true, custom_bg = "lualine" },
-- 				neotest = true,
-- 				neotree = true,
-- 				noice = true,
-- 				notify = true,
-- 				semantic_tokens = true,
-- 				telescope = true,
-- 				treesitter = true,
-- 				treesitter_context = true,
-- 				which_key = true,
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"LazyVim/LazyVim",
-- 		opts = {
-- 			colorscheme = "catppuccin",
-- 		},
-- 	},
-- }
