return {
   -- Dashboard
   ["goolord/alpha-nvim"] = {
      disable = false,
   },

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

   ["Pocco81/AutoSave.nvim"] = {
      module = "autosave",
      config = function()
         require("custom.plugins.smolconfigs").autosave()
      end,
   },

   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
   },

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
}
