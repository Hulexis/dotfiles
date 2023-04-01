local M = {}

M.autotag = function()
  local present, autotag = pcall(require, "nvim-ts-autotag")

  if present then
    autotag.setup()
  end
end

M.shade = function()
  local present, shade = pcall(require, "shade")

  if not present then
    return
  end

  shade.setup({
    overlay_opacity = 50,
    opacity_step = 1,
    exclude_filetypes = { "NvimTree" },
  })
end

M.autoSave = function()
  local present, autoSave = pcall(require, "auto-save")

  if present then
    autoSave.setup()
  end
end

M.autoSession = function()
  local present, autoSession = pcall(require, "auto-session")

  if present then
    autoSession.setup()
  end
end

M.sessionLens = function()
  local present, sessionLens = pcall(require, "session-lens")

  if present then
    sessionLens.setup()
  end
end

M.treesitterAngular = function()
  local present, treesitterAngular = pcall(require, "nvim-treesitter-angular")

  if present then
    treesitterAngular.setup()
  end
end

M.flutter = function ()
  local present, flutter = pcall(require, "nvim-dap-ui")

  if present then
    flutter.setup({
        debugger = {
          enabled = true,
        }
    })
  end
end

M.workspaces = function ()
  local present, workspaces = pcall(require, "workspaces")

  if present then
    workspaces.setup({})
    end
end

M.hop = function ()
  local present, htop = pcall(require, "hop")

  if present then
    htop.setup({})
    end
end

return M
