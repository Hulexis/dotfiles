-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufLeave", {
	-- group = config_autocmds,
	pattern = "*",
	callback = function(events)
		local ft = vim.api.nvim_buf_get_option(events.buf, "filetype")
		if ft == "TelescopePrompt" then
			require("utils.ui").save_picker_state(events.buf)
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = false -- use tabs instead of spaces
		vim.opt_local.shiftwidth = 2 -- visual width of indent
		vim.opt_local.tabstop = 2 -- how wide a tab appears
	end,
})
