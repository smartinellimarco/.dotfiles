local M = { 'lewis6991/gitsigns.nvim' }

M.opts = {
  current_line_blame = true,
  yadm = {
    enable = true
  }
}

function M.config(_, opts)
  require('gitsigns').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
