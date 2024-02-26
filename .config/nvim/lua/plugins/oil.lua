local M = { 'stevearc/oil.nvim' }

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
}
M.opts = {
  keymaps = {
    ['l'] = 'actions.select',
    ['<CR>'] = 'actions.select',
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-x>'] = 'actions.select_split',
    ['h'] = 'actions.parent',
    ['.'] = 'actions.open_cwd',
    ['g.'] = 'actions.toggle_hidden',
    ['<leader>q'] = 'actions.close', -- Act as toggle
  },
  use_default_keymaps = false,
}

function M.config(_, opts)
  require('oil').setup(opts)

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
    end
  })

  vim.keymap.set('n', '<leader>q', require('oil').open)
end

return M

-- vim: ts=2 sts=2 sw=2 et
