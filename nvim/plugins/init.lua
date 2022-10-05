local overrides = require "custom.plugins.overrides"

return {

  ----------------------------------------- default plugins ------------------------------------------

  -- Dashboard
  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  -- override default configs
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    override_options = overrides.blankline,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  --------------------------------------------- custom plugins ----------------------------------------------

  -- autoclose tags in html, jsx etc
  ["windwp/nvim-ts-autotag"] = {
    ft = { "html", "javascriptreact" },
    after = "nvim-treesitter",
    config = function()
      require("custom.plugins.smolconfigs").autotag()
    end,
  },

  -- dim inactive windows
  ["andreadev-it/shade.nvim"] = {
    module = "shade",
    config = function()
      require("custom.plugins.smolconfigs").shade()
    end,
  },

  ["Pocco81/auto-save.nvim"] = {
    module = "autosave",
    config = function()
      require("custom.plugins.smolconfigs").autosave()
    end,
  },

  -- ["jose-elias-alvarez/null-ls.nvim"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require "custom.plugins.null-ls"
  --   end,
  -- },

  ["akinsho/toggleterm.nvim"] = {
    module = "toggleterm",
    tag = "v2.*",
    config = function()
      require "custom.plugins.smolconfigs"
    end,
  },

  ["f-person/git-blame.nvim"] = {
    module = "auto-session",
    config = function()
      require("custom.plugins.smolconfigs").autoSession()
    end,
  },

  ["rmagatti/auto-session"] = {
    module = "auto",
    config = function()
      require("custom.plugins.smolconfigs").autoSession()
    end,
  },

  ["rmagatti/session-lens"] = {
    module = "session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("custom.plugins.smolconfigs").sessionLens()
    end,
  },

  -- ["nvim-treesitter/nvim-treesitter-angular"] = {
  --   after = "nvim-treesitter",
  --   config = function()
  --     require("custom.plugins.smolconfigs").treesitterAngular()
  --   end,
  -- },
}
