-- TODO: jump to sibling/parent/child
local M = { 'nvim-treesitter/nvim-treesitter' }

-- WARNING: Lazy loading 'nvim-treesitter' may produce errors
M.lazy = false
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
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = '<A-o>',
      node_decremental = '<A-i>',
    },
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
        ['aa'] = '@assignment.outer',
        ['ia'] = '@assignment.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
        [']l'] = '@loop.outer',
        [']i'] = '@conditional.outer',
        [']a'] = '@assignment.outer',
        [']s'] = '@call.outer',
        [']p'] = '@parameter.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
        ['[l'] = '@loop.outer',
        ['[i'] = '@conditional.outer',
        ['[a'] = '@assignment.outer',
        ['[s'] = '@call.outer',
        ['[p'] = '@parameter.outer',
      },
    },
  },
}

function M.config(_, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
