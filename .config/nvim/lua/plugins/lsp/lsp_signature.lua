local M = { 'ray-x/lsp_signature.nvim' }

-- This plugin must load after the LSP
M.event = 'VeryLazy'
M.opts = {
  bind = true,
  handler_opts = {
    border = 'rounded'
  },
  hint_enable = false,
  always_trigger = true
}

function M.config(_, opts)
  require('lsp_signature').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
