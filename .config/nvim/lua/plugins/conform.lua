local M = { 'stevearc/conform.nvim' }

M.event = { 'BufReadPre', 'BufNewFile' }
M.opts = {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
}

function M.config(_, opts)
  local conform = require('conform')

  conform.setup(opts)

  vim.keymap.set({ 'n', 'x' }, 'gq', function()
    conform.format({
      async = true,
      lsp_fallback = true,
      quiet = true,
    })
  end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
