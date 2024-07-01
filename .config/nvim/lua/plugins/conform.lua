local M = { 'stevearc/conform.nvim' }

M.event = { 'BufReadPre', 'BufNewFile' }
M.opts = {
  notify_on_error = false,
  formatters_by_ft = {
    -- FIXME: this does not respect '.prettierrc'
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    lua = { 'stylua' },
    json = { 'prettierd' },
  },
}

function M.config(_, opts)
  local conform = require('conform')

  conform.setup(opts)

  -- FIXME: replicate native 'gw' and 'gq'
  -- FIXME: guess indent after the async format
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
