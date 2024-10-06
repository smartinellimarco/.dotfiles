-- TODO: this is removing the empty buffer after closing
local M = { 'nvim-telescope/telescope.nvim' }

M.event = 'VimEnter'
M.dependencies = {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
}

function M.config()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local actions = require('telescope.actions')

  telescope.setup({
    pickers = {
      -- TODO: https://github.com/sharkdp/fd/issues/1591
      find_files = {
        hidden = true,
      },
      live_grep = {
        additional_args = {
          '--fixed-strings',
        },
      },
    },
    defaults = {
      default_mappings = {
        i = {
          ['<Esc>'] = actions.close,
          ['<C-c>'] = actions.close,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,

          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,
          ['<C-w>'] = { '<C-s-w>', type = 'command' }, -- Delete word

          ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          ['<C-s>'] = actions.toggle_selection,
          ['<C-a>'] = actions.drop_all + actions.select_all,
        },
      },
    },
  })

  telescope.load_extension('fzf')

  vim.keymap.set('n', '<leader>e', builtin.find_files)
  vim.keymap.set('n', '<leader>f', builtin.live_grep)
end

return M

-- vim: ts=2 sts=2 sw=2 et
