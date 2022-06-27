local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.nmap(lhs, rhs)
  M.map('n', lhs, rhs)
end

function M.imap(lhs, rhs)
  M.map('i', lhs, rhs)
end

return M

