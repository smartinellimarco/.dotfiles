local M = {}

function M.setup(bufnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set({ 'n', 'x' }, '<leader>i', function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr })
  vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { buffer = bufnr })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr })
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = bufnr })
end

return M

-- vim: ts=2 sts=2 sw=2 et
