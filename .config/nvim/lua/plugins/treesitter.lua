local M = { 'nvim-treesitter/nvim-treesitter' }

M.lazy = false -- Lazy loading treesitter may produce errors
M.build = ':TSUpdate'
M.opts = {
  ensure_installed = 'all',
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader><leader>',
      node_incremental = '<leader>',
    }
  }
}

function M.config(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
