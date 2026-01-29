return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
			-- custom_handlers = {
			-- 	markdown_inline = { extends = true, parse = render_dashes },
			-- },
			bullet = {
				icons = { "•", "◦", "▪" },
				right_pad = 1,
			},
			checkbox = {
				enabled = true,
				render_modes = false,
				bullet = false,
				left_pad = 0,
				right_pad = 1,
				unchecked = {
					icon = "󰄱 ",
					highlight = "RenderMarkdownUnchecked",
					scope_highlight = nil,
				},
				checked = {
					icon = "󰱒 ",
					highlight = "RenderMarkdownChecked",
					scope_highlight = nil,
				},
				custom = {
					todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
				},
				scope_priority = nil,
			},
		},
		ft = { "markdown", "Avante" },
	},
}
