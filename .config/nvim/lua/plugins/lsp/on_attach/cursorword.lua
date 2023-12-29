local M = {}

function M.setup(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local augroup = vim.api.nvim_create_augroup('cursorword', { clear = false })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      group = augroup,
      callback = function()
        local status, err = pcall(vim.lsp.buf.document_highlight)
        if not status then
          vim.print(err)
        end
      end
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      group = augroup,
      callback = function()
        local status, err = pcall(vim.lsp.buf.clear_references)
        if not status then
          vim.print(err)
        end
      end
    })
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
