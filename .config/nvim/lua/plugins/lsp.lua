local M = { 'neovim/nvim-lspconfig' }

-- Lazy load when one of these commands are called
M.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }
M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = {

  -- LSP manager
  { import = 'plugins.lsp.mason' },

}

function M.config(_, _)
  local mason_lspconfig = require('mason-lspconfig')
  local servers = require('plugins.lsp.servers')

  -- Ensure the servers are installed
  mason_lspconfig.setup({
    ensure_installed = servers.names
  })

  mason_lspconfig.setup_handlers({ servers.default_setup })
end

return M

-- vim: ts=2 sts=2 sw=2 et
