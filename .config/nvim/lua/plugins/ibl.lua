local M = { 'lukas-reineke/indent-blankline.nvim' }

M.event = 'BufReadPost'
M.main = 'ibl'
M.opts = {
  indent = { char = '┊' },
  scope = { enabled = false },
}

function M.config(_, opts)
  require('ibl').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
