return {
	{ import = "lazyvim.plugins.extras.lang.elixir" },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.elixirls.setup({
				cmd = { "elixir-ls" },
				-- set default capabilities for cmp lsp completion source
				capabilities = capabilities,
			})
		end,
	},
}
