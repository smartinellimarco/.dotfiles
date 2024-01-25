local M = { 'hrsh7th/nvim-cmp' }

M.event = 'InsertEnter'
M.dependencies = {

  -- Snippet engine
  { 'L3MON4D3/LuaSnip' },

  -- Snippet collection (vscode)
  { 'rafamadriz/friendly-snippets' },

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
}

function M.config(_, _)
  local cmp = require('cmp')
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
    performance = {
      max_view_entries = 10
    },
    completion = {
      completeopt = 'menu,menuone,noinsert' -- Only affects nvim-cmp
    },
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
      { name = 'buffer' },
      { name = 'nvim_lua' },
      { name = 'path' },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    mapping = {
      -- If no item is selected, do not auto-select the first one on '<CR>'
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),

      -- Do not fallback to disable i_CTRL-N and i_CTRL-P
      ['<C-n>'] = cmp.mapping(
        function(_)
          if cmp.visible() then
            -- Do not replace word under cursor
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
      ['<C-p>'] = cmp.mapping(
        function(_)
          if cmp.visible() then
            -- Do not replace word under cursor
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      ['<C-e>'] = cmp.mapping.abort(),
    }
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
