local M = {}

M.setup_lsp = function(attach, capabilities)

  local hostName = vim.loop.os_gethostname();
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = { "pyright", "sumneko_lua", "html", "cssls", "tsserver", "tailwindcss", "eslint" }


  local computerServers = {}

  if string.find(hostName, "work") then
    computerServers = { "html", "cssls", "clangd", "angularls", "tsserver", "tailwindcss", "csharp_ls" }
  end

  if string.find(hostName, "home") then
    computerServers = { "hls" }
  end

  -- Add work lspservers
  for _, serversName in ipairs(computerServers) do
    table.insert(servers, serversName)
  end

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
    }
  end
end

return M

