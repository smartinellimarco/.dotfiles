-- TODO: https://github.com/stevearc/oil.nvim/issues/363
local M = { 'stevearc/oil.nvim' }

M.dependencies = { 'nvim-tree/nvim-web-devicons' }
M.opts = {
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['<CR>'] = 'actions.select',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.tcd',
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-x>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-c>'] = 'actions.close',
    ['<leader>o'] = function() end, -- Disable keymap
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
