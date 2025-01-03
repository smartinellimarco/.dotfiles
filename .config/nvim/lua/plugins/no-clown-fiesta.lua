local M = { 'aktersnurra/no-clown-fiesta.nvim' }

M.dev = true
M.lazy = false
M.priority = 1000
M.opts = {}

function M.config(_, opts)
  require('no-clown-fiesta').setup(opts)

  vim.cmd('colorscheme no-clown-fiesta')
end

return M

-- vim: ts=2 sts=2 sw=2 et
