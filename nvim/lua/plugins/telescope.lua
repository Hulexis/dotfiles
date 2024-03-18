return {
	{
		"telescope.nvim",
		commit = "1fa3b801f034caa609e2570cd2e422cf9416819c",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-dap.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
				require("telescope").load_extension("dap")
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
}
