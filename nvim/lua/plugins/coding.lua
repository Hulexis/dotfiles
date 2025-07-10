local luasnip_fix_augroup = vim.api.nvim_create_augroup("MyLuaSnipHistory", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		if
			((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
			and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require("luasnip").session.jump_active
		then
			require("luasnip").unlink_current()
		end
	end,
	group = luasnip_fix_augroup,
})

return {
	{ "notjedi/nvim-rooter.lua" },
	{ "echasnovski/mini.pairs", enabled = false },
	{ "echasnovski/mini.surround" },

	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.completion.accept.auto_brackets.enabled = false
			opts.completion.list = { selection = { preselect = false, auto_insert = true } }
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		--   lazy = false,
		config = function()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
			require("luasnip").config.setup({
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
		end,
	},
}
