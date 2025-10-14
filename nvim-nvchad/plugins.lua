local overrides = require("custom.configs.overrides")

return {

	----------------------------------------- default configs ------------------------------------------

	{
		"hrsh7th/nvim-cmp",
		opts = {
			sources = {
				-- trigger_characters is for unocss lsp
				{ name = "nvim_lsp", trigger_characters = { "-" } },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				-- format & linting
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	-- override default configs
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
	{ "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
	{ "mason-org/mason.nvim", opts = overrides.mason },

	----------------------------------------- custom configs ------------------------------------------
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
