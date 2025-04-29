local M = { 'stevearc/conform.nvim' }

M.event = 'BufReadPost'
M.cmd = 'ConformInfo'
M.opts = {
  notify_on_error = false,
  formatters_by_ft = {
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    lua = { 'stylua' },
    go = { 'gofumpt' },
  },
}

function M.config(_, opts)
  local conform = require('conform')

  conform.setup(opts)

  -- TODO: range formatting for 0.11
  -- TODO: https://github.com/NMAC427/guess-indent.nvim/issues/21
  vim.keymap.set({ 'n', 'x' }, 'gq', function()
    conform.format({
      async = true,
      lsp_format = 'fallback',
      quiet = true,
    })
  end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
