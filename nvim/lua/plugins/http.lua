return {
	{ import = "lazyvim.plugins.extras.util.rest" },
	{
		"mistweaverco/kulala.nvim",
		ft = "http",
		keys = {
			{ "<leader>r", "", desc = "+Rest" },
			{ "<leader>rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
			{ "<leader>rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
			{ "<leader>rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
			{ "<leader>rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
			{
				"<leader>re",
				"<cmd>lua require('kulala').set_selected_env()<cr>",
				desc = "Select environment for http request",
			},
		},
		opts = {
			default_winbar_panes = { "body", "headers", "headers_body", "script_output" },
			winbar = true,
		},
		config = function()
			require("kulala.api").on("after_request", function(data)
				local success, parsed_json = pcall(vim.fn.json_decode, data.body)

				local body_to_display
				if success then
					body_to_display = require("utils.ui").pretty_print_json(parsed_json)
				else
					body_to_display = data.body
				end

				require("utils.ui").set_last_response(body_to_display)

				require("utils.ui").create_floating_window(body_to_display)
			end)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local nvim_lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local servers = {
				"kulala_ls",
			}
			for _, lsp in ipairs(servers) do
				if nvim_lsp[lsp] ~= nil then
					if nvim_lsp[lsp].setup ~= nil then
						nvim_lsp[lsp].setup({
							capabilities = capabilities,
						})
					else
						vim.notify("LSP server " .. lsp .. " does not have a setup function", vim.log.levels.ERROR)
					end
				end
			end
		end,
	},
}
