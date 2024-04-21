local M = { 'nvim-treesitter/nvim-treesitter' }

M.lazy = false -- Lazy loading treesitter may produce errors
M.build = ':TSUpdate'
M.dependencies = 'nvim-treesitter/nvim-treesitter-textobjects'
M.opts = {
  ensure_installed = 'all',
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['ap'] = '@parameter.outer',
        ['ip'] = '@parameter.inner',
        ['as'] = '@call.outer',
        ['is'] = '@call.inner',
      },
    },
  },
}

function M.config(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
