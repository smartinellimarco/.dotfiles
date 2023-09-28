local M = { 'windwp/nvim-autopairs' }

M.event = 'InsertEnter'
M.opts = {}

function M.config(_, opts)
  require('nvim-autopairs').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
