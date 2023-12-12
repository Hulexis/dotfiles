return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				-- "cssls",
				"eslint",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
				"tailwindcss",
				"tsserver",
			},
		},
	},
}
