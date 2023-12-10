local M = {}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = vim.lsp.omnifunc()

  -- TODO: set kind icons
  -- Set keymaps only when an LSP attaches
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

  -- Disable sign column icons
  vim.diagnostic.config({
    signs = false,
    virtual_text = {
      prefix = '◦',
      spacing = 0,
    },
  })
end

return M.on_attach

-- vim: ts=2 sts=2 sw=2 et
