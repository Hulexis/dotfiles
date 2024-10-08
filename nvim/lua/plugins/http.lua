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

			local function create_floating_window(content)
				-- Define the size and position of the floating window
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.8)
				local row = math.floor((vim.o.lines - height) / 2)
				local col = math.floor((vim.o.columns - width) / 2)

				-- Create a new buffer
				local buf = vim.api.nvim_create_buf(false, true)

				-- Set the buffer content to the JSON data
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))

				-- Open the floating window with the buffer
				local win = vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					width = width,
					height = height,
					row = row,
					col = col,
					style = "minimal",
					border = "rounded",
				})

				-- Enable JSON syntax highlighting with Tree-sitter
				vim.api.nvim_buf_set_option(buf, "filetype", "json")

				-- Set keybindings to close the window
				vim.api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>bd!<CR>", { noremap = true, silent = true })
			end

			-- Helper function to pretty print a Lua table (parsed JSON)
			local function pretty_print_json(value)
				return vim.fn.system("jq '.'", vim.fn.json_encode(value)) -- Use jq for pretty printing
			end

			require("kulala.api").on("after_request", function(data)
				-- Try to decode the JSON body
				local success, parsed_json = pcall(vim.fn.json_decode, data.body)

				-- If the body is valid JSON, format it as a pretty string
				local body_to_display
				if success then
					body_to_display = pretty_print_json(parsed_json)
				else
					body_to_display = data.body -- fallback to raw body if not JSON
				end

				-- Create the floating window and show the formatted JSON
				create_floating_window(body_to_display)
			end)
		end,
	},
}
