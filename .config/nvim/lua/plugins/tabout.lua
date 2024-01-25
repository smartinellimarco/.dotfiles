local M = { 'abecodes/tabout.nvim' }

M.event = 'InsertEnter'
M.opts = {
  tabkey = '<Tab>',
  backwards_tabkey = '<S-Tab>',
  act_as_tab = true,
  act_as_shift_tab = false,
  default_tab = '<C-t>',
  default_shift_tab = '<C-d>',
  enable_backwards = true,
  completion = false,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' }
  },
  ignore_beginning = true,
  exclude = {},
}

function M.config(_, opts)
  require('tabout').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
