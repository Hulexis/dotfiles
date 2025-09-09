return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	keys = function()
		local ls = require("luasnip")
		return {
			-- Jump forward (or expand) with Tab
			{
				"<Tab>",
				function()
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					else
						return "<Tab>"
					end
				end,
				mode = { "i", "s" },
				expr = true,
				silent = true,
			},
			-- Jump backward with Shift-Tab
			{
				"<S-Tab>",
				function()
					if ls.jumpable(-1) then
						ls.jump(-1)
					else
						return "<S-Tab>"
					end
				end,
				mode = { "i", "s" },
				expr = true,
				silent = true,
			},
			-- Cycle choices (optional)
			{
				"<C-l>",
				function()
					if ls.choice_active() then
						ls.change_choice(1)
					end
				end,
				mode = { "i", "s" },
				silent = true,
			},
		}
	end,
	config = function()
		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
		require("luasnip").config.setup({
			update_events = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})
	end,
}
