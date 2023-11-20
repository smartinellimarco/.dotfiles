local M = { 'hrsh7th/nvim-cmp' }

M.event = 'InsertEnter'
M.dependencies = {

  -- Snippet engine
  { 'L3MON4D3/LuaSnip' },

  -- Snippet collection (vscode)
  { 'rafamadriz/friendly-snippets' },

  -- Tabout functionality
  { 'abecodes/tabout.nvim' },

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
}

function M.config(_, _)
  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')
  local snippet_loader = require('luasnip.loaders.from_vscode')

  -- Lazy load snippet collection
  snippet_loader.lazy_load()

  -- Add parenthesis when completing a function
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  -- Setup 'cmp'
  cmp.setup({
    formatting = {
      format = lspkind.cmp_format() -- Add icons to completion items
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
      ['<Tab>'] = cmp_action.luasnip_next_or_expand(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab()
    })
  })

  -- Ensure that the 'treesitter' and 'cmp' plugins are set up before configuring 'tabout'.
  require('tabout').setup()
end

return M

-- vim: ts=2 sts=2 sw=2 et
