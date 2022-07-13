local M = {}

M.setup_lsp = function(attach, capabilities)

  local data = vim.loop.os_gethostname();
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = { }

  -- Add work lspservers
  if string.find(data, "work") then
    local tempServers = { "html", "cssls", "clangd", "angularls", "tsserver", "tailwindcss" }

    for _, serversName in ipairs(tempServers) do
      table.insert(servers, serversName)
    end
  end

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
    }
  end
end

return M

