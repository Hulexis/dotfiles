return {
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
}
