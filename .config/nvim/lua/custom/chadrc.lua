-- Just an example, supposed to be placed in /lua/custom/

local pluginConfs = require "custom.plugins.configs";
local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
   theme = "catppuccin",
}

M.plugins = {
  user = require "custom.plugins",
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
  override = {
   ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter
  }
}

M.options = {
  user = function()
    require("custom.options")
  end,
}

M.mappings = require "custom.mappings"

return M
