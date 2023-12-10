local M = {}

-- Configs for each LSP
M.server_settings = {
  pyright = {
    python = {
      analysis = {
        diagnosticMode = 'workspace',
        typeCheckingMode = 'off'
      }
    }
  },
  lua_ls = {},
  jsonls = {},
  terraformls = {},
  marksman = {},
  clangd = {},
  docker_compose_language_service = {},
}

M.names = vim.tbl_keys(M.server_settings)

-- Broadcast more supported capabilities (from 'nvim-cmp') to the LSP servers
-- Custom configs for each LSP can be placed here
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.default_setup(server_name)
  require('lspconfig')[server_name].setup {
    capabilities = M.capabilities,
    on_attach = require('plugins.lsp.on_attach'),
    settings = M.server_settings[server_name],
    filetypes = (M.server_settings[server_name] or {}).filetypes,
  }
end

return M

-- vim: ts=2 sts=2 sw=2 et
