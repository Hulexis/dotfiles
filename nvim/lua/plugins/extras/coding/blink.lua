return {
	"saghen/blink.cmp",
	opts = function(_, opts)
		opts.completion.accept = opts.completion.accept or {}
		opts.completion.accept.auto_brackets = opts.completion.accept.auto_brackets or {}
		opts.completion.accept.auto_brackets.enabled = false

		opts.completion.list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		}

		opts.completion.accept.behavior = "insert"

		opts.completion.list.selection.auto_insert = false
	end,
}
