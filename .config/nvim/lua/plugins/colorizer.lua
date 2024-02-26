local M = { 'norcalli/nvim-colorizer.lua' }

function M.config(_, _)
  require('colorizer').setup()
end

return M

-- vim: ts=2 sts=2 sw=2 et
