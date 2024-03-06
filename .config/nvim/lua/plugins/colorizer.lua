local M = { 'norcalli/nvim-colorizer.lua' }

function M.config(_, _)
  -- Do not use an empty table as argument for
  -- this plugin
  require('colorizer').setup()
end

return M

-- vim: ts=2 sts=2 sw=2 et
