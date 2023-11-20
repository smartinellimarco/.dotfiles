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
  defaults = {
    wrap_results = true -- TODO: this does not work
  },
  pickers = {
    find_files = {
      hidden = true
    },
    diagnostics = {
      disable_coordinates = true
    }
    -- TODO: this should include declarations, code actions etc. Check if able to integrate them
    -- TODO: remove some keymaps
    -- TODO: fix what we do with the diagnostics picker
  }
}

function M.config(_, opts)
  local builtin = require('telescope.builtin')

  require('telescope').setup(opts)
  require('telescope').load_extension('fzf')

  -- Show line numbers in the preview
  vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"

  vim.keymap.set('n', '<leader>e', builtin.find_files, {})
  vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
end

return M

-- vim: ts=2 sts=2 sw=2 et
