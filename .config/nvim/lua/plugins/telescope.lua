-- Both fd and ripgrep respect the '~/.ignore' file used
-- for blacklisting and whitelisting files/directories.
-- Git ignored files are not shown by default.
local M = { 'nvim-telescope/telescope.nvim' }

M.dependencies = {
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  }
}
M.opts = {
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

function M.config(_, opts)
  local builtin = require('telescope.builtin')
  local actions = require('telescope.actions')

  local mappings = {
    i = {
      ['<esc>'] = actions.close,
      ['<C-n>'] = actions.move_selection_next,
      ['<C-p>'] = actions.move_selection_previous,

      ['<CR>'] = actions.select_default,
      ['<C-x>'] = actions.select_horizontal,
      ['<C-v>'] = actions.select_vertical,

      ['<C-u>'] = actions.preview_scrolling_up,
      ['<C-d>'] = actions.preview_scrolling_down,
      ['<C-w>'] = { '<c-s-w>', type = 'command' }, -- Delete word
    }
  }
  -- TODO: extend table and do not overwrite defaults
  require('telescope').setup({ opts, defaults = { default_mappings = mappings } })
  require('telescope').load_extension('fzf')

  -- Show line numbers in the preview
  vim.api.nvim_command("autocmd User TelescopePreviewerLoaded setlocal number")

  vim.keymap.set('n', '<leader>e', builtin.find_files, {})
  vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
end

return M

-- vim: ts=2 sts=2 sw=2 et
