local M = { 'williamboman/mason-lspconfig.nvim' }

M.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }
M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = {
  -- Configuration of LSPs
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Configure UI border
      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
  },

  -- Schema definitions for 'jsonls' and 'yamlls'
  { 'b0o/schemastore.nvim' },

  -- Automatically configure lua_ls for neovim development
  { 'folke/neodev.nvim' },
}

-- Function that runs each time an LSP is attached to a buffer
local function on_attach(_, bufnr)
  local bufmap = function(mode, lhs, rhs)
    local opts = { buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, opts)
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
  bufmap('n', 'gs', vim.lsp.buf.signature_help)
  bufmap('n', 'gr', vim.lsp.buf.rename)
  bufmap('n', 'ga', vim.lsp.buf.code_action)
  bufmap('n', 'gl', vim.diagnostic.open_float)
  bufmap('n', 'K', vim.lsp.buf.hover)
  bufmap('n', '[d', vim.diagnostic.goto_prev)
  bufmap('n', ']d', vim.diagnostic.goto_next)
  bufmap('i', '<C-s>', vim.lsp.buf.signature_help)

  -- Remap <C-c> to <Esc> since it does not trigger 'InsertLeave'
  bufmap('i', '<C-c>', '<Esc>')

  -- Remove semantic tokens returned by the LSP since we
  -- rely on tree-sitter
  for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

function M.config()
  local server_settings = {
    rust_analyzer = {},
    tsserver = {},
    bashls = {},
    gopls = {},
    ruff_lsp = {
      capabilities = {
        textDocument = {
          publishDiagnostics = {
            tagSupport = {
              valueSet = { 2 },
            },
          },
        },
      },
    },
    pyright = {
      pyright = {
        disableOrganizeImports = true, -- Using Ruff
      },
      python = {
        analysis = {
          diagnosticMode = 'workspace',
          ignore = { '*' }, -- Using Ruff
          typeCheckingMode = 'off',
        },
      },
    },
    lua_ls = {
      Lua = {
        completion = {
          callSnippet = 'Replace', -- see: https://luals.github.io/wiki/settings/#completion
          keywordSnippet = 'Replace',
        },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
    jsonls = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
    yamlls = {
      yaml = {
        schemaStore = {
          -- Disable built-in schemaStore support
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
    terraformls = {},
    marksman = {},
    clangd = {},
    docker_compose_language_service = {},
  }

  -- Configure 'lua_ls' for neovim development
  require('neodev').setup()

  -- Setup all LSPs
  require('mason-lspconfig').setup({
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup({
          -- Broadcast more supported capabilities (from 'nvim-cmp') to the LSP servers
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          on_attach = on_attach,
          settings = server_settings[server_name],
        })
      end,
    },
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
