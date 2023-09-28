local M = { 'kwkarlwang/bufjump.nvim' }

M.opts = {}

function M.config(_, opts)
  require('bufjump').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
