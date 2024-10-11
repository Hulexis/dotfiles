local Util = require("lazyvim.util")

return {
	{
		"nvimtools/none-ls.nvim",
		event = "LazyFile",
		dependencies = { "mason.nvim" },
		init = function()
			Util.on_very_lazy(function()
				-- register the formatter with LazyVim
				require("lazyvim.util").format.register({
					name = "none-ls.nvim",
					priority = 200, -- set higher than conform, the builtin formatter
					primary = true,
					format = function(buf)
						return Util.lsp.format({
							bufnr = buf,
							filter = function(client)
								return client.name == "null-ls"
							end,
						})
					end,
					sources = function(buf)
						local ret = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
						return vim.tbl_map(function(source)
							return source.name
						end, ret)
					end,
				})
			end)
		end,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.root_dir = opts.root_dir
				or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.formatting.stylua,
				-- nls.builtins.formatting.prettier,
				-- nls.builtins.formatting.black,
				-- nls.builtins.diagnostics.typos,
				-- nls.builtins.diagnostics.write_good,
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
				nls.builtins.formatting.goimports,
				nls.builtins.formatting.gofumpt,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["javascript"] = { "biome" },
				["javascriptreact"] = { "biome" },
				["typescript"] = { "biome" },
				["typescriptreact"] = { "biome" },
				["vue"] = { "biome" },
				["css"] = { "biome" },
				["scss"] = { "biome" },
				["less"] = { "biome" },
				["html"] = { "prettier" },
				["json"] = { "biome" },
				["jsonc"] = { "biome" },
				["yaml"] = { "biome" },
				["markdown"] = { "biome" },
				["markdown.mdx"] = { "biome" },
				["graphql"] = { "biome" },
				["handlebars"] = { "biome" },
				["python"] = { "yapf" },
				["swift"] = { "swift_format_ext" },
				["go"] = { "goimports", "gofumpt" },
				-- ["rust"] = { "rustfmt" },
			},
			formatters = {
				swift_format_ext = {
					command = "swiftformat",
					args = { "--stdinpath", "$FILENAME" },
					range_args = function(self, ctx)
						return {
							"--linerange",
							ctx.range.start[1] .. "," .. ctx.range["end"][1],
						}
					end,
					stdin = true,
					condition = function(self, ctx)
						return vim.fs.basename(ctx.filename) ~= "README.md"
					end,
				},
			},
		},
	},
}
