local M = { 'stevearc/oil.nvim' }

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
}
M.opts = {
  view_options = {
    show_hidden = true,
  },
  -- TODO: consider adding more once I change the keyboard
  keymaps = {
    ['l'] = 'actions.select',
    ['<CR>'] = 'actions.select',
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-x>'] = 'actions.select_split',
    ['h'] = 'actions.parent',
    ['.'] = 'actions.open_cwd',
    ['<leader>o'] = 'actions.close', -- Act as toggle
  },
  skip_confirm_for_simple_edits = true,
  use_default_keymaps = false,
}

function M.config(_, opts)
  local oil = require('oil')

  oil.setup(opts)

  -- Change cwd when opening neovim with a directory
  -- argument
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function(args)
      if args.file ~= '' then
        local path = string.gsub(args.file, '^oil://', '')
        if vim.fn.isdirectory(path) ~= 0 then
          vim.api.nvim_set_current_dir(path)
        end
      end
    end,
  })

  vim.keymap.set('n', '<leader>o', oil.open)
end

return M

-- vim: ts=2 sts=2 sw=2 et
