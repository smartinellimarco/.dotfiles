local M = {}

function M.setup(bufnr)
  local bufmap = function(mode, lhs, rhs)
    local opts = { buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  bufmap('n', 'K', vim.lsp.buf.hover)
  bufmap('n', 'gd', vim.lsp.buf.definition)
  bufmap('n', 'gD', vim.lsp.buf.declaration)
  bufmap('n', 'gi', vim.lsp.buf.implementation)
  bufmap('n', 'go', vim.lsp.buf.type_definition)
  bufmap('n', 'gr', vim.lsp.buf.references)
  bufmap('n', 'gs', vim.lsp.buf.signature_help)
  bufmap('n', '<leader>r', vim.lsp.buf.rename)
  bufmap({ 'n', 'x' }, '<leader>i',
    function()
      -- see: https://github.com/neovim/neovim/pull/26549
      vim.lsp.buf.format({ async = true })
    end
  )
  bufmap('n', '<leader>c', vim.lsp.buf.code_action)
  bufmap('n', 'gl', vim.diagnostic.open_float)
  bufmap('n', '[d', vim.diagnostic.goto_prev)
  bufmap('n', ']d', vim.diagnostic.goto_next)
  bufmap('i', '<C-s>', vim.lsp.buf.signature_help)
end

return M

-- vim: ts=2 sts=2 sw=2 et
