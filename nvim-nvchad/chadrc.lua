local M = {}

M.plugins = "custom.plugins"

M.ui = {
  -- theme stuff
  theme = "nightfox",
  theme_toggle = { "onedark", "one_light" },

  -- highlight groups!
  hl_add = require("custom.highlights").new_hlgroups,
  hl_override = require("custom.highlights").overriden_hlgroups,
}

M.mappings = require "custom.mappings"

return M
