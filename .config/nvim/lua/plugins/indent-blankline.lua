local M = { 'lukas-reineke/indent-blankline.nvim' }

-- TODO: add version v3 when it comes out
M.opts = {
  char = '┊',
  show_trailing_blankline_indent = false,
}

function M.config(_, opts)
  require('indent_blankline').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
