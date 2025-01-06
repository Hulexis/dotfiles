local Util = require("lazyvim.util")

return {
	{ import = "lazyvim.plugins.extras.editor.harpoon2" },
	{ import = "lazyvim.plugins.extras.editor.dial" },
	{ import = "lazyvim.plugins.extras.editor.fzf" },
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-dap.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
				require("telescope").load_extension("dap")
				require("telescope").load_extension("rest")
			end,
		},
		opts = {
			defaults = {
				file_ignore_patterns = {
					"^.git/",
					"^node_modules/",
				},
				mappings = {
					n = {
						["<leader>cl"] = require("utils.ui").open_diagnostics,
					},
					i = {
						["<C-p>"] = require("telescope.actions.layout").toggle_preview,
						["<esc>"] = require("utils.ui").close_picker,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
				},
				live_grep = {
					only_sort_text = true,
				},
				diagnostics = {
					line_width = "full",
					layout_strategy = "vertical",
				},
			},
		},
	},

	{
		"stevearc/overseer.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function(_, opts)
			require("overseer").setup({
				strategy = {
					"toggleterm",
					use_shell = false,
					direction = nil,
					highlights = nil,
					auto_scroll = true,
					close_on_exit = true,
					quit_on_exit = "never",
					open_on_start = false,
					hidden = false,
					on_create = nil,
				},
				task_list = {
					direction = "bottom",
					min_height = 40,
					default_detail = 1,
				},
				components = {
					-- Add `auto_scroll` to the list of components
					"default",
					"auto_scroll",
				},
			})
			require("lualine").setup({
				sections = {
					lualine_x = { "overseer" },
				},
			})
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			close_if_last_window = true,
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			source_selector = {
				winbar = false,
				statusline = false,
			},
		},
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>E", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
			{ "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer explorer",
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
				},
			})

			local float_handler = function(term)
				if vim.fn.mapcheck("jk", "t") ~= "" then
					vim.api.nvim_buf_del_keymap(term.bufnr, "t", "jk")
					vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
				end
			end

			local Terminal = require("toggleterm.terminal").Terminal

			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				hidden = true,
				direction = "float",
				on_open = float_handler,
			})

			local tig = Terminal:new({
				cmd = "tig",
				dir = "git_dir",
				hidden = true,
				direction = "float",
				on_open = float_handler,
			})

			local htop = Terminal:new({
				cmd = "htop",
				hidden = true,
				direction = "float",
				on_open = float_handler,
			})

			vim.api.nvim_create_user_command("Htop", function()
				htop:toggle()
			end, {})

			vim.api.nvim_create_user_command("Lazygit", function()
				lazygit:toggle()
			end, {})

			vim.api.nvim_create_user_command("Tig", function()
				tig:toggle()
			end, {})

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			function _TIG_TOGGLE()
				tig:toggle()
			end

			function _HTOP_TOGGLE()
				htop:toggle()
			end
		end,
		keys = {
			{ "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Terminal lazygit" },
			{ "<leader>th", "<cmd>lua _HTOP_TOGGLE()<CR>", desc = "Terminal htop" },
			{ "<leader>tt", "<cmd>lua _TIG_TOGGLE()<CR>", desc = "Terminal tig" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"angular",
				"bash",
				"fish",
				"html",
				"javascript",
				"json",
				"hjson",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
				"dart",
				"rust",
				"css",
				"graphql",
				"go",
				"xml",
				"http",
				"pkl",
				"c_sharp",
				-- "swift", -- Disabled was to laggy
			},
			indent = {
				enable = true,
				disable = { "dart", "swift" },
			},
		},
	},

	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			defaults = {
				["<leader>d"] = { name = "+debug" },
			},
		},
	},
}
