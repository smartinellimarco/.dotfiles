local M = { 'stevearc/conform.nvim' }

M.event = 'VeryLazy'
M.opts = {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
  },
}

function M.config(_, opts)
  local conform = require('conform')

  conform.setup(opts)

  vim.keymap.set({ 'n', 'x' }, '<leader>i', function()
    conform.format({
      lsp_fallback = true,
      quiet = true,
    })
  end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
