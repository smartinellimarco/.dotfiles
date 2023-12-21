local M = { 'stevearc/dressing.nvim' }

M.opts = {}

function M.config(_, opts)
  require('dressing').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
