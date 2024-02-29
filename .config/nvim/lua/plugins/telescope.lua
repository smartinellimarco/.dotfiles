local M = { 'nvim-telescope/telescope.nvim' }

M.dependencies = {
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
}
M.opts = {
  pickers = {
    find_files = {
      hidden = true,
    },
  },
}

function M.config(_, opts)
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local actions = require('telescope.actions')

  local mappings = {
    defaults = {
      default_mappings = {
        i = {
          ['<Esc>'] = actions.close,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,

          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,
          ['<C-w>'] = { '<C-s-w>', type = 'command' }, -- Delete word

          ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          ['<C-s>'] = actions.toggle_selection,
          ['<C-a>'] = actions.drop_all + actions.select_all,
        },
      },
    },
  }

  telescope.setup(vim.tbl_deep_extend('error', opts, mappings))
  telescope.load_extension('fzf')

  -- Show line numbers in the preview
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TelescopePreviewerLoaded',
    callback = function()
      vim.opt_local.number = true
    end,
  })

  vim.keymap.set('n', '<leader>e', builtin.find_files, {})
  vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>wd', builtin.diagnostics, {})
end

return M

-- vim: ts=2 sts=2 sw=2 et
