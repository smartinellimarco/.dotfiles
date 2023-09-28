local M = { 'NvChad/nvim-colorizer.lua' }

M.opts = {}

function M.config(_, opts)
  require('colorizer').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
