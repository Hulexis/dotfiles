local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local hostName = vim.loop.os_gethostname();
local lspconfig = require "lspconfig"

-- lspservers with default config
local servers = { "pyright", "lua_ls", "html", "cssls", "tsserver", "tailwindcss", "eslint", "gopls" }


local computerServers = {}

if string.find(hostName, "work") then
  computerServers = { "html", "cssls", "clangd", "angularls", "tsserver", "tailwindcss", "csharp_ls", "dartls" }
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
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
