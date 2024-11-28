local M = { 'williamboman/mason-lspconfig.nvim' }

-- NOTE: nvim-lspconfig can not start later than BufReadPost
M.event = { 'BufReadPost', 'BufNewFile' }
M.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }
M.dependencies = {
  -- Helper plugin for configuring LSPs
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Configure UI border
      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
  },

  -- Schema definitions for 'jsonls' and 'yamlls'
  { 'b0o/schemastore.nvim' },
}

function M.config()
  local servers = {
    rust_analyzer = {},
    ts_ls = {},
    bashls = {},
    gopls = {
      settings = {
        gopls = {
          gofumpt = true,
        },
      },
    },
    terraformls = {},
    marksman = {},
    docker_compose_language_service = {},
    clangd = {
      capabilities = {
        offsetEncoding = { 'utf-16' },
      },
    },
    ruff = {},
    pyright = {
      settings = {
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
    },
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace', -- see: https://luals.github.io/wiki/settings/#completion
            keywordSnippet = 'Replace',
          },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    },
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    },
    yamlls = {
      settings = {
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
    },
  }

  -- Capabilities for 'nvim-cmp'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Setup all LSPs
  require('mason-lspconfig').setup({
    handlers = {
      function(server_name)
        local server = servers[server_name]

        -- Merge capabilities
        server.capabilities = vim.tbl_deep_extend(
          'force',
          {},
          capabilities,
          server.capabilities or {}
        )

        require('lspconfig')[server_name].setup(server)
      end,
    },
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
