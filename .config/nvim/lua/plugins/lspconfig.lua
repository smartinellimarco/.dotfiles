local M = { 'neovim/nvim-lspconfig' }

-- NOTE: nvim-lspconfig cannot start later than BufReadPost
M.event = { 'BufReadPost', 'BufNewFile' }
M.cmd = { 'LspInfo', 'LspStart' }
M.dependencies = {
  'b0o/schemastore.nvim', -- Schema definitions for 'jsonls' and 'yamlls'
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
          format = { enable = true },
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
  for server_name, config in pairs(servers) do
    -- Merge capabilities into the server config
    config.capabilities =
      vim.tbl_deep_extend('force', capabilities, config.capabilities or {})

    require('lspconfig')[server_name].setup(config)
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
