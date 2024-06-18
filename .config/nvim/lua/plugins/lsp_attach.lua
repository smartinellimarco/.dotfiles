-- Function that runs each time an LSP is attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = event.buf, silent = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client then
      return
    end

    -- Configure borders for hover
    vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
        relative = 'cursor',
        silent = true,
      })

    -- Configure borders for signature help
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
        relative = 'cursor',
        silent = true,
      })

    -- Set keymaps
    bufmap('n', 'gd', vim.lsp.buf.definition)
    bufmap('n', 'gD', vim.lsp.buf.declaration)
    bufmap('n', 'gi', vim.lsp.buf.implementation)
    bufmap('n', 'go', vim.lsp.buf.type_definition)
    bufmap('n', 'gR', vim.lsp.buf.references)
    bufmap('n', 'gr', vim.lsp.buf.rename)
    bufmap('n', 'ga', vim.lsp.buf.code_action)
    bufmap('n', 'gO', vim.lsp.buf.outgoing_calls)
    bufmap('n', 'gI', vim.lsp.buf.incoming_calls)
    bufmap('n', 'gl', vim.diagnostic.open_float)
    bufmap({ 'n', 'x' }, 'K', vim.lsp.buf.hover)
    bufmap('n', '[d', vim.diagnostic.goto_prev)
    bufmap('n', ']d', vim.diagnostic.goto_next)
    bufmap('i', '<C-s>', vim.lsp.buf.signature_help)

    -- Remap <C-c> to <Esc> since it does not trigger 'InsertLeave'
    bufmap('i', '<C-c>', '<Esc>')

    -- Enable LSP highlights
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', {
        clear = false,
      })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(detach_event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = 'lsp-highlight',
            buffer = detach_event.buf,
          })
        end,
      })
    end

    -- Enable LSP inlay hints
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable()
    end

    -- TODO: delete this eventually
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
})

return {}

-- vim: ts=2 sts=2 sw=2 et
