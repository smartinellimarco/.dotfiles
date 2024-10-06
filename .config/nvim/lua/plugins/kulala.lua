local M = { 'mistweaverco/kulala.nvim' }

M.event = 'VeryLazy'
M.opts = {}

function M.config(_, opts)
  require('kulala').setup(opts)
  -- TODO: https://github.com/mistweaverco/kulala-fmt/issues/12
end

return M

-- vim: ts=2 sts=2 sw=2 et
