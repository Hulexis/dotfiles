return {
	"quolpr/quicktest.nvim",
	config = function()
		local qt = require("quicktest")

		qt.setup({
			adapters = {
				require("quicktest.adapters.vitest")({}),
				require("quicktest.adapters.golang")({}),
				require("quicktest.adapters.dart")({}),
				require("quicktest.adapters.playwright")({}),
			},
			default_win_mode = "popup",
			use_experimental_colorizer = true,
			use_baleia = true,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"m00qek/baleia.nvim",
	},
	keys = {
		{
			"<leader>tr",
			function()
				local qt = require("quicktest")
				qt.run_line()
			end,
			desc = "[T]est [R]un",
		},
		{
			"<leader>tR",
			function()
				local qt = require("quicktest")

				qt.run_file()
			end,
			desc = "[T]est [R]un file",
		},
		{
			"<leader>td",
			function()
				local qt = require("quicktest")

				qt.run_dir()
			end,
			desc = "[T]est Run [D]ir",
		},
		{
			"<leader>ta",
			function()
				local qt = require("quicktest")

				qt.run_all()
			end,
			desc = "[T]est Run [A]ll",
		},
		{
			"<leader>tp",
			function()
				local qt = require("quicktest")

				qt.run_previous()
			end,
			desc = "[T]est Run [P]revious",
		},
		{
			"<leader>tt",
			function()
				local qt = require("quicktest")

				qt.toggle_win("popup")
			end,
			desc = "[T]est [T]oggle popup window",
		},
		{
			"<leader>ts",
			function()
				local qt = require("quicktest")

				qt.toggle_win("split")
			end,
			desc = "[T]est Toggle [S]plit window",
		},
	},
}
