return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local opts = {
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<tab>"] = cmp.mapping(function(original)
						print("tab pressed")
						if cmp.visible() then
							print("cmp expand")
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							print("snippet expand")
							luasnip.expand_or_jump()
						else
							print("fallback")
							original()
						end
					end, { "i", "s" }),
					["<S-tab>"] = cmp.mapping(function(original)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.jump(-1)
						else
							original()
						end
					end, { "i", "s" }),
				}),
			}
			cmp.setup(opts)
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", lazy = true },
	{ "hrsh7th/cmp-path", lazy = true },
	{ "hrsh7th/cmp-buffer", lazy = true },

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.sourcekit.setup({
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(args)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
				end,
			})
		end,
	},
}
