-- Function that runs each time an LSP is attached to a buffer
local function on_attach(client, bufnr)
  -- Highlight word under cursor on cursor hold, only if that
  -- capability is supported
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      callback = function()
        pcall(vim.lsp.buf.document_highlight)
      end,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      callback = function()
        pcall(vim.lsp.buf.clear_references)
      end,
    })
  end

  -- Set keymaps
  local bufmap = function(mode, lhs, rhs)
    local opts = { buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  bufmap('n', 'K', vim.lsp.buf.hover)
  bufmap('n', 'gd', vim.lsp.buf.definition)
  bufmap('n', 'gD', vim.lsp.buf.declaration)
  bufmap('n', 'gi', vim.lsp.buf.implementation)
  bufmap('n', 'go', vim.lsp.buf.type_definition)
  bufmap('n', 'gr', vim.lsp.buf.references)
  bufmap('n', 'gs', vim.lsp.buf.signature_help)
  bufmap('n', '<leader>r', vim.lsp.buf.rename)
  bufmap('n', '<leader>c', vim.lsp.buf.code_action)
  bufmap({ 'n', 'x' }, '<leader>i', function()
    require('conform').format({
      lsp_fallback = true,
      quiet = true,
    })
  end)
  bufmap('n', 'gl', vim.diagnostic.open_float)
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

local M = { 'neovim/nvim-lspconfig' }

-- Lazy load when one of these commands are called
M.cmd = { 'LspInfo', 'LspInstall', 'LspStart' }
M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = {

  -- LSP and formatter registry
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },

  -- Auto installation of mason elements
  { 'WhoIsSethDaniel/mason-tool-installer.nvim', lazy = false },

  -- Configuration of LSPs
  { 'williamboman/mason-lspconfig.nvim' },

  -- Configuration of formatters
  { 'stevearc/conform.nvim' },

  -- Schema definitions for 'jsonls' and 'yamlls'
  { 'b0o/schemastore.nvim' },

  -- Automatically configure lua_ls for neovim development
  { 'folke/neodev.nvim', opts = {} },
}

function M.config(_, _)
  local lspconfig_ui = require('lspconfig.ui.windows')

  -- Configure borders for hover and signature help
  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

  -- Configure UI border
  lspconfig_ui.default_options.border = 'rounded'

  -- Disable sign column icons
  vim.diagnostic.config({
    signs = false,
    virtual_text = {
      prefix = '◦',
      spacing = 0,
    },
    float = {
      border = 'rounded',
    },
  })

  local mason_installer = require('mason-tool-installer')
  local mason_lspconfig = require('mason-lspconfig')
  local lspconfig = require('lspconfig')
  local conform = require('conform')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')

  -- Configs for each LSP
  local server_settings = {
    -- LSPs
    gopls = {},
    pyright = {
      python = {
        analysis = {
          diagnosticMode = 'workspace',
          typeCheckingMode = 'off',
        },
      },
    },
    lua_ls = {
      Lua = {
        completion = {
          callSnippet = 'Both', -- Insert placeholders for arguments
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

  local formatter_settings = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
  }

  local ensure_installed = vim.list_extend(
    vim.tbl_keys(server_settings),
    vim.tbl_flatten(vim.tbl_values(formatter_settings))
  )

  -- Ensure the servers are installed
  mason_installer.setup({ ensure_installed = ensure_installed })

  -- Setup all LSPs
  mason_lspconfig.setup({
    handlers = {
      function(server_name)
        lspconfig[server_name].setup({
          -- Broadcast more supported capabilities (from 'nvim-cmp') to the LSP servers
          capabilities = cmp_nvim_lsp.default_capabilities(),
          on_attach = on_attach,
          settings = server_settings[server_name],
        })
      end,
    },
  })

  -- Setup all formatters
  conform.setup({
    formatters_by_ft = formatter_settings,
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
