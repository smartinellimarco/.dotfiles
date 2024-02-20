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
          ['<C-w>'] = { '<c-s-w>', type = 'command' }, -- Delete word
        }
      }
    }
  }

  telescope.setup(vim.tbl_deep_extend('error', opts, mappings))
  telescope.load_extension('fzf')

  -- Show line numbers in the preview
  local augroup = vim.api.nvim_create_augroup('telescope', {})

  vim.api.nvim_create_autocmd('User', {
    pattern = 'TelescopePreviewerLoaded',
    group = augroup,
    callback = function()
      vim.opt_local.number = true
    end
  })

  -- Cache the current pickers input until a new one is used
  local _last_picker = nil
  local function wrap_builtin(func)
    local function wrapper()
      if func == _last_picker then
        builtin.resume()
      else
        _last_picker = func
        func()
      end
    end
    return wrapper
  end

  vim.keymap.set('n', '<leader>e', wrap_builtin(builtin.find_files), {})
  vim.keymap.set('n', '<leader>f', wrap_builtin(builtin.live_grep), {})
end

return M

-- vim: ts=2 sts=2 sw=2 et
