local M = { 'RRethy/vim-illuminate' }

M.opts = {
  delay = 500,
  filetypes_denylist = {
    'nvcheatsheet',
  },
}

function M.config(_, opts)
  require('illuminate').configure(opts)
end
return M

-- vim: ts=2 sts=2 sw=2 et
