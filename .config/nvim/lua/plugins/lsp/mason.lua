local M = { 'williamboman/mason.nvim' }

M.lazy = false
M.dependencies = { 'williamboman/mason-lspconfig.nvim' }
M.opts = {
  ui = {
    border = 'rounded'
  }
}

function M.config(_, opts)
  require('mason').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
