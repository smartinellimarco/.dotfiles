local M = { 'ggandor/leap.nvim' }

M.opts = {
  safe_labels = {},
}

function M.config(_, opts)
  require('leap').setup(opts)

  vim.keymap.set({ 'x', 'o', 'n' }, 's', '<Plug>(leap)')
  vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
end

return M

-- vim: ts=2 sts=2 sw=2 et
