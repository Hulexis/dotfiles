return {
	{ import = "lazyvim.plugins.extras.lang.typescript" },
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers.vtsls.settings.typescript.preferences = {
				preferTypeOnlyAutoImports = true,
			}
		end,
	},
}
