local M = {}

function M.on_attach(client, bufnr)
  local cursorword = require('plugins.lsp.on_attach.cursorword')
  local keymaps = require('plugins.lsp.on_attach.keymaps')
  local highlights = require('plugins.lsp.on_attach.highlights')

  -- Highlight word under cursor if that capability is supported
  cursorword.setup(client, bufnr)

  -- Set keymaps only when an LSP attaches
  keymaps.setup(bufnr)

  -- Disable semantic highlighting
  highlights.setup(client)
end

return M.on_attach

-- vim: ts=2 sts=2 sw=2 et
