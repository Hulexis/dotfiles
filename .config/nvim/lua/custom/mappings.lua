local M = {}

M.toggleterm = {
  n = {
    ["<C-t>"] = { "nnoremap <silent><c-t> <Cmd>exe v:count1 . 'ToggleTerm'<CR>" }
  }
}

return M
