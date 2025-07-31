return {
	"saghen/blink.cmp",
	opts = function(_, opts)
		opts.completion.accept.auto_brackets.enabled = false
		opts.completion.list = { selection = { preselect = false, auto_insert = true } }
	end,
}
