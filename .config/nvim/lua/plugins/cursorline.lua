local M = { 'yamatsum/nvim-cursorline' }

M.opts = {
  cursorline = {
    enable = true,
    timeout = 0,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}

function M.config(_, opts)
  require('nvim-cursorline').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
