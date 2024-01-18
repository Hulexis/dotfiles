return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				-- "cssls",
				"eslint_d",
				"eslint-lsp",
				"gopls",
				"html-lsp",
				"json-lsp",
				-- "lua_ls",
				-- "tailwindcss-language-server",
				-- "tsserver",
				"prettier",
				"graphql-language-service-cli",
				"cspell",
				"angular-language-server",
				"bash-language-server",
				"pyright",
				"yapf",
				"black",
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			table.insert(opts.sources, nls.builtins.formatting.prettier, nls.builtins.formatting.black)
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["javascript"] = { "prettier" },
				["javascriptreact"] = { "prettier" },
				["typescript"] = { "prettier" },
				["typescriptreact"] = { "prettier" },
				["vue"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
				["less"] = { "prettier" },
				["html"] = { "prettier" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				["yaml"] = { "prettier" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["graphql"] = { "prettier" },
				["handlebars"] = { "prettier" },
				["python"] = { "yapf" },
			},
		},
	},
}
