return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"eslint_d",
				"eslint-lsp",
				"gopls",
				"html-lsp",
				"json-lsp",
				"graphql-language-service-cli",
				"cspell",
				"angular-language-server",
				"bash-language-server",
				"pyright",
				"yapf",
				"black",
				"typos",
				"write-good",
				"css-lsp",
				"gomodifytags",
				"impl",
				"delve",
				"goimports",
				"gofumpt",
				"omnisharp",
				"dart-debug-adapter",
				"biome",
				"bacon",
				"bacon-ls",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"simrat39/rust-tools.nvim",
			"mfussenegger/nvim-dap-python",
		},
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "<leader>cl", false }
		end,
	},
}
