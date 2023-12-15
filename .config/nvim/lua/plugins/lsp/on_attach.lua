-- TODO: expand snippet using vim native api
-- TODO: split this file into different modules
local M = {}

function M.on_attach(client, bufnr)
  -- See ':h lsp' for more information about default options set
  -- by the LSP client.

  -- Set keymaps only when an LSP attaches
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

  -- Highlight word under cursor if that capability is supported
  -- TODO: missing augroup
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      callback = function()
        print(vim.lsp.buf.document_highlight())
      end
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end

  -- Disable sign column icons
  vim.diagnostic.config({
    signs = false,
    virtual_text = {
      prefix = '◦',
      spacing = 0,
    },
  })

  -- Set icons for completions
  require('plugins.lsp.kind').setup()
end

return M.on_attach

-- vim: ts=2 sts=2 sw=2 et
