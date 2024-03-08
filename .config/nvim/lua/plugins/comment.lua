local M = { 'numToStr/Comment.nvim' }

M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' }
M.opts = {}

function M.config(_, opts)
  require('Comment').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
