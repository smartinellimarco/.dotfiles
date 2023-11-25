local M = { 'kylechui/nvim-surround' }

M.version = '*'
M.event = 'InsertEnter'
M.opts = {}

function M.config(_, opts)
  require('nvim-surround').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
