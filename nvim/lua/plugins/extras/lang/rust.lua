return {
	{ import = "lazyvim.plugins.extras.lang.rust" },
	{
		"Saecki/crates.nvim",
		opts = function(_, opts)
			opts.lsp.completion = false
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		opts = function(_, opts)
			opts.server.default_settings = vim.tbl_deep_extend("force", opts.server.default_settings or {}, {
				["rust-analyzer"] = {
					completion = {
						callable = {
							snippets = "none", -- Don't want to complete function arguments
						},
					},
				},
			})
		end,
	},
}
