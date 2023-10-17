-- TODO: check for TS source?
return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- TODO: Add ':' '/' and '?' triggers
    dependencies = {

      -- Snippet engine
      {
        'L3MON4D3/LuaSnip',
        dependencies = {

          -- Snippet collection (vscode)
          { 'rafamadriz/friendly-snippets' },
        },

        -- Lazy load snippets to engine
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end
      },

      -- Display function signature while typing
      { "ray-x/lsp_signature.nvim" },

      -- Icons for the menu
      { 'onsails/lspkind.nvim' },

      -- Source for the LSP and extra capabilities
      { 'hrsh7th/cmp-nvim-lsp' },

      -- Source for the snippet engine.
      { 'saadparwaiz1/cmp_luasnip' },

      -- Source for buffers
      { 'hrsh7th/cmp-buffer' },

      -- Source for paths
      { 'hrsh7th/cmp-path' },

      -- Source for nvim lua functions
      { 'hrsh7th/cmp-nvim-lua' },

      -- Source for cmdline and search
      { 'hrsh7th/cmp-cmdline' },

    },

    -- Setup cmp
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local luasnip = require('luasnip')
      local cmp_action = require('lsp-zero').cmp_action()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local signature = require('lsp_signature')

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format()
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'path' },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = 'path' } },
          { { name = 'cmdline' } }
        )
      })

      signature.setup({
        bind = true,
        handler_opts = {
          border = "rounded"
        },
        hint_enable = false
      })
    end
  }
}

-- vim: ts=2 sts=2 sw=2 et
