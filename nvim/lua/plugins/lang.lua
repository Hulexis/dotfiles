vim.treesitter.language.register("markdown", "mdx")

return {
	-- ##############
	-- ### Fluter ###
	-- ##############
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local flutter = require("flutter-tools")
			flutter.setup({
				decorations = {
					statusline = {
						app_version = true,
						device = true,
						project_config = true,
					},
				},
				debugger = {
					enabled = true,
					run_via_dap = true,
					register_configurations = function(_)
						require("dap").adapters.dart = {
							type = "executable",
							command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
							args = { "flutter" },
						}
						require("dap").configurations.dart = {
							{
								type = "dart",
								request = "launch",
								name = "Launch flutter",
							},
						}
						-- require("dap.ext.vscode").load_launchjs((vim.fn.getcwd() .. "/.nvim/dap.json"))
						require("dap.ext.vscode").load_launchjs()
						local dap = require("dap")
						if require("utils.tables").length(dap.configurations["dart"]) > 1 then
							table.remove(dap.configurations["dart"], 2)
						end

						vim.keymap.set("n", "<F5>", function()
							local commands = require("flutter-tools.commands")
							if commands.is_running() then
								vim.cmd("DapContinue")
							else
								vim.cmd("FlutterRun")
							end
						end)
					end,
				},
				outline = {
					open_cmd = "60vnew",
					auto_open = false,
				},
				dev_log = {
					enabled = false,
					-- notify_errors = false,
					-- open_cmd = "tabedit",
					open_cmd = "60vnew",
					-- open_cmd = "30new",
				},
				lsp = {
					on_attach = function(client, buffer)
						-- require("user.lsp.handlers").on_attach(client, buffer)
						-- require("config.keymaps").flutter(client, buffer)
					end,
					-- capabilities = require("user.lsp.handlers").capabilities,
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						enableSdkFormatter = false,
						analysisExcludedFolders = {
							".dart_tool",
							"/home/skela/files/sdks/flutter",
							"/home/skela/.pub-cache",
						},
						enableSnippets = true,
						updateImportsOnRename = true,
					},
					color = {
						enabled = true,
						background = false,
						background_color = { r = 0, g = 0, b = 0 },
						foreground = false,
						virtual_text = true,
						virtual_text_str = "⏺",
					},
				},
			})
		end,
	},
	{ -- for dart syntax highlighting
		"dart-lang/dart-vim-plugin",
	},

	-- ###############
	-- ### Go lang ###
	-- ###############
	{ import = "lazyvim.plugins.extras.lang.go" },
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
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	-- ###########
	-- ### PKL ###
	-- ###########
	{
		"https://github.com/apple/pkl-neovim",
		lazy = true,
		event = "BufReadPre *.pkl",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd("TSInstall! pkl")
		end,
	},

	-- ################
	-- ### Tailwind ###
	-- ################
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				tailwindcss = {
					-- exclude a filetype from the default_config
					filetypes_exclude = { "markdown" },
					-- add additional filetypes to the default_config
					filetypes_include = {},
					-- to fully override the default_config, change the below
					-- filetypes = {}
					classRegex = {
						{ "styles \\=([^;]*);", "'([^']*)'" },
						{ "styles \\=([^;]*);", '"([^"]*)"' },
						{ "styles \\=([^;]*);", "\\`([^\\`]*)\\`" },
						{ "Styles \\=([^;]*);", "'([^']*)'" },
						{ "Styles \\=([^;]*);", '"([^"]*)"' },
						{ "Styles \\=([^;]*);", "\\`([^\\`]*)\\`" },
					},
				},
			},
			settings = {
				tailwindCSS = {
					experimental = {},
					classAttributes = {
						"class",
						"className",
						"ngClass",
						".*Styles",
					},
				},
			},
			setup = {
				tailwindcss = function(_, opts)
					local tw = require("lspconfig.configs.tailwindcss")
					opts.filetypes = opts.filetypes or {}

					opts.settings = tw.default_config.settings

					-- vim.list_extend(opts.settings.tailwindCSS, { experimental = { classRegex = opts.classRegex } })

					opts.settings.tailwindCSS.experimental = { classRegex = opts.classRegex }

					-- Add default filetypes
					vim.list_extend(opts.filetypes, tw.default_config.filetypes)

					-- Remove excluded filetypes
					--- @param ft string
					opts.filetypes = vim.tbl_filter(function(ft)
						return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
					end, opts.filetypes)

					-- Add additional filetypes
					vim.list_extend(opts.filetypes, opts.filetypes_include or {})
				end,
			},
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			-- original LazyVim kind icon formatter
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item) -- add icons
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
		},
		opts = {
			border = "rounded", -- Valid window border style,
			show_unknown_classes = true, -- Shows the unknown classes popup
			focus_preview = true, -- Sets the preview as the current window
			copy_register = "", -- The register to copy values to,
			keymaps = {
				copy = "<C-y>", -- Normal mode keymap to copy the CSS values between {}
			},
		},
	},

	-- ##################
	-- ### Typescript ###
	-- ##################
	{ import = "lazyvim.plugins.extras.lang.typescript" },
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers.vtsls = opts.servers.vtsls or {}
			opts.servers.vtsls.settings = opts.servers.vtsls.settings or {}
			opts.servers.vtsls.settings.typescript = opts.servers.vtsls.settings.typescript or {}
			opts.servers.vtsls.settings.typescript.preferences = {
				preferTypeOnlyAutoImports = true,
			}
			-- Add root_dir configuration
			opts.servers.vtsls.root_dir = function(fname)
				return require("lspconfig.util").find_git_ancestor(fname)
					or require("lspconfig.util").find_node_modules_ancestor(fname)
			end
		end,
	},

	-- ############
	-- ### Rust ###
	-- ############
	{ import = "lazyvim.plugins.extras.lang.rust" },

	-- ##############
	-- ### Kotlin ###
	-- ##############
	{ import = "lazyvim.plugins.extras.lang.kotlin" },
}
