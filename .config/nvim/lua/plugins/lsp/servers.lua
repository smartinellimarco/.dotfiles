local M = {}

-- Configs for each LSP
local server_settings = {
  pyright = {
    python = {
      analysis = {
        diagnosticMode = 'workspace',
        typeCheckingMode = 'off'
      }
    }
  },
  lua_ls = {}, -- TODO: review the config file. Add formatting
  jsonls = {},
  terraformls = {},
  marksman = {},
  clangd = {},
  docker_compose_language_service = {},
  yamlls = {},
}

M.names = vim.tbl_keys(server_settings)

-- Broadcast more supported capabilities (from 'nvim-cmp') to the LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.default_setup(server_name)
  require('lspconfig')[server_name].setup {
    capabilities=capabilities,
    on_attach = require('plugins.lsp.on_attach'),
    settings = server_settings[server_name],
    filetypes = (server_settings[server_name] or {}).filetypes,
  }
end

return M

-- vim: ts=2 sts=2 sw=2 et
