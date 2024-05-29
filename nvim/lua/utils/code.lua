local M = {}

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if next(clients) == nil then
		print("No active LSP client for the current buffer")
		return
	end

	for _, client in pairs(clients) do
		if client.server_capabilities.inlayHintProvider then
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			if enabled then
				vim.lsp.inlay_hint.enable(false)
				print("Inlay hints disabled")
			else
				vim.lsp.inlay_hint.enable(true)
				print("Inlay hints enabled")
			end
			return
		end
	end

	print("Inlay hints not supported by the current LSP server")
end

return M
