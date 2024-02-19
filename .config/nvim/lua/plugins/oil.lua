local M = { 'stevearc/oil.nvim' }

M.dependencies = {
  'nvim-tree/nvim-web-devicons',
}
M.opts = {
  keymaps = {
    ["l"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-x>"] = "actions.select_split",
    ["h"] = "actions.parent",
    ["."] = "actions.open_cwd",
    ["g."] = "actions.toggle_hidden",
    ["<leader>o"] = "actions.close", -- Act as toggle
  },
  use_default_keymaps = false,
}

function M.config(_, opts)
  require('oil').setup(opts)
  vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
end

return M

-- vim: ts=2 sts=2 sw=2 et
