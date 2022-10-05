local overrides = require("custom.plugins.overrides")

return {

  ----------------------------------------- default plugins ------------------------------------------

  -- Dashboard
  ["goolord/alpha-nvim"] = {
    disable = false,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.plugins.lspconfig")
    end,
  },

  -- -- override default configs
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
      require("custom.plugins.general").autotag()
    end,
  },

  ["andreadev-it/shade.nvim"] = {
    module = "shade",
    config = function()
      require("custom.plugins.general").shade()
    end,
  },

  ["rmagatti/auto-session"] = {
    module = "auto",
    config = function()
      require("custom.plugins.general").autoSession()
    end,
  },

  ["Pocco81/auto-save.nvim"] = {
    module = "autosave",
    config = function()
      require("custom.plugins.general").autosave()
    end,
  },

  ["rmagatti/session-lens"] = {
    module = "session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("custom.plugins.general").sessionLens()
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls")
    end,
  },

  -- Temporarly disabled because of errors
  --
  -- ["nvim-treesitter/nvim-treesitter-angular"] = {
  --   after = "nvim-treesitter",
  --   config = function()
  --     require("custom.plugins.general").treesitterAngular()
  --   end,
  -- },
}
