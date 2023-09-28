local M = { 'nvim-telescope/telescope.nvim' }

M.tag = '0.1.3'
M.dependencies = {
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  }
}
M.opts = {
  defaults = {
    file_ignore_patterns = {
      '.git/.*',
      '.venv/.*',
      -- '!.env' TODO: fix
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    diagnostics = {
      initial_mode = 'normal'
    }
  }
}

function M.config(_, opts)
  local builtin = require('telescope.builtin')

  require('telescope').setup(opts)

  vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>e', builtin.find_files, {})
end

return M

-- vim: ts=2 sts=2 sw=2 et
