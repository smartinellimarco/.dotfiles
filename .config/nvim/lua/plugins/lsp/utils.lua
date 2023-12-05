local M = {}

function M.lsp_keymaps(bufnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr })
  vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { buffer = bufnr })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr })
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = bufnr })
end

function M.sign_icons()
  vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignError', text =  '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignError', text = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignError', text = '', numhl = '' })
end

return M

-- vim: ts=2 sts=2 sw=2 et
