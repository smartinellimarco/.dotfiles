local M = { 'VonHeikemen/lsp-zero.nvim' }

M.branch = 'v3.x'
M.lazy = true
M.config = false

function M.init()
  vim.g.lsp_zero_extend_cmp = 0
  vim.g.lsp_zero_extend_lspconfig = 0
end

return M

-- vim: ts=2 sts=2 sw=2 et
