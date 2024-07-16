local M = { 'abecodes/tabout.nvim' }

M.dependencies = { 'nvim-treesitter/nvim-treesitter' }
M.event = 'InsertEnter'
M.opts = {
  act_as_tab = false,
  act_as_shift_tab = false,
  enable_backwards = true,
  completion = false,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' },
  },
  exclude = {},
}

function M.config(_, opts)
  require('tabout').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
