local M = { 'neovim/nvim-lspconfig' }
-- TODO: omnifunc completion keybindings and snippets support.
-- TODO: reorder lsp files and improve code structure

-- Lazy load when one of these commands are called
M.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }
M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = {

  -- LSP manager
  { import = 'plugins.lsp.mason' },

}

function M.config(_, _)
  local lspconfig = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')
  local lsp_utils = require('plugins.lsp.utils')

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Exclude the 'semanticTokensProvider' capability provided by the LSP server
    -- from Neovim's client to prevent conflicts with treesitter semantic highlights.
    -- Even though both provide highlights, treesitter works better in most scenarios.
    client.server_capabilities.semanticTokensProvider = nil

    -- Set sign icons
    lsp_utils.sign_icons()

    -- Set keymaps only when an LSP attaches
    lsp_utils.lsp_keymaps(bufnr)
  end

  vim.diagnostic.config({
    virtual_text = false, -- Disable virtual text
    signs = false,        -- Disable sign column icons
  })

  local servers = {
    pyright = {
      python = {
        analysis = {
          diagnosticMode = 'workspace',
          typeCheckingMode = 'basic'
        }
      }
    },
    lua_ls = {}, -- The file '.luarc.json' configures 'lua_ls' for neovim's path
    jsonls = {},
    terraformls = {},
    marksman = {},
    clangd = {},
    docker_compose_language_service = {},

  }
  -- Ensure the servers are installed
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers)
  })

  -- Broadcast more supported capabilities (from 'nvim-cmp') to the LSP servers
  local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  -- Custom configs for each LSP can be placed here
  mason_lspconfig.setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end,
  }
end

return M

-- vim: ts=2 sts=2 sw=2 et
