return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers.vtsls = opts.servers.vtsls or {}
			opts.servers.vtsls.settings = opts.servers.vtsls.settings or {}
			opts.servers.vtsls.settings.typescript = opts.servers.vtsls.settings.typescript or {}
			opts.servers.vtsls.settings.typescript.preferences = {
				preferTypeOnlyAutoImports = true,
			}
			-- -- Add root_dir configuration
			-- opts.servers.vtsls.root_dir = function(fname)
			-- 	return require("lspconfig.util").find_git_ancestor(fname)
			-- 		or require("lspconfig.util").find_node_modules_ancestor(fname)
			-- end
		end,
	},
}
