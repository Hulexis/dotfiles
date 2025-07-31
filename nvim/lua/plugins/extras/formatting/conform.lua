return {
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
			["astro"] = { "biome" },
			["python"] = { "yapf" },
			["swift"] = { "swift_format_ext" },
			["go"] = { "goimports", "gofumpt" },
			["fish"] = { "fish_indent" },
			["dart"] = { "blink" },
			-- ["rust"] = { "rustfmt" },
		},
		formatters = {
			blink = {
				command = "/home/aj/packages/blink/target/release/blink",
				args = { "$FILENAME" },
				stdin = false,
				cwd = require("conform.util").root_file({ ".editorconfig", "pubspec.yaml" }),
			},
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
}
