return {
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
			window = {
				position = "right",
			},
		},
	},
}
