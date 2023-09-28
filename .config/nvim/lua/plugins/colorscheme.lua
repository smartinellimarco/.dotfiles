local M = { 'aktersnurra/no-clown-fiesta.nvim' }

M.priority = 1000
M.opts = {
  transparent = false
}

function M.config(_, opts)
  require('no-clown-fiesta').setup(opts)
  vim.cmd [[colorscheme no-clown-fiesta]]
end

return M

-- vim: ts=2 sts=2 sw=2 et
