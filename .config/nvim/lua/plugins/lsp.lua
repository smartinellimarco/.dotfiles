return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,

    -- Disable automatic setup, we are doing it manually
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {
      ui = {
        border = "rounded"
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      local telescope = require('telescope.builtin')

      -- This adds the cmp capabilities to the lsp servers
      -- Also enables the '.set_server_config' function
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        vim.keymap.set('n', 'gd', telescope.lsp_definitions, { buffer = bufnr })
        vim.keymap.set('n', 'gl', telescope.diagnostics, { buffer = bufnr })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr })
        vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, { buffer = bufnr })
      end)

      -- Disable semantic highlights to avoid conflicts with treesitter
      -- Even though both provide highlights, treesitter works better in
      -- most scenarios.
      lsp_zero.set_server_config({
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      -- Floating messages turned off
      vim.diagnostic.config({
        virtual_text = false,
      })

      -- Icons for diagnostics
      lsp_zero.set_sign_icons({
        error = '',
        warn = '',
        hint = '',
        information = '',
      })

      -- Ensure the servers are installed
      require('mason-lspconfig').setup({
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
            require('lspconfig').lua_ls.setup(lua_opts)
          end,

          -- Setup a less strict pyright
          pyright = function()
            require('lspconfig').pyright.setup({
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
  }
}

-- vim: ts=2 sts=2 sw=2 et
