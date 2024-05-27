local M = { 'stevearc/oil.nvim' }

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
}
M.opts = {
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['l'] = 'actions.select',
    ['h'] = 'actions.parent',
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-x>'] = 'actions.select_split',
    ['`'] = 'actions.cd',
    ['<leader>o'] = 'actions.close', -- Act as toggle
  },
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  use_default_keymaps = false,
}

function M.config(_, opts)
  local oil = require('oil')

  oil.setup(opts)

  vim.keymap.set('n', '<leader>o', oil.open)
end

return M

-- vim: ts=2 sts=2 sw=2 et
