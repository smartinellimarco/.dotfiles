-- Function that runs each time an LSP is attached to a buffer
local function on_attach(client, bufnr)

  -- Highlight word under cursor on cursor hold, only if that
  -- capability is supported
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      callback = function()
        pcall(vim.lsp.buf.document_highlight)
      end
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = bufnr,
      callback = function()
        pcall(vim.lsp.buf.clear_references)
      end
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
  bufmap({ 'n', 'x' }, '<leader>i',
    function()
      -- see: https://github.com/neovim/neovim/pull/26549
      vim.lsp.buf.format({ async = true })
    end
  )
  bufmap('n', '<leader>c', vim.lsp.buf.code_action)
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

  -- Automatically configure lua_ls for neovim development
  { 'folke/neodev.nvim', opts = {} },

  -- Floating status updates for LSPs
  { 'j-hui/fidget.nvim', opts = {} },

  -- Automatically install LSPs
  {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    opts = {
      ui = {
        border = 'rounded'
      }
    },
  }
}

function M.config(_, _)
  local lspconfig_ui = require('lspconfig.ui.windows')

  -- Configure borders for hover and signature help
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )

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
      border = 'rounded'
    }
  })

  local mason_lspconfig = require('mason-lspconfig')
  local lspconfig = require('lspconfig')

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
    lua_ls = {
      Lua = {
        completion = {
          callSnippet = "Both" -- Insert placeholders for arguments
        }
      }
    },
    jsonls = {},
    terraformls = {},
    marksman = {},
    clangd = {},
    docker_compose_language_service = {},
    yamlls = {},
  }

  local server_names = vim.tbl_keys(server_settings)

  -- Broadcast more supported capabilities (from 'nvim-cmp') to the LSP servers
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Ensure the servers are installed
  mason_lspconfig.setup({
    ensure_installed = server_names
  })

  -- Setup all LSPs
  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = server_settings[server_name],
        filetypes = (server_settings[server_name] or {}).filetypes,
      }
    end
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
