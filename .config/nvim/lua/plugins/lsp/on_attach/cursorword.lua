local M = {}

function M.setup(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local augroup = vim.api.nvim_create_augroup('cursorword', {})

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = augroup,
      callback = function()
        local _, _ = pcall(vim.lsp.buf.document_highlight)
      end
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      group = augroup,
      callback = function()
        local _, _ = pcall(vim.lsp.buf.clear_references)
      end
    })
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
