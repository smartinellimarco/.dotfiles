local M = { 'neovim/nvim-lspconfig' }

M.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }
M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = {

  -- LSP manager
  { import = 'plugins.lsp.mason' },

  -- Helper LSP setup tool
  { import = 'plugins.lsp.lsp_zero' },

}

function M.config(_, _)
  local lsp_zero = require('lsp-zero')
  local lspconfig = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')

  -- This adds the cmp capabilities to the lsp servers
  -- Also enables the '.set_server_config' function
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(
    function(_, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
    end
  )

  -- Disable semantic highlights to avoid conflicts with treesitter
  -- Even though both provide highlights, treesitter works better in
  -- most scenarios.
  lsp_zero.set_server_config({
    on_init = function(client)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })

  vim.diagnostic.config({
    virtual_text = {
      prefix = '◦', -- Change icon
      spacing = 0,
    },
    signs = false, -- Disable sign column icons
  })

  -- Icons for diagnostics
  lsp_zero.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    information = '',
  })

  -- Ensure the servers are installed
  mason_lspconfig.setup({
    ensure_installed = {
      'lua_ls',
      'jsonls',
      'terraformls',
      'marksman',
      'pyright',
      'clangd',
      'docker_compose_language_service',
    },
    handlers = {

      -- Configs for each LSP can be placed here

      -- Setup lua_ls with neovim API compatibility
      -- using lsp_zero options for lspconfig
      lua_ls = function()
        local lua_opts = lsp_zero.nvim_lua_ls()
        lspconfig.lua_ls.setup(lua_opts)
      end,

      -- Setup a less strict pyright
      pyright = function()
        lspconfig.pyright.setup({
          settings = {
            python = {
              analysis = {
                diagnosticMode = 'workspace',
                typeCheckingMode = 'off'
              }
            }
          }
        })
      end,

      -- Use the default setup on the remaining servers
      lsp_zero.default_setup,

    }
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
